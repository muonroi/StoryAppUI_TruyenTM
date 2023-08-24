import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.vertical.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';

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
      appBar: AppBar(
          backgroundColor: ColorDefaults.mainColor,
          title: Text(
            L(ViCode.freeStoriesTextInfo.toString()),
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w600),
          )),
      body: StoriesVerticalData(
        isShowLabel: widget.isShowLabel,
        isShowBack: widget.isShowBack,
      ),
    );
  }
}
