import 'package:dsw_52745/utils/my_colors.dart';
import 'package:dsw_52745/utils/my_images.dart';
import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final String prefixIcon;
  final String? suffixIcon;
  final bool withShadow;

  const BasicTextFormField({required this.initialValue, required this.hintText, required this.prefixIcon, super.key, this.withShadow = false, this.suffixIcon});


  @override
  Widget build(BuildContext context) {
    final List<Shadow> shadow = withShadow ? [Shadow(color: MyColors.black.withAlpha(25), blurRadius: 4, offset: const Offset(0, 4))] : [];

    return SizedBox(
      height: 50,
      child: TextFormField(
        initialValue: '',
        decoration: InputDecoration(
          prefixIcon: Image.asset(prefixIcon),
          suffixIcon: suffixIcon != null ? Image.asset(suffixIcon!) : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 15, color: MyColors.grey, shadows: shadow),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.purple2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
