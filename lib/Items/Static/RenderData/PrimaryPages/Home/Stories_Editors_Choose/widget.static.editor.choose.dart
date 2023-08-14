import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.vertical.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class EditorStories extends StatelessWidget {
  final List<StoryItems> storiesData;
  final bool isShowLabel;
  final bool isShowBack;
  const EditorStories(
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
            L(ViCode.editorChoiceTextInfo.toString()),
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
