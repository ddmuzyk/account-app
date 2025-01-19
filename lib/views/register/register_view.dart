import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/widgets/basic_button.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
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
                  onChange: (String val) {
                    setState(() {
                      fullName = val;
                      print(fullName);
                    });
                  },
                ),
                const SizedBox(height: 40),
                const BasicTextFormField(
                  hintText: 'Email',
                  prefixIcon: MyImages.email,
                ),
                const SizedBox(height: 40),
                const BasicTextFormField(
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                ),
                const SizedBox(height: 40),
                const BasicTextFormField(
                  hintText: 'Confirm Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                ),
                const SizedBox(height: 80),
                basicButton('Sign up'),
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
