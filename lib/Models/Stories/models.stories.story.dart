import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class StoryModel {
  late String name;
  late String? category;
  late double? totalView;
  late String image;
  late String? authorName;
  late int? lastUpdated;
  late List<String>? tagsName;
  late double? numberOfChapter;
  late int? rankNumber;
  StoryModel(
      {required this.image,
      required this.name,
      this.category,
      this.totalView,
      this.authorName,
      this.tagsName,
      this.numberOfChapter,
      this.lastUpdated,
      this.rankNumber});
}

class StoryLessModelWidget extends StatefulWidget {
  final String networkImageUrl;
  final String storyName;
  const StoryLessModelWidget(
      {super.key, required this.networkImageUrl, required this.storyName});

  @override
  State<StoryLessModelWidget> createState() => _StoryLessModelWidgetState();
}

class _StoryLessModelWidgetState extends State<StoryLessModelWidget> {
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutSine,
        transform: Matrix4.diagonal3Values(
          widgetScale,
          widgetScale,
          1.0,
        ),
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        width:
            MainSetting.getPercentageOfDevice(context, expectWidth: 100).width,
        height: MainSetting.getPercentageOfDevice(context, expectHeight: 170)
            .height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 100)
                      .height,
                  child: CachedNetworkImage(
                    imageUrl: widget.networkImageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 80)
                        .width,
                child: Text(
                  widget.storyName,
                  style: FontsDefault.h5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ]),
      ),
    );
  }
}

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
      required this.isShowRank});

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
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.imageLink,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
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
                  Text(
                    widget.authorName,
                    style: FontsDefault.h5.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorDefaults.mainColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.nameStory,
                    style:
                        FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
