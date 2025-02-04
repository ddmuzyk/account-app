import 'package:dsw_52745/constants.dart' as constants;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final Null id = null;
  final String name;
  final String email;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

class Task {
  final Null id = null;
  final String userName;
  final String name;
  final String description;
  final DateTime dueDate;

  Task({
    required this.userName,
    required this.name,
    required this.description,
    required this.dueDate,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}

class SQLiteService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE ${constants.usersTable} (id INTEGER PRIMARY KEY , name TEXT UNIQUE NOT NULL, email TEXT UNIQUE NOT NULL, password TEXT)',
        );
        await db.execute(
          'CREATE TABLE ${constants.tasksTable} (id INTEGER PRIMARY KEY, userName TEXT NOT NULL, name TEXT UNIQUE, description TEXT, dueDate DATE, FOREIGN KEY(userName) REFERENCES users(name))',
        );
      },
    );
  }

  Future<String?> insertUser(User user) async {
    final db = await database;
    try {
      await db.insert(constants.usersTable, user.toMap(), conflictAlgorithm: ConflictAlgorithm.rollback);
      return user.name;
    } catch (e) {
      print('Error inserting user: $e');
      return null;
    }
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(constants.tasksTable, task.toMap(), conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      constants.tasksTable,
      {
        'description': task.description,
        'dueDate': task.dueDate.toIso8601String(),
      },
      where: 'name = ? AND userName = ?',
      whereArgs: [task.name, task.userName],
    );
  }

  Future<void> deleteTask(String taskName, String userName) async {
    final db = await database;
    await db.delete(
      constants.tasksTable,
      where: 'name = ? AND userName = ?',
      whereArgs: [taskName, userName],
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    final users = await db.query(constants.usersTable);
    return users;
  }

  Future<List<Map<String, dynamic>>> getUserTasks(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query(
      constants.tasksTable,
      columns: ['name', 'description', 'dueDate'],
      where: 'userName = ?',
      whereArgs: [username],
    );
    return tasks.map((task) {
      return {
        'name': task['name'],
        'description': task['description'],
        'dueDate': DateTime.parse(task['dueDate'] as String),
      };
    }).toList();
  }

  Future<String?> signIn(String login, String password) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> users = await db.query(
        constants.usersTable,
        where: '(email = ? OR name = ?) AND password = ?',
        whereArgs: [login, login, password],
      );

      if (users.isNotEmpty) {
        final userMap = users.first;
        return userMap['name'] as String;
      } else {
        print('No user found with the provided credentials.');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  Future<void> _deleteExistingDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
  }
}
