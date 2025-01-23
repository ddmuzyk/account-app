import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:dsw_52745/views/home/home_view.dart';
import 'package:dsw_52745/views/register/register_view.dart';
import 'package:dsw_52745/views/widgets/basic_button.dart';
import 'package:dsw_52745/views/widgets/basic_text_form_field.dart';
import 'package:dsw_52745/views/widgets/header_text.dart';
import 'package:dsw_52745/views/widgets/navigation_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                const BasicTextFormField(
                  hintText: 'Email or User Name',
                  prefixIcon: MyImages.user,
                  withShadow: true,
                ),
                const SizedBox(height: 40),
                const BasicTextFormField(
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: _forgetPasswordText(),
                ),
                const SizedBox(height: 40),
                basicButton(text: 'Sign in', onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                },),
                const SizedBox(height: 170),
                navigationText(
                  text: "Don't have account?",
                  navigableText: ' Sign up',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterView()),
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
