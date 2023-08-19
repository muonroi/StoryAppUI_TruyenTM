import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.detail.dart';
import '../../../../../Settings/settings.colors.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.language_code.vi..dart';
import '../../../../../Settings/settings.main.dart';

class StoriesFullModelWidget extends StatefulWidget {
  final String nameStory;
  final String authorName;
  final String imageLink;
  final List<String> tagsName;
  final String categoryName;
  final double numberOfChapter;
  final int lastUpdated;
  final double totalViews;
  final int? rankNumber;
  final bool isShowRank;
  final int storyId;
  const StoriesFullModelWidget(
      {super.key,
      required this.nameStory,
      required this.authorName,
      required this.imageLink,
      required this.tagsName,
      required this.categoryName,
      required this.numberOfChapter,
      required this.lastUpdated,
      required this.totalViews,
      this.rankNumber,
      required this.isShowRank,
      required this.storyId});

  @override
  State<StoriesFullModelWidget> createState() => _StoriesFullModelWidgetState();
}

class _StoriesFullModelWidgetState extends State<StoriesFullModelWidget> {
  double widgetScale = 1.0;
  @override
  void initState() {
    super.initState();
  }

  void _toggleItemState() {
    setState(() {
      widgetScale = 0.9;
    });
  }

  void _setDefaultItemState() {
    setState(() {
      widgetScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _toggleItemState(),
      onTapUp: (_) => _setDefaultItemState(),
      onTapCancel: () => _setDefaultItemState(),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoriesDetail(
                      storyId: widget.storyId,
                      storyTitle: widget.nameStory,
                    )));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 221, 219, 219),
                  offset: Offset(-3, 3),
                  blurRadius: 3.0)
            ]),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutSine,
        transform: Matrix4.diagonal3Values(
          widgetScale,
          widgetScale,
          1.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 80)
                        .width,
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 120)
                    .height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.isShowRank
                      ? Banner(
                          message:
                              '${L(ViCode.rankTextInfo.toString())} ${widget.rankNumber}',
                          color: widget.rankNumber == 1
                              ? ColorDefaults.mainColor
                              : ColorDefaults.secondMainColor,
                          textStyle: FontsDefault.h6
                              .copyWith(fontWeight: FontWeight.w700),
                          location: BannerLocation.topEnd,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageLink,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.imageLink,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 120)
                      .height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 200)
                        .width,
                    child: Text(
                      widget.authorName,
                      style: FontsDefault.h5.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorDefaults.mainColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 250)
                        .width,
                    child: Text(
                      widget.nameStory,
                      style:
                          FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.categoryName,
                          style: FontsDefault.h5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${formatNumberThouSand(widget.numberOfChapter)} ${L(ViCode.chapterNumberTextInfo.toString())}',
                          style: FontsDefault.h5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: widget.tagsName
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '#$item',
                                style: FontsDefault.h6.copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ))
                        .toList(),
                  ),
                  Text(
                    '${widget.lastUpdated.toString()} ${L(ViCode.passedNumberMinuteTextInfo.toString())}',
                    style: FontsDefault.h6
                        .copyWith(fontStyle: FontStyle.italic, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
