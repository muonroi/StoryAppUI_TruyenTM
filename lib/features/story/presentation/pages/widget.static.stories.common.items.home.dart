import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.stories.vertical.dart';

class StoriesCommon extends StatelessWidget {
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesCommon(
      {super.key, required this.isShowLabel, required this.isShowBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              color: themeMode(context, ColorCode.textColor.name),
              highlightColor: const Color.fromARGB(255, 255, 175, 0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: backButtonCommon(context)),
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          title: Text(
            L(context, LanguageCodes.commonOfStoriesTextInfo.toString()),
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        isShowLabel: isShowLabel,
        isShowBack: isShowBack,
      ),
    );
  }
}
