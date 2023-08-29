import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.main.dart';
import 'package:muonroi/features/Stories/presentation/pages/widget.static.stories.detail.dart';

class StoryLessModelWidget extends StatefulWidget {
  final String networkImageUrl;
  final String storyName;
  final int storyId;
  const StoryLessModelWidget(
      {super.key,
      required this.networkImageUrl,
      required this.storyName,
      required this.storyId});

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
      widgetScale = 0.95;
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
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StoriesDetail(
                  storyId: widget.storyId, storyTitle: widget.storyName))),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
        child: Stack(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 100)
                        .height,
                    child: netWorkImage(widget.networkImageUrl, true),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 100)
                      .width,
                  child: Text(
                    widget.storyName,
                    style: FontsDefault.h5,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          showToolTip(widget.storyName)
        ]),
      ),
    );
  }
}
