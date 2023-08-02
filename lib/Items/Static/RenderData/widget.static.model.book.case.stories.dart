import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/Buttons/widget.static.button.dart';
import 'package:muonroi/Pages/PrimaryPages/pages.book.case.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import '../../../Settings/settings.fonts.dart';
import '../../../Settings/settings.language_code.vi..dart';
import '../../../Settings/settings.main.dart';

class StoriesBookCaseModelWidget extends StatefulWidget {
  final String nameStory;
  final String authorName;
  final String imageLink;
  final List<String> tagsName;
  final String categoryName;
  final double numberOfChapter;
  final int lastUpdated;
  final double totalViews;
  const StoriesBookCaseModelWidget({
    super.key,
    required this.nameStory,
    required this.authorName,
    required this.imageLink,
    required this.tagsName,
    required this.categoryName,
    required this.numberOfChapter,
    required this.lastUpdated,
    required this.totalViews,
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
                    widget.nameStory,
                    style: FontsDefault.h4
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.authorName,
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
                            child:
                                ButtonWidget.buttonNavigatorNextPreviewLanding(
                                    context, const BookCase(storiesData: []),
                                    textDisplay: L(ViCode.storiesContinueChapter
                                        .toString())),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${widget.lastUpdated} ${L(ViCode.passedNumberMinuteTextInfo.toString())}',
                          style: FontsDefault.h5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
