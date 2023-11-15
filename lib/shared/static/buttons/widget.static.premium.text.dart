import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';

class BuyPremium extends StatelessWidget {
  const BuyPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showConfirmationDialog(
          context,
          L(context, LanguageCodes.closeAdsTextInfo.toString()),
          L(context, LanguageCodes.buyPremiumQuestionTextInfo.toString())),
      child: Text(
        L(context, LanguageCodes.closeAdsTextInfo.toString()),
        style: CustomFonts.h6(context)
            .copyWith(color: themeMode(context, ColorCode.mainColor.name)),
      ),
    );
  }
}
