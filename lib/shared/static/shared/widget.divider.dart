import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const CustomDivider({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 88.0),
      child: Divider(
        thickness: 1,
      ),
    );
  }
}
