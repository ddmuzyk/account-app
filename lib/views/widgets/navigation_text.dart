import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget navigationText({
  required String text,
  required String navigableText,
  required GestureTapCallback onTap,
}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: TextStyle(color: MyColors.purple1, fontSize: 15),
      children: [
        TextSpan(
          text: navigableText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = onTap,
        ),
      ],
    ),
  );
}
