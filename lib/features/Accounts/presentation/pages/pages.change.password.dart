import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/shared/Settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class ChangePasswordPage extends StatefulWidget {
  final String username;
  final String code;
  final String token;
  const ChangePasswordPage(
      {super.key,
      required this.username,
      required this.code,
      required this.token});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordValidationError = "";
    _confirmPasswordValidationError = "";
    _isVisibility = true;
    _isEnableButton = false;
    _isVisibilityConfirm = true;
    super.initState();
  }

  String _updatePasswordValidation() {
    setState(() {
      _passwordValidationError = validatePassword(_newPasswordController.text)
          ? ""
          : L(context, LanguageCodes.requiredPasswordTextInfo.toString());
    });
    return _passwordValidationError;
  }

  String _updateConfirmPasswordValidation() {
    setState(() {
      _confirmPasswordValidationError =
          _newPasswordController.text == _confirmPasswordController.text
              ? ""
              : L(context,
                  LanguageCodes.errorDoesNotMatchPasswordTextInfo.toString());
    });
    return _confirmPasswordValidationError;
  }

  bool validatePassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
    return regex.hasMatch(password);
  }

  late String _confirmPasswordValidationError;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  late String _passwordValidationError;
  late bool _isVisibility;
  late bool _isVisibilityConfirm;
  late bool _isEnableButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 16.0)
                    .height),
            TextField(
              controller: _newPasswordController,
              onChanged: (value) {
                setState(() {
                  var result = _updatePasswordValidation();
                  _isEnableButton = result == "" ? true : false;
                });
              },
              obscureText: _isVisibility,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisibility = !_isVisibility;
                    });
                  },
                  icon: Icon(
                    _isVisibility ? Icons.visibility : Icons.visibility_off,
                    color: themeMode(context, ColorCode.mainColor.name),
                  ),
                ),
                errorMaxLines: 2,
                errorText: _passwordValidationError,
                labelText:
                    L(context, LanguageCodes.newPasswordTextInfo.toString()),
                labelStyle: TextStyle(
                  color: _passwordValidationError != ""
                      ? themeMode(context, ColorCode.closeColor.name)
                      : themeMode(context, ColorCode.textColor.name),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _passwordValidationError != ""
                          ? themeMode(context, ColorCode.closeColor.name)
                          : themeMode(context, ColorCode.mainColor.name),
                      width: _confirmPasswordValidationError != "" ? 0.0 : 1.5),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _passwordValidationError != ""
                          ? themeMode(context, ColorCode.closeColor.name)
                          : themeMode(context, ColorCode.mainColor.name),
                      width: _passwordValidationError != "" ? 0.0 : 1.5),
                ),
              ),
            ),
            SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 16.0)
                    .height),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _isVisibilityConfirm,
              onChanged: (value) {
                setState(() {
                  var result = _updateConfirmPasswordValidation();
                  _isEnableButton = result == "" ? true : false;
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisibilityConfirm = !_isVisibilityConfirm;
                    });
                  },
                  icon: Icon(
                    _isVisibilityConfirm
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: themeMode(context, ColorCode.mainColor.name),
                  ),
                ),
                errorText: _confirmPasswordValidationError,
                labelText: L(
                    context, LanguageCodes.confirmPasswordTextInfo.toString()),
                labelStyle: TextStyle(
                  color: _confirmPasswordValidationError != ""
                      ? themeMode(context, ColorCode.closeColor.name)
                      : themeMode(context, ColorCode.textColor.name),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _confirmPasswordValidationError != ""
                          ? themeMode(context, ColorCode.closeColor.name)
                          : themeMode(context, ColorCode.mainColor.name),
                      width: _confirmPasswordValidationError != "" ? 0.0 : 1.5),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: _confirmPasswordValidationError != ""
                          ? themeMode(context, ColorCode.closeColor.name)
                          : themeMode(context, ColorCode.mainColor.name),
                      width: _confirmPasswordValidationError != "" ? 0.0 : 1.5),
                ),
              ),
            ),
            SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 32.0)
                    .height),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(_isEnableButton
                      ? themeMode(context, ColorCode.mainColor.name)
                      : themeMode(context, ColorCode.disableColor.name))),
              onPressed: _isEnableButton
                  ? () async {
                      final accountRepository =
                          AccountRepository(widget.username, "", "");
                      var result = await accountRepository.changePassword(
                          _newPasswordController.text,
                          _confirmPasswordController.text,
                          widget.code,
                          widget.token);
                      if (mounted && result) {
                        showConfirmAlert(
                            context,
                            L(
                                context,
                                LanguageCodes.changePasswordSuccessTextInfo
                                    .toString()),
                            ColorCode.mainColor.name,
                            isNextRoute: true,
                            nextRoute: const SignInPage());
                      } else {
                        if (mounted) {
                          showConfirmAlert(
                              context,
                              L(context,
                                  LanguageCodes.serverErrorTextInfo.toString()),
                              ColorCode.closeColor.name);
                        }
                      }
                    }
                  : null,
              child: Text(
                L(context, LanguageCodes.changePasswordTextInfo.toString()),
                style: CustomFonts.h5(context).copyWith(
                    color: themeMode(context, ColorCode.modeColor.name)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
