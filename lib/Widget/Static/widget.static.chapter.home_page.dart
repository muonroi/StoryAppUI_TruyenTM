import 'package:flutter/material.dart';

import '../../Settings/settings.fonts.dart';
import '../../Settings/settings.images.dart';
import '../../Settings/settings.main.dart';

class ListNewChapter extends StatelessWidget {
  final String chapterTitle;
  final String minuteUpdated;

  const ListNewChapter({
    super.key,
    required this.chapterTitle,
    required this.minuteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 20, expectWidth: 20)
                          .width,
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 20, expectWidth: 20)
                          .height,
                      child: Image.asset(ImageDefault.bookBookmark2x,
                          fit: BoxFit.cover),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: RichText(
                                text: TextSpan(
                                    text: chapterTitle,
                                    style: FontsDefault.h5,
                                    children: <TextSpan>[
                                  TextSpan(
                                    text: '\n$minuteUpdated phút trước',
                                    style: FontsDefault.h6,
                                  )
                                ]))),
                      ],
                    )
                  ],
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Chương 101 >',
                      style: FontsDefault.h5,
                    ))
              ],
            ),
          ],
        ));
  }
}
