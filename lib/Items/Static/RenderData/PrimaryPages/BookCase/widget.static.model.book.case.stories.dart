import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.button.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.detail.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class StoriesBookCaseModelWidget extends StatefulWidget {
  final StoryItems storyInfo;
  const StoriesBookCaseModelWidget({
    super.key,
    required this.storyInfo,
  });

  @override
  State<StoriesBookCaseModelWidget> createState() =>
      _StoriesBookCaseModelWidget();
}

class _StoriesBookCaseModelWidget extends State<StoriesBookCaseModelWidget> {
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
            color: ColorDefaults.lightAppColor,
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
        child: Container(
          color: ColorDefaults.secondMainColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 80)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 120)
                      .height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.storyInfo.imgUrl,
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
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 120)
                    .height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 250)
                          .width,
                      child: Text(
                        widget.storyInfo.storyTitle,
                        style: FontsDefault.h4.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 18),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.storyInfo.authorName,
                      style: FontsDefault.h5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 170)
                                  .width,
                              child: ButtonWidget
                                  .buttonNavigatorNextPreviewLanding(
                                      context,
                                      StoriesDetail(
                                          storyId: widget.storyInfo.id,
                                          storyTitle:
                                              widget.storyInfo.storyTitle),
                                      textDisplay: L(ViCode
                                          .storiesContinueChapterTextInfo
                                          .toString())),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: 100,
                            child: Stack(children: [
                              Text(
                                widget.storyInfo.updatedDateString,
                                style: FontsDefault.h5.copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              showToolTip(widget.storyInfo.updatedDateString)
                            ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
