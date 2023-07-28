import 'package:flutter/cupertino.dart';

import '../../Settings/settings.main.dart';

// #region new stories widget
class StoriesNewUpdated extends StatefulWidget {
  const StoriesNewUpdated({
    super.key,
    required this.storiesAtLastRows,
    required this.storiesAtFirstRows,
  });

  final List<Widget> storiesAtLastRows;
  final List<Widget> storiesAtFirstRows;
  @override
  State<StoriesNewUpdated> createState() => _StoriesNewUpdatedState();
}

class _StoriesNewUpdatedState extends State<StoriesNewUpdated> {
  List<double> _storiesTheLastScales = [];
  List<double> _storiesTheFirstScales = [];
  @override
  void initState() {
    super.initState();
    _storiesTheFirstScales =
        List<double>.filled(widget.storiesAtFirstRows.length, 1.0);
    _storiesTheLastScales =
        List<double>.filled(widget.storiesAtLastRows.length, 1.0);
  }

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
        height: MainSetting.getPercentageOfDevice(context, expectHeight: 300)
            .height,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.storiesAtFirstRows.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Vertically center the column
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Horizontally center the column
                children: [
                  GestureDetector(
                    onTapDown: (_) => _onTapDown(index, _storiesTheFirstScales),
                    onTapUp: (_) => _onTapUp(index, _storiesTheFirstScales),
                    onTapCancel: () => _onTapUp(index, _storiesTheFirstScales),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            transform: Matrix4.diagonal3Values(
                              _storiesTheFirstScales[index],
                              _storiesTheFirstScales[index],
                              1.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: widget.storiesAtFirstRows[index],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) => _onTapDown(index, _storiesTheLastScales),
                    onTapUp: (_) => _onTapUp(index, _storiesTheLastScales),
                    onTapCancel: () => _onTapUp(index, _storiesTheLastScales),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Center the elements horizontally
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            transform: Matrix4.diagonal3Values(
                              _storiesTheLastScales[index],
                              _storiesTheLastScales[index],
                              1.0,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: widget.storiesAtLastRows[index],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
