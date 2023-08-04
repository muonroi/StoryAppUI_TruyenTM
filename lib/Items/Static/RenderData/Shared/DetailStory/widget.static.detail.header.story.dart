import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class Header extends StatelessWidget {
  final StoryModel widget;
  const Header({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MainSetting.getPercentageOfDevice(context, expectWidth: 119)
              .width,
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 176)
              .height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.image,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 176)
              .height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 200)
                      .width,
                  child: Text(
                    widget.name,
                    style: FontsDefault.h4.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  child: Text(
                    widget.authorName ?? L(ViCode.notfoundTextInfo.toString()),
                    style:
                        FontsDefault.h5.copyWith(fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorDefaults.secondMainColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        widget.category ??
                            L(ViCode.notfoundTextInfo.toString()),
                        style: FontsDefault.h5
                            .copyWith(fontWeight: FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  child: Column(
                    children: [
                      RatingBar.builder(
                        itemSize: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 25)
                                .width ??
                            25,
                        initialRating: 0,
                        minRating: 0.5,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: RichText(
                          text: TextSpan(
                              text: L(ViCode.voteStoryTextInfo.toString()),
                              children: [
                                TextSpan(
                                    text: ' ${widget.vote}/5 ',
                                    style: FontsDefault.h6.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                                TextSpan(
                                    text: L(ViCode.voteStoryTotalTextInfo
                                        .toString()),
                                    style: FontsDefault.h6.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15)),
                                TextSpan(
                                    text:
                                        '  ${widget.totalVote} ${L(ViCode.voteStoryTextInfo.toString()).replaceRange(0, 1, L(ViCode.voteStoryTextInfo.toString())[0].toLowerCase())}',
                                    style: FontsDefault.h6.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15))
                              ],
                              style: FontsDefault.h6.copyWith(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                )
              ]),
        )
      ],
    );
  }
}
