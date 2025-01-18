import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/material.dart';

Widget basicButton(String text) {
  return SizedBox(
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
      child: Text(text,
        style: TextStyle(color: MyColors.white),),
    ),
  );
}
