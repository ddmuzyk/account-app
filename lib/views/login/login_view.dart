import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/register/register_view.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    var boolValue = false;

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
                const SizedBox(height: 30),
                Align(
                    alignment: Alignment.centerLeft,
                    child: _signInText('Sign in')),
                ElevatedButton(
                  child: const Text('Open route'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterView(),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  child: const Text('Sign up'),
                  onTap: () {
                    setState(() {
                      boolValue = !boolValue;
                    });
                  },
                  onDoubleTap: () => print('clicked twice'),
                ),
                const BasicTextFormField(
                  initialValue: '',
                  hintText: 'Email or User Name',
                  withShadow: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _signInText(String text) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: MyColors.purple1,
    ),
  );
}
