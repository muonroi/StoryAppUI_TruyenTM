import 'package:flutter/cupertino.dart';

import '../../Settings/settings.main.dart';

// #region new stories widget
class StoriesNewUpdated extends StatefulWidget {
  const StoriesNewUpdated({
    super.key,
    required this.storiesFillRow,
  });

  final List<Widget> storiesFillRow;
  @override
  State<StoriesNewUpdated> createState() => _StoriesNewUpdatedState();
}

class _StoriesNewUpdatedState extends State<StoriesNewUpdated> {
  @override
  void initState() {
    super.initState();
    _storiesFillRowScales =
        List<double>.filled(widget.storiesFillRow.length, 1.0);
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
          itemCount: widget.storiesFillRow.length,
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
                            child: widget.storiesFillRow[index],
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

class StoriesCategories extends StatefulWidget {
  const StoriesCategories({
    super.key,
    required PageController pageEditorController,
    required this.imageList,
  }) : _pageEditorController = pageEditorController;

  final PageController _pageEditorController;
  final List<Widget> imageList;

  @override
  State<StoriesCategories> createState() => _StoriesCategoriesState();
}

class _StoriesCategoriesState extends State<StoriesCategories> {
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
