import 'package:dsw_52745/services/shared_preferences_service.dart';
import 'package:dsw_52745/services/sqlite_service.dart';
import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:dsw_52745/views/widgets/task_tile.dart';
import 'package:dsw_52745/views/widgets/edit_task_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String userName = '';
  List<Map<String, dynamic>> tasks = [
    {
      'name': 'Task 1',
      'description': 'Description 1',
      'dueDate': DateTime.now(),
    },
    {
      'name': 'Task 2',
      'description': 'Description 2',
      'dueDate': DateTime.now(),
    },
    {
      'name': 'Task 3',
      'description': 'Description 3',
      'dueDate': DateTime.now(),
    },

  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    late final prefsService = SharedPreferencesService();
    await prefsService.initPrefs();
    final loggedUser = await prefsService.getLoggedUser();
    print('loggedUser: $loggedUser');
    if (loggedUser.isEmpty) {
      print('No user logged in');
      Navigator.pop(context);
      return;
    }

    final sqliteService = SQLiteService();
    final userTasks = await sqliteService.getUserTasks(loggedUser);
    setState(() {
      userName = loggedUser;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _showTaskDialog({int? index}) {
    final isEditing = index != null;
    final task = isEditing ? tasks[index] : null;

    final initialName = task != null ? task['name'] as String : '';
    final initialDescription = task != null ? task['description'] as String : '';
    final initialDueDate = task != null ? task['dueDate'] as DateTime : DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTaskDialog(
          initialName: initialName,
          initialDescription: initialDescription,
          initialDueDate: initialDueDate,
          isEditing: isEditing,
          onSave: (name, description, dueDate) {
            setState(() {
              final newTask = {
                'name': name,
                'description': description,
                'dueDate': dueDate,
              };
              if (isEditing) {
                tasks[index] = newTask;
              } else {
                tasks.add(newTask);
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 62),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go back'),),
              ),
              const SizedBox(
                height: 30,
              ),
              Text('Hello $userName!', style: TextStyle(fontSize: 24, color: MyColors.purple1),),
              const SizedBox(
                height: 30,
              ),
              Text('Your tasks:', style: TextStyle(fontSize: 18, color: MyColors.purple1),),
              const SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                onPressed: _showTaskDialog,
                backgroundColor: MyColors.purple3,
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Column(
                  children: tasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final task = entry.value;
                    return taskTile(
                      title: task['name'] as String,
                      description: task['description'] as String,
                      dueDate: task['dueDate'] as DateTime,
                      onDelete: () => deleteTask(index),
                      onEdit: () => _showTaskDialog(index: index),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
