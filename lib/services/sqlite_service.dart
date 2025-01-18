import 'package:dsw_52745/constants.dart' as constants;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;

  User({
    required this.id,
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
      onCreate: (db, version) {
        db..execute(
          'CREATE TABLE ${constants.usersTable}(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        )
        ..execute(
          'CREATE TABLE ${constants.tasksTable}(id INTEGER PRIMARY KEY, userId INTEGER, name TEXT, description TEXT, dateCreated TEXT, FOREIGN KEY(userId) REFERENCES users(id))',
        );
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(constants.usersTable, user.toMap(), conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return db.query(constants.usersTable);
  }
}
