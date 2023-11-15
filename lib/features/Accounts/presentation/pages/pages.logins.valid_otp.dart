// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';

import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.change.password.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/shared/Settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class OTPScreen extends StatefulWidget {
  final String username;
  const OTPScreen({
    Key? key,
    required this.username,
  }) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 60.0)
                        .width,
                    child: TextFormField(
                      controller: otpControllers[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20.0),
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        themeMode(context, ColorCode.mainColor.name))),
                onPressed: () async {
                  final accountRepository =
                      AccountRepository(widget.username, "", "");
                  String enteredOTP = otpControllers
                      .map((controller) => controller.text)
                      .join();
                  var result = await accountRepository.validOtp(enteredOTP);

                  if (result.result.isVerify && mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => ChangePasswordPage(
                                  username: widget.username,
                                  code: enteredOTP,
                                  token: result.result.token,
                                )));
                  } else {
                    if (mounted) {
                      showConfirmAlert(
                          context,
                          L(context,
                              LanguageCodes.otpConfirmErrorTextInfo.toString()),
                          ColorCode.closeColor.name);
                    }
                  }
                },
                child: Text(
                  L(context, LanguageCodes.confirmTextInfo.toString()),
                  style: CustomFonts.h5(context).copyWith(
                      color: themeMode(context, ColorCode.modeColor.name)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
