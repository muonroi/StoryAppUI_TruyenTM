import 'package:flutter/material.dart';
import '../../../../shared/Settings/settings.colors.dart';
import '../../../../shared/Settings/settings.fonts.dart';
import '../../../../shared/Settings/settings.language_code.vi..dart';
import '../../../../shared/Settings/settings.main.dart';
import 'widget.static.stories.vertical.dart';

class StoriesComplete extends StatelessWidget {
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesComplete(
      {super.key, required this.isShowLabel, required this.isShowBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              splashRadius: 25,
              color: ColorDefaults.mainColor,
              highlightColor: const Color.fromARGB(255, 255, 175, 0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: backButtonCommon()),
          backgroundColor: ColorDefaults.mainColor,
          title: Text(
            L(ViCode.completeStoriesTextInfo.toString()),
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        isShowLabel: isShowLabel,
        isShowBack: isShowBack,
      ),
    );
  }
}
