import 'package:flutter/cupertino.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
import 'package:muonroi/features/story/settings/settings.dart';

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
                  style: CustomFonts.h4(context),
                ),
              ),
              SizedBox(
                child: Text(
                  text,
                  style: CustomFonts.h5(context)
                      .copyWith(fontWeight: FontWeight.w300),
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
            text: L(context, LanguageCodes.chapterNumberTextInfo.toString())),
        Text(
          '|',
          style: CustomFonts.h4(context).copyWith(fontWeight: FontWeight.w300),
        ),
        InfoDetailStory(
          value: infoStory.totalView * 1.0,
          text: L(context, LanguageCodes.totalViewStoryTextInfo.toString()),
        ),
        Text(
          '|',
          style: CustomFonts.h4(context).copyWith(fontWeight: FontWeight.w300),
        ),
        InfoDetailStory(
          value: double.parse(infoStory.totalFavorite.toString()),
          text: L(context, LanguageCodes.totalFavoriteStoryTextInfo.toString()),
        ),
      ],
    );
  }
}
