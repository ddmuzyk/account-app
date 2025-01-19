import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/widgets/basic_button.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
import 'package:dsw_52745/views/widgets/header_text.dart';
import 'package:dsw_52745/views/widgets/navigation_text.dart';
import 'package:dsw_52745/services/sqlite_service.dart';
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

  bool isConfirmedPasswordValid(){
    final isValid = password == confirmedPassword;
    print('Is confirmed password valid: $isValid');
    return password == confirmedPassword;
  }

  void onFullNameChange(String newName){
    setState(() {
      fullName = newName;
      print('fullName: $fullName');
    });
  }

  void onEmailChange(String newEmail){
    setState(() {
      email = newEmail;
    });
  }

  void onPasswordChange(String newPassword){
    setState(() {
      email = newPassword;
    });
  }

  void onConfirmedPasswordChange(String newConfirmedPassword) {
    setState(() {
      confirmedPassword = newConfirmedPassword;
    });
  }

  void onSignUp() {
    if (fullName.isEmpty) {
      print('No fullName provided');
      return;
    } else if (email.isEmpty) {
      print('No email provided');
      return;
    } else if (password.isEmpty) {
      print('No password provided');
      return;
    } else if (confirmedPassword.isEmpty) {
      print('No confirmed password provided');
      return;
    }
    final isPasswordMatch = isConfirmedPasswordValid();
    if (!isPasswordMatch) {
      print('Password need to match');
      return;
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
                const SizedBox(height: 40),
                BasicTextFormField(
                  hintText: 'Email',
                  prefixIcon: MyImages.email,
                  onChange: onEmailChange,
                ),
                const SizedBox(height: 40),
                BasicTextFormField(
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                  onChange: onPasswordChange,
                ),
                const SizedBox(height: 40),
                BasicTextFormField(
                  hintText: 'Confirm Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                  onChange: onConfirmedPasswordChange,
                ),
                const SizedBox(height: 80),
                basicButton(text: 'Sign up', onPressed: isConfirmedPasswordValid),
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
        Text('Back',
            style: TextStyle(
                fontSize: 12,
                color: MyColors.purple1,
                fontWeight: FontWeight.w400,),),
      ],
    ),
  );
}
