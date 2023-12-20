import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/user/data/repository/user.repository.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/textField/widget.static.textfield.text_input.dart';
import 'package:sprintf/sprintf.dart';

class InputBasicInfoSignUp extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final void Function(bool) callback;
  const InputBasicInfoSignUp({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.callback,
  }) : super(key: key);

  @override
  State<InputBasicInfoSignUp> createState() => _InputBasicInfoSignUpState();
}

class _InputBasicInfoSignUpState extends State<InputBasicInfoSignUp> {
  @override
  void initState() {
    _emailValidationError = "";
    _passwordValidationError = "";
    _usernameValidationError = "";
    _isVisibility = true;

    super.initState();
  }

  String _updatePasswordValidation() {
    setState(() {
      _passwordValidationError =
          validatePassword(widget.passwordController.text)
              ? ""
              : L(context, LanguageCodes.requiredPasswordTextInfo.toString());
    });
    return _passwordValidationError;
  }

  Future _updateUsernameValidation() async {
    final userRepository = UserRepository();
    var isDuplicate = await userRepository
        .getDuplicateUsername(widget.usernameController.text);
    setState(() {
      _usernameValidationError = validateUsername(
              widget.usernameController.text)
          ? ""
          : L(context, LanguageCodes.usernameSignUpErrorTextInfo.toString());
      _usernameValidationError = isDuplicate.result
          ? sprintf(
              L(context, LanguageCodes.duplicateUsernameTextInfo.toString()),
              [widget.usernameController.text])
          : "";
    });
  }

  void _updateEmailValidation() {
    setState(() {
      _emailValidationError = validateEmail(widget.emailController.text)
          ? ""
          : L(context, LanguageCodes.emailSignUpErrorTextInfo.toString());
    });
  }

  bool validatePassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');

    return regex.hasMatch(password);
  }

  bool validateUsername(String username) {
    RegExp regex = RegExp(
        r'^[a-zA-Z][a-zA-Z0-9_\.]{3,99}[a-z0-9](\@([a-zA-Z0-9][a-zA-Z0-9\.]+[a-zA-Z0-9]{2,}){1,5})?$');
    return regex.hasMatch(username);
  }

  bool validateEmail(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  late String _passwordValidationError;
  late String _usernameValidationError;
  late String _emailValidationError;
  late bool _isVisibility;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedInputField(
          textController: widget.usernameController,
          errorMessage: _usernameValidationError,
          isShowIcon: false,
          readonly: false,
          hintText:
              L(context, LanguageCodes.myAccountDetailTextInfo.toString()),
          icon: Icons.person,
          onChange: (value) {
            setState(() {
              _updateUsernameValidation();
            });
          },
          isPassword: false,
        ),
        RoundedInputField(
          textController: widget.emailController,
          isShowIcon: false,
          readonly: false,
          hintText: L(context, LanguageCodes.emailSignUpTextInfo.toString()),
          icon: Icons.email,
          onChange: (value) {
            setState(() {
              _updateEmailValidation();
            });
          },
          errorMessage: _emailValidationError,
          isPassword: false,
        ),
        RoundedInputField(
          textController: widget.passwordController,
          iconAction: () {
            setState(() {
              _isVisibility = !_isVisibility;
            });
          },
          isVisibility: _isVisibility,
          isShowIcon: true,
          readonly: false,
          hintText: L(context,
              LanguageCodes.inputPasswordTextConfigTextInfo.toString()),
          icon: Icons.lock,
          onChange: (value) {
            setState(() {
              var result = _updatePasswordValidation();
              widget.callback((result == "" &&
                      _emailValidationError == "" &&
                      _usernameValidationError == "")
                  ? true
                  : false);
            });
          },
          errorMessage: _passwordValidationError,
          isPassword: _isVisibility,
        ),
      ],
    );
  }
}
