import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/Settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

void showConfirmAlert(
    BuildContext context, String content, String iconAcceptColorName,
    {bool isNextRoute = false, Widget? nextRoute}) {
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(
            L(context, LanguageCodes.notificationTextInfo.toString()),
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w700),
          ),
          content: Text(
            content,
            style: CustomFonts.h5(context),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: themeMode(context, iconAcceptColorName),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(L(context, LanguageCodes.ignoreTextInfo.toString()),
                    style: CustomFonts.h5(context).copyWith(
                        color: themeMode(context, ColorCode.modeColor.name))),
              ),
              onPressed: () {
                if (isNextRoute) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => nextRoute!)));
                } else {
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
