import 'package:flutter/material.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.stories.common.home.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class StoriesCommon extends StatelessWidget {
  final EnumStoriesCommon type;
  const StoriesCommon({super.key, required this.type});

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
        body: StoriesCommonHome(
          type: type,
        ));
  }
}
