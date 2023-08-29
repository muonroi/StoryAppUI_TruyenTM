import 'package:flutter/material.dart';

import '../../Settings/settings.colors.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController? dateController;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final VoidCallback? ontap;
  final bool readonly;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    this.ontap,
    required this.readonly,
    this.dateController,
  });
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: dateController,
        readOnly: readonly,
        onTap: ontap,
        onChanged: onChanged,
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
    return Column(
      children: [
        SearchBar(totalSize: totalSize, child: child),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.totalSize,
    required this.child,
  });

  final Size totalSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: totalSize.width * 0.8,
      decoration: BoxDecoration(
          color: ColorDefaults.secondMainColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorDefaults.colorGrey200)),
      child: child,
    );
  }
}
