import 'package:flutter/material.dart';
import 'package:muonroi/Controller/controller.main.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.button.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class ChapterOfStory extends StatefulWidget {
  final StoryModel widget;
  const ChapterOfStory({super.key, required this.widget});

  @override
  State<ChapterOfStory> createState() => _ChapterOfStoryState();
}

class _ChapterOfStoryState extends State<ChapterOfStory> {
  List<Color> colorOfRow = [];
  @override
  void initState() {
    colorOfRow =
        List<Color>.filled(widget.widget.newChapters!.length, Colors.white);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            L(ViCode.newChapterStoryTextInfo.toString()),
            style: FontsDefault.h4,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 280)
              .height,
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.widget.newChapters?.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTapDown: (_) {
                    setState(() {
                      colorOfRow[index] = Colors.grey[200]!;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      colorOfRow[index] = Colors.white;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      colorOfRow[index] = Colors.white;
                    });
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    color: colorOfRow[index],
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                "${L(ViCode.chapterNumberTextInfo.toString()).replaceRange(0, 1, L(ViCode.chapterNumberTextInfo.toString())[0].toUpperCase())} ${formatNumberThouSand(widget.widget.newChapters?[index] ?? 0)}: ",
                                style: FontsDefault.h5
                                    .copyWith(color: ColorDefaults.mainColor),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 150)
                                  .width,
                              child: Text(
                                '${widget.widget.newChapterNames?[index]}',
                                style: FontsDefault.h5,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.keyboard_arrow_right),
                          color: ColorDefaults.thirdMainColor,
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            child: SizedBox(
              width:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 319)
                      .width,
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 40)
                      .height,
              child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                  context, const HomePage(),
                  textStyle: FontsDefault.h5.copyWith(
                      color: ColorDefaults.mainColor,
                      fontWeight: FontWeight.w600),
                  color: ColorDefaults.lightAppColor,
                  borderColor: ColorDefaults.mainColor,
                  widthBorder: 2,
                  textDisplay: L(ViCode.listChapterStoryTextInfo.toString())),
            ),
          ),
        )
      ],
    );
  }
}
