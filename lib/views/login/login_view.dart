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
                  child: _signInText('Sign in'),
                ),
                const SizedBox(height: 30),
                // ElevatedButton(
                //   child: const Text('Open route'),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const RegisterView(),
                //       ),
                //     );
                //   },
                // ),
                // GestureDetector(
                //   child: const Text('Sign up'),
                //   onTap: () {
                //     setState(() {
                //       boolValue = !boolValue;
                //     });
                //   },
                //   onDoubleTap: () => print('clicked twice'),
                // ),
                const BasicTextFormField(
                  initialValue: '',
                  hintText: 'Email or User Name',
                  prefixIcon: MyImages.user,
                  withShadow: true,
                ),
                const SizedBox(height: 30),
                const BasicTextFormField(
                  initialValue: '',
                  hintText: 'Password',
                  prefixIcon: MyImages.password,
                  suffixIcon: MyImages.eye,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: _forgetPasswordText(),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Sign in', style: TextStyle(color: MyColors.white)),
                  ),
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
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: MyColors.purple1,
    ),
  );
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
