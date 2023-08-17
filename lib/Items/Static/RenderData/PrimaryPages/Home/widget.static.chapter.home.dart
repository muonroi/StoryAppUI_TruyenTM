import 'package:flutter/material.dart';

import '../../../../../Models/Chapters/models.chapters.chapter.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.images.dart';
import '../../../../../Settings/settings.language_code.vi..dart';
import '../../../../../Settings/settings.main.dart';

class ListNewChapter extends StatelessWidget {
  final List<ChapterInfo> chapterInfos;
  const ListNewChapter({
    super.key,
    required this.chapterInfos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MainSetting.getPercentageOfDevice(context,
                  expectHeight: chapterInfos.length * 75.2)
              .height,
          child: ListView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemExtent: 60,
              itemCount: chapterInfos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: RichText(
                                        text: TextSpan(
                                            text: "Coming soon",
                                            style: FontsDefault.h5,
                                            children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '\n "Coming soon" ${L(ViCode.passedNumberMinuteTextInfo.toString())}',
                                            style: FontsDefault.h6,
                                          )
                                        ]))),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '${L(ViCode.chapterNumberTextInfo.toString())} "Coming soon"',
                                      style: FontsDefault.h5,
                                      textAlign: TextAlign.left,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
        ));
  }
}
