import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/TextField/widget.static.textfield.text_input.dart';

import '../../../Settings/settings.colors.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
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
