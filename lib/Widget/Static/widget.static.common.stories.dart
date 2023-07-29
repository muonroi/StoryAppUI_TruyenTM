import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import '../../Settings/settings.fonts.dart';
import '../../Settings/settings.main.dart';

class CommonStories extends StatefulWidget {
  final List<Widget> imageWidget;
  final String nameOfStory;
  final String categoryOfStory;
  final String totalViewOfStory;
  const CommonStories({
    super.key,
    required this.imageWidget,
    required this.nameOfStory,
    required this.categoryOfStory,
    required this.totalViewOfStory,
  });

  @override
  State<CommonStories> createState() => _CommonStoriesState();
}

class _CommonStoriesState extends State<CommonStories> {
  List<bool> _stateOfWidget = [];
  @override
  void initState() {
    super.initState();
    _stateOfWidget = List<bool>.filled(widget.imageWidget.length, false);
  }

  void _toggleItemState(int index) {
    setState(() {
      _stateOfWidget[index] = true;
    });
  }

  void _setDefaultItemState(int index) {
    setState(() {
      _stateOfWidget[index] = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 250).height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTapDown: (_) => _toggleItemState(index),
            onTapUp: (_) => _setDefaultItemState(index),
            onTapCancel: () => _setDefaultItemState(index),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: _stateOfWidget[index] ? Colors.grey[200] : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 20)
                          .width,
                      child: Text((index + 1).toString(),
                          style: FontsDefault.h3
                              .copyWith(color: ColorDefaults.mainColor)),
                    ),
                    widget.imageWidget[index],
                    Column(
                      children: [
                        Text(widget.nameOfStory, style: FontsDefault.h5),
                        Text(widget.categoryOfStory, style: FontsDefault.h6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_red_eye_rounded,
                          color: ColorDefaults.mainColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(widget.totalViewOfStory,
                              style: FontsDefault.h6),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
