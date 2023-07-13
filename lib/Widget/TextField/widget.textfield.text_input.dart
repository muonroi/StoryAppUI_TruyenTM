import 'package:flutter/material.dart';

import '../../Settings/settings.colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            icon: Icon(
              icon,
              color: ColorDefaults.buttonColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size totalSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: totalSize.width * 0.8,
      decoration: BoxDecoration(
          color: ColorDefaults.mainColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorDefaults.borderButtonPreviewPage)),
      child: child,
    );
  }
}
