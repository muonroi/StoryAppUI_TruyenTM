import 'package:flutter/cupertino.dart';

import '../../Settings/settings.main.dart';

// #region new stories widget
class StoriesNewUpdated extends StatelessWidget {
  const StoriesNewUpdated({
    super.key,
    required this.imageList2,
  });

  final List<Widget> imageList2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 300).height,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, // Vertically center the column
        crossAxisAlignment:
            CrossAxisAlignment.center, // Horizontally center the column
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageList2[0],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Center the elements horizontally
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageList2[0],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// #endregion

// #region stories was choice by editors

class StoriesChoiceEditors extends StatelessWidget {
  const StoriesChoiceEditors({
    super.key,
    required PageController pageEditorController,
    required this.imageList,
  }) : _pageEditorController = pageEditorController;

  final PageController _pageEditorController;
  final List<Widget> imageList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 150).height,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          controller: _pageEditorController,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imageList[index]),
                )
              ],
            );
          }),
    );
  }
}

// #endregion
