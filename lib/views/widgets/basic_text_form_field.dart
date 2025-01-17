import 'package:flutter/material.dart';

class BasicTextFormField extends StatelessWidget {
  final String initialValue;

  const BasicTextFormField({super.key, this.initialValue = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(initialValue: initialValue),
    );
  }
}
