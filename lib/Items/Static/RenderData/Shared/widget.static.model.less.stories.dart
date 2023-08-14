import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.main.dart';

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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 100)
                        .width,
                child: Text(
                  widget.storyName,
                  style: FontsDefault.h5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              )
            ]),
      ),
    );
  }
}
