import 'package:dsw_52745/services/shared_preferences_service.dart';
import 'package:dsw_52745/services/sqlite_service.dart';
import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/home/home_view.dart';
import 'package:dsw_52745/views/register/register_view.dart';
import 'package:dsw_52745/views/widgets/basic_button.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
import 'package:dsw_52745/views/widgets/form_warning.dart';
import 'package:dsw_52745/views/widgets/header_text.dart';
import 'package:dsw_52745/views/widgets/navigation_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String login = '';
  String password = '';
  bool isInvalidLogin = false;

  void onInvalidLogin({required bool b}) {
    setState(() {
      isInvalidLogin = b;
    });
  }

  void onLoginChange(String newLogin) {
    setState(() {
      login = newLogin;
    });
    onInvalidLogin(b: false);
  }

  void onPasswordChange(String newPassword) {
    setState(() {
      password = newPassword;
    });
    onInvalidLogin(b: false);
  }

  Future<void> onSignIn() async {
    if (login.isEmpty) {
      print('No login provided');
      return;
    } else if (password.isEmpty) {
      print('No password provided');
      return;
    }

    final sqliteService = SQLiteService();
    final user = await sqliteService.signIn(login, password);
    if (user == null) {
      onInvalidLogin(b: true);
      return;
    }
    final prefsService = SharedPreferencesService();
    await prefsService.initPrefs();
    await prefsService.setLoggedUser(user);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 62),
                Image.asset(MyImages.logo),
                const SizedBox(height: 21),
                Align(
                  alignment: Alignment.centerLeft,
                  child: headerText('Sign in'),
                ),
                const SizedBox(height: 46),
                BasicTextFormField(
                  hintText: 'Email or User Name',
                  prefixIcon: MyImages.user,
                  withShadow: true,
                  onChange: onLoginChange,
                ),
                const SizedBox(height: 40),
                BasicTextFormField(
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                  onChange: onPasswordChange,
                ),
                formWarning(text: 'Invalid login or password', isVisible: isInvalidLogin),
                Align(
                  alignment: Alignment.centerRight,
                  child: _forgetPasswordText(),
                ),
                const SizedBox(height: 40),
                basicButton(
                  text: 'Sign in',
                  onPressed: onSignIn,
                ),
                const SizedBox(height: 170),
                navigationText(
                  text: "Don't have account?",
                  navigableText: ' Sign up',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterView(),),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _forgetPasswordText() {
  return Text(
    'Forget Password?',
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: MyColors.purple1,
    ),
  );
}
