import 'package:dsw_52745/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:dsw_52745/views/home/home_view.dart';
import 'package:dsw_52745/services/shared_preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsService = SharedPreferencesService();
  await prefsService.initPrefs();
  final isLoggedIn = await prefsService.getLoggedUser();

  runApp(MaterialApp(
    title: 'dsw_52745',
    debugShowCheckedModeBanner: false,
    home: isLoggedIn.isNotEmpty ? const HomeView() : const LoginView(),
  ),);
}
