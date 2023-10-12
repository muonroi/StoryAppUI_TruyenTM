import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
import 'package:muonroi/features/story/data/repositories/story_repository.dart';

class Header extends StatefulWidget {
  final StorySingleResult infoStory;
  const Header({super.key, required this.infoStory});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    _storyRepository = StoryRepository();
    super.initState();
  }

  late StoryRepository _storyRepository;
  late double ratingValue = 0.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 115)
                        .width,
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 176)
                    .height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: netWorkImage(widget.infoStory.imgUrl, true),
                ),
              ),
              RatingBar.builder(
                unratedColor: themeMode(context, ColorCode.textColor.name),
                itemSize:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                            .width ??
                        25,
                initialRating: widget.infoStory.rating == 0.0
                    ? 0
                    : widget.infoStory.rating,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _storyRepository.voteStory(widget.infoStory.id, rating);
                  });
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            height:
                MainSetting.getPercentageOfDevice(context, expectHeight: 176)
                    .height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 210)
                        .width,
                    child: Stack(children: [
                      Text(
                        widget.infoStory.storyTitle,
                        style: CustomFonts.h4(context).copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      showToolTip(widget.infoStory.storyTitle)
                    ]),
                  ),
                  SizedBox(
                    child: Text(
                      widget.infoStory.authorName,
                      style: CustomFonts.h5(context).copyWith(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                          color: themeMode(context, ColorCode.mainColor.name)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 200)
                        .width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color:
                                  themeMode(context, ColorCode.modeColor.name),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            widget.infoStory.nameCategory,
                            style: CustomFonts.h5(context)
                                .copyWith(fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.infoStory.nameTag
                          .map((e) => e.toString())
                          .map((String item) {
                        return item.toLowerCase().trim() ==
                                L(
                                    context,
                                    LanguageCodes.tagCompleteTextInfo
                                        .toString()
                                        .trim())
                            ? Text(
                                '#$item ',
                                style: CustomFonts.h6(context).copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 11,
                                    backgroundColor: themeMode(
                                        context, ColorCode.mainColor.name)),
                              )
                            : Text('#$item ',
                                style: CustomFonts.h6(context).copyWith(
                                    fontStyle: FontStyle.italic, fontSize: 11));
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: RichText(
                            text: TextSpan(
                                text: L(context,
                                    LanguageCodes.voteStoryTextInfo.toString()),
                                children: [
                                  TextSpan(
                                      text:
                                          ' ${widget.infoStory.rating == 0.0 ? 0 : widget.infoStory.rating}/5 ',
                                      style: CustomFonts.h6(context).copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: themeMode(context,
                                              ColorCode.mainColor.name))),
                                  TextSpan(
                                      text: L(
                                          context,
                                          LanguageCodes.voteStoryTotalTextInfo
                                              .toString()),
                                      style: CustomFonts.h6(context).copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15)),
                                  TextSpan(
                                      text:
                                          '  ${widget.infoStory.totalVote} ${L(context, LanguageCodes.voteStoryTextInfo.toString()).replaceRange(0, 1, L(context, LanguageCodes.voteStoryTextInfo.toString())[0].toLowerCase())}',
                                      style: CustomFonts.h6(context).copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: themeMode(context,
                                              ColorCode.mainColor.name)))
                                ],
                                style: CustomFonts.h6(context)
                                    .copyWith(fontSize: 15)),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
