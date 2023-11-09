import 'package:flutter/material.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.stories.type.home.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class RegularStories extends StatelessWidget {
  final EnumStoriesSpecial type;
  final String nameTypeRegularStories;
  const RegularStories(
      {super.key, required this.type, required this.nameTypeRegularStories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            nameTypeRegularStories,
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesSpecial(
        type: type,
      ),
    );
  }
}
