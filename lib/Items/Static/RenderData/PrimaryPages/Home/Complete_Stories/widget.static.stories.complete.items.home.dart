import 'package:flutter/material.dart';

import '../../../../../../Models/Stories/models.stories.story.dart';
import '../../../../../../Settings/settings.colors.dart';
import '../../../../../../Settings/settings.fonts.dart';
import '../../../../../../Settings/settings.language_code.vi..dart';
import '../../../../../../Settings/settings.main.dart';
import '../../../Shared/widget.static.stories.vertical.dart';

class StoriesComplete extends StatelessWidget {
  final List<StoryModel> storiesData;
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesComplete(
      {super.key,
      required this.storiesData,
      required this.isShowLabel,
      required this.isShowBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(color: ColorDefaults.thirdMainColor),
          backgroundColor: ColorDefaults.mainColor,
          title: Text(
            L(ViCode.completeStoriesTextInfo.toString()),
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        storiesData: storiesData,
        isShowLabel: isShowLabel,
        isShowBack: isShowBack,
      ),
    );
  }
}
