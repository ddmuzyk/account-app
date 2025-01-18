import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:flutter/material.dart';
import 'package:dsw_52745/views/widgets/header_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
                const SizedBox(height: 101),
                Align(
                  alignment: Alignment.centerLeft,
                  child: headerText('Sign up'),
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
                fontWeight: FontWeight.w400)),
      ],
    ),
  );
}
