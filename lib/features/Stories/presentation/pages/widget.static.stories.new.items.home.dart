import 'package:flutter/material.dart';
import '../../../../shared/settings/settings.colors.dart';
import '../../../../shared/settings/settings.fonts.dart';
import '../../../../shared/settings/settings.language_code.vi..dart';
import '../../../../shared/settings/settings.main.dart';
import 'widget.static.stories.vertical.dart';

class StoriesNew extends StatelessWidget {
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesNew(
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
              color: ColorDefaults.thirdMainColor,
              highlightColor: const Color.fromARGB(255, 255, 175, 0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: backButtonCommon()),
          backgroundColor: ColorDefaults.mainColor,
          title: Text(
            L(ViCode.newStoriesTextInfo.toString()),
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        isShowLabel: isShowLabel,
        isShowBack: isShowBack,
      ),
    );
  }
}
