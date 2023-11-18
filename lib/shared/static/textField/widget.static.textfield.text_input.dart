import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController? textController;
  final String hintText;
  final IconData icon;
  final VoidCallback? ontap;
  final bool readonly;
  final String errorMessage;
  final void Function(String) onChange;
  final bool isShowIcon;
  final void Function()? iconAction;
  final bool? isVisibility;
  final bool isPassword;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    this.ontap,
    required this.readonly,
    this.textController,
    required this.errorMessage,
    required this.onChange,
    required this.isShowIcon,
    this.iconAction,
    this.isVisibility,
    required this.isPassword,
  });
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: textController,
        readOnly: readonly,
        onTap: ontap,
        onChanged: onChange,
        obscureText: isPassword,
        decoration: InputDecoration(
            suffixIcon: isShowIcon
                ? IconButton(
                    onPressed: iconAction,
                    icon: Icon(
                      isShowIcon && isVisibility!
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: themeMode(context, ColorCode.mainColor.name),
                    ),
                  )
                : null,
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: errorMessage != ""
                      ? themeMode(context, ColorCode.closeColor.name)
                      : themeMode(context, ColorCode.mainColor.name),
                  width: errorMessage != "" ? 0.0 : 1.5),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: errorMessage != ""
                      ? themeMode(context, ColorCode.closeColor.name)
                      : themeMode(context, ColorCode.mainColor.name),
                  width: errorMessage != "" ? 0.0 : 1.5),
            ),
            labelText: hintText,
            labelStyle: TextStyle(
              color: errorMessage != ""
                  ? themeMode(context, ColorCode.closeColor.name)
                  : themeMode(context, ColorCode.textColor.name),
            ),
            errorMaxLines: 3,
            errorText: errorMessage,
            hintText: hintText,
            icon: Icon(
              icon,
              color: themeMode(context, ColorCode.mainColor.name),
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
          color: themeMode(context, ColorCode.modeColor.name),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: themeMode(context, ColorCode.disableColor.name))),
      child: child,
    );
  }
}

class TextFormFieldGlobal extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final InputDecoration? decoration;
  const TextFormFieldGlobal(
      {super.key, this.controller, required this.obscureText, this.decoration});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: decoration,
    );
  }
}
