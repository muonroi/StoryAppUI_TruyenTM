import 'package:flutter/material.dart';
import 'package:taxi/Widget/TextField/widget.textfield.text_input.dart';

import '../../Settings/settings.colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  const RoundedPasswordField({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          icon: const Icon(Icons.lock, color: ColorDefaults.buttonColor),
          suffixIcon: const Icon(
            Icons.visibility,
            color: ColorDefaults.buttonColor,
          ),
        ),
      ),
    );
  }
}
