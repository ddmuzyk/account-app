import 'package:flutter/material.dart';

Widget formWarning({
  required String text,
  required bool isVisible,
}) {
  return SizedBox(
    height: 40,
    child: Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: TextStyle(
          color: isVisible ? Colors.red : Colors.transparent,
        ),
      ),
    ),
  );
}
