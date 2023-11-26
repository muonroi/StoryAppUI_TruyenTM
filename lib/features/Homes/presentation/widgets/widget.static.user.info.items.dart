import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class Utils {
  static Future<void> sendEmail(
      {required String email, String subject = "", String body = ""}) async {
    final mail = Mailto(to: ['admin.contact@TruyenTM.online']);
    if (await url.canLaunchUrl(Uri.parse(mail.toString()))) {
      await url.launchUrl(Uri.parse(mail.toString()));
    } else {
      throw Exception("Unable to open the email");
    }
  }
}

class SettingItems extends StatelessWidget {
  final String text;
  final String image;
  final void Function() onPressed;
  final Color? colorIcon;
  const SettingItems(
      {super.key,
      required this.text,
      required this.image,
      required this.onPressed,
      this.colorIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: themeMode(context, ColorCode.disableColor.name),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 20)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 20)
                        .height,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      color: colorIcon,
                    )),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 200)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: Text(
                    text,
                    style: CustomFonts.h5(context),
                  ),
                ),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 25)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.keyboard_arrow_right,
                        color: themeMode(context, ColorCode.textColor.name)),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
