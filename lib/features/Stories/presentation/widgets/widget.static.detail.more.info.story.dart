import 'package:flutter/cupertino.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/stories/data/models/models.single.story.dart';
import 'package:muonroi/features/stories/settings/settings.dart';

class InfoDetailStory extends StatelessWidget {
  final double value;
  final String text;
  const InfoDetailStory({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32.0),
      child: Row(
        children: [
          SizedBox(
            child: Column(children: [
              SizedBox(
                child: Text(
                  formatNumberThouSand(value),
                  style: FontsDefault.h4,
                ),
              ),
              SizedBox(
                child: Text(
                  text,
                  style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w300),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class MoreInfoStory extends StatelessWidget {
  final StorySingleResult infoStory;
  const MoreInfoStory({super.key, required this.infoStory});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoDetailStory(
            value: infoStory.totalChapter.toDouble(),
            text: L(ViCode.chapterNumberTextInfo.toString())),
        Text(
          '|',
          style: FontsDefault.h4.copyWith(fontWeight: FontWeight.w300),
        ),
        InfoDetailStory(
          value: infoStory.totalView * 1.0,
          text: L(ViCode.totalViewStoryTextInfo.toString()),
        ),
        Text(
          '|',
          style: FontsDefault.h4.copyWith(fontWeight: FontWeight.w300),
        ),
        InfoDetailStory(
          value: double.parse(infoStory.totalFavorite.toString()),
          text: L(ViCode.totalFavoriteStoryTextInfo.toString()),
        ),
      ],
    );
  }
}
