import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final bool withShadow;

  const BasicTextFormField({required this.initialValue, required this.hintText, super.key, this.withShadow = false});


  @override
  Widget build(BuildContext context) {
    final List<Shadow> shadow = withShadow ? [Shadow(color: MyColors.black.withAlpha(25), blurRadius: 4, offset: const Offset(0, 4))] : [];

    return TextFormField(
      initialValue: '',
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 20, color: MyColors.grey, shadows: shadow),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.purple2),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
