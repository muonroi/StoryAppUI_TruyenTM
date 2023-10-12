import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.stories.vertical.dart';

class StoriesFree extends StatefulWidget {
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesFree(
      {super.key, required this.isShowLabel, required this.isShowBack});

  @override
  State<StoriesFree> createState() => _StoriesFreeState();
}

class _StoriesFreeState extends State<StoriesFree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.disableColor.name),
      appBar: AppBar(
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          title: Text(
            L(context, LanguageCodes.freeStoriesTextInfo.toString()),
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        isShowLabel: widget.isShowLabel,
        isShowBack: widget.isShowBack,
      ),
    );
  }
}
