import 'package:dsw_52745/services/shared_preferences_service.dart';
import 'package:dsw_52745/services/sqlite_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String userName = '';
  List<Map<String, dynamic>> tasks = [];

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
      tasks = userTasks;
    });
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
              Text('Hello $userName!'),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Go back'),),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Column(
                  children: tasks.map((task) {
                    return Card(
                      child: ListTile(
                        title: Text(task['name'] as String),
                        subtitle: Text(task['description'] as String),
                      ),
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
