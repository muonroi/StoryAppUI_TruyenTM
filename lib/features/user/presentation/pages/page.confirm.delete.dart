import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/shared/Settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class ConfirmDeleteAccountWidget extends StatefulWidget {
  final String title;
  const ConfirmDeleteAccountWidget({super.key, required this.title});

  @override
  State<ConfirmDeleteAccountWidget> createState() =>
      _ConfirmDeleteAccountWidgetState();
}

class _ConfirmDeleteAccountWidgetState
    extends State<ConfirmDeleteAccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themeMode(context, ColorCode.textColor.name),
        ),
        backgroundColor: themeMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(
          widget.title,
          style: CustomFonts.h5(context),
        ),
      ),
      body: PrivacyPolicyWidget(
        title: widget.title,
      ),
    );
  }
}

class PrivacyPolicyWidget extends StatefulWidget {
  final String title;
  const PrivacyPolicyWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  bool isCheckboxChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: themeMode(context, ColorCode.modeColor.name),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 10.0),
            const Text(
              'November, 18th, 2023',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                L(context,
                    LanguageCodes.privacyDeleteAccountTextInfo.toString()),
                style: CustomFonts.h6(context).copyWith(fontSize: 12),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: isCheckboxChecked,
                  onChanged: (value) {
                    setState(() {
                      isCheckboxChecked = value!;
                    });
                  },
                ),
                Text(
                  L(context,
                      LanguageCodes.agreeDeleteAccountTextInfo.toString()),
                  style: CustomFonts.h6(context).copyWith(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(8.0)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(isCheckboxChecked
                      ? themeMode(context, ColorCode.mainColor.name)
                      : themeMode(context, ColorCode.disableColor.name))),
              onPressed: isCheckboxChecked
                  ? () async {
                      final accountRepository = AccountRepository();
                      var result = await accountRepository.deleteAccount();
                      if (mounted && result) {
                        showConfirmAlert(
                            context,
                            L(
                                context,
                                LanguageCodes.deleteAccountSuccessTextInfo
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
                L(context,
                    LanguageCodes.requestDeleteAccountTextInfo.toString()),
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
