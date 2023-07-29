import 'package:flutter/cupertino.dart';

import '../../../Settings/settings.main.dart';

// #region new stories widget
class StoriesNewUpdatedData extends StatefulWidget {
  const StoriesNewUpdatedData({
    super.key,
    required this.storiesData,
  });

  final List<Widget> storiesData;
  @override
  State<StoriesNewUpdatedData> createState() => _StoriesNewUpdatedDataState();
}

class _StoriesNewUpdatedDataState extends State<StoriesNewUpdatedData> {
  @override
  void initState() {
    super.initState();
    _storiesFillRowScales = List<double>.filled(widget.storiesData.length, 1.0);
  }

  List<double> _storiesFillRowScales = [];
  void _onTapDown(int index, List<double> doubleContainSizeStories) {
    setState(() {
      doubleContainSizeStories[index] = 0.9;
    });
  }

  void _onTapUp(int index, List<double> doubleContainSizeStories) {
    setState(() {
      doubleContainSizeStories[index] = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MainSetting.getPercentageOfDevice(context, expectHeight: 140)
            .height,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.storiesData.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Vertically center the column
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Horizontally center the column
              children: [
                GestureDetector(
                  onTapDown: (_) => _onTapDown(index, _storiesFillRowScales),
                  onTapUp: (_) => _onTapUp(index, _storiesFillRowScales),
                  onTapCancel: () => _onTapUp(index, _storiesFillRowScales),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          transform: Matrix4.diagonal3Values(
                            _storiesFillRowScales[index],
                            _storiesFillRowScales[index],
                            1.0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget.storiesData[index],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}

// #endregion

// #region stories was choice by editors
class StoriesOfCategoriesData extends StatefulWidget {
  const StoriesOfCategoriesData({
    super.key,
    required PageController pageEditorController,
    required this.imageList,
  }) : _pageEditorController = pageEditorController;

  final PageController _pageEditorController;
  final List<Widget> imageList;

  @override
  State<StoriesOfCategoriesData> createState() =>
      _StoriesOfCategoriesDataState();
}

class _StoriesOfCategoriesDataState extends State<StoriesOfCategoriesData> {
  List<double> _imageScales = [];
  @override
  void initState() {
    super.initState();
    _imageScales = List<double>.filled(widget.imageList.length, 1.0);
  }

  void _onTapDown(int index) {
    setState(() {
      _imageScales[index] = 0.9;
    });
  }

  void _onTapUp(int index) {
    setState(() {
      _imageScales[index] = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 150).height,
      child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          controller: widget._pageEditorController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapDown: (_) => _onTapDown(index),
              onTapUp: (_) => _onTapUp(index),
              onTapCancel: () => _onTapUp(index),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.diagonal3Values(
                        _imageScales[index],
                        _imageScales[index],
                        1.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: widget.imageList[index],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

// #endregion
