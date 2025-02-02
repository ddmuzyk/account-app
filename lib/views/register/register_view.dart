import 'package:dsw_52745/services/shared_preferences_service.dart';
import 'package:dsw_52745/services/sqlite_service.dart';
import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/home/home_view.dart';
import 'package:dsw_52745/views/widgets/basic_button.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
import 'package:dsw_52745/views/widgets/form_warning.dart';
import 'package:dsw_52745/views/widgets/header_text.dart';
import 'package:dsw_52745/views/widgets/navigation_text.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String fullName = '';
  String email = '';
  String password = '';
  String confirmedPassword = '';

  bool isNameWarningVisible = false;
  bool isEmailWarningVisible = false;
  bool isPasswordWarningVisible = false;
  bool isConfirmedPasswordWarningVisible = false;

  bool isConfirmedPasswordValid() {
    final isValid = password == confirmedPassword;
    return isValid;
  }
  void onNameWarning({required bool b}) {
    setState(() {
      isNameWarningVisible = b;
    });
  }

  void onEmailWarning({required bool b}) {
    setState(() {
      isEmailWarningVisible = b;
    });
  }

  void onPasswordWarning({required bool b}) {
    setState(() {
      isPasswordWarningVisible = b;
    });
  }

  void onConfirmedPasswordWarning({required bool b}) {
    setState(() {
      isConfirmedPasswordWarningVisible = b;
    });
  }

  void onFullNameChange(String newName) {
    setState(() {
      fullName = newName;
    });
    onNameWarning(b: false);
  }

  Future<void> onEmailChange(String newEmail) async {
    setState(() {
      email = newEmail;
    });
    onEmailWarning(b: false);
  }

  void onPasswordChange(String newPassword) {
    setState(() {
      password = newPassword;
    });
    onPasswordWarning(b: false);
  }

  void onConfirmedPasswordChange(String newConfirmedPassword) {
    setState(() {
      confirmedPassword = newConfirmedPassword;
    });
    onConfirmedPasswordWarning(b: false);
  }

  Future<void> onSignUp() async {
    if (fullName.isEmpty) {
      onNameWarning(b: true);
      return;
    } else if (email.isEmpty) {
      onEmailWarning(b: true);
      return;
    } else if (password.isEmpty) {
      onPasswordWarning(b: true);
      return;
    } else if (confirmedPassword.isEmpty) {
      onConfirmedPasswordWarning(b: true);
      return;
    }
    final isPasswordMatch = isConfirmedPasswordValid();
    if (!isPasswordMatch) {
      onConfirmedPasswordWarning(b: true);
      return;
    }
    final newUser = User(name: fullName, email: email, password: password);
    final sqlLite = SQLiteService();
    try {
      final registeredUser = await sqlLite.insertUser(newUser);
      if (registeredUser != null) {
        final prefsService = SharedPreferencesService();
        await prefsService.initPrefs();
        await prefsService.setLoggedUser(registeredUser);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 59),
                _backButton(context),
                const SizedBox(height: 70),
                Align(
                  alignment: Alignment.centerLeft,
                  child: headerText('Sign up'),
                ),
                const SizedBox(height: 46),
                BasicTextFormField(
                  hintText: 'Full Name',
                  prefixIcon: MyImages.user,
                  onChange: onFullNameChange,
                ),
                formWarning(text: 'Provide a valid name', isVisible: isNameWarningVisible),
                BasicTextFormField(
                  hintText: 'Email',
                  prefixIcon: MyImages.email,
                  onChange: onEmailChange,
                ),
                formWarning(text: 'Provide a valid email', isVisible: isEmailWarningVisible),
                BasicTextFormField(
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                  onChange: onPasswordChange,
                ),
                formWarning(text: 'Provide a valid password', isVisible: isPasswordWarningVisible),
                BasicTextFormField(
                  hintText: 'Confirm Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                  onChange: onConfirmedPasswordChange,
                ),
                formWarning(text: 'Passwords do not match', isVisible: isConfirmedPasswordWarningVisible),
                const SizedBox(height: 80),
                basicButton(text: 'Sign up', onPressed: onSignUp),
                const SizedBox(height: 60),
                navigationText(
                  text: 'Already have an account?',
                  navigableText: ' Sign in',
                  onTap: () {
                    Navigator.pop(context);
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

Widget _backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Row(
      children: [
        Image.asset(MyImages.backArrow),
        Text(
          'Back',
          style: TextStyle(
            fontSize: 12,
            color: MyColors.purple1,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
