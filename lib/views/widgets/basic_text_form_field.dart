import 'package:dsw_52745/utils/my_colors.dart';
import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String hintText;
  final String prefixIcon;
  final bool withShadow;
  final String? suffixIcon;
  final ValueChanged<String>? onChange;
  final bool? hiddenText;

  const BasicTextFormField({
    required this.hintText,
    required this.prefixIcon,
    super.key,
    this.withShadow = false,
    this.suffixIcon,
    this.onChange,
    this.hiddenText = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Shadow> shadow = withShadow
        ? [
            Shadow(
              color: MyColors.black.withAlpha(25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ]
        : [];

    return SizedBox(
      height: 50,
      child: TextFormField(
        initialValue: '',
        onChanged: onChange,
        obscureText: hiddenText!,
        decoration: InputDecoration(
          prefixIcon: Image.asset(prefixIcon),
          suffixIcon: suffixIcon != null ? Image.asset(suffixIcon!) : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 15, color: MyColors.grey, shadows: shadow),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.purple2, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
