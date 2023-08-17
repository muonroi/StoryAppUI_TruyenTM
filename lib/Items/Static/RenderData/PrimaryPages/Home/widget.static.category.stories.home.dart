import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.list.stories.image.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.detail.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';

import '../../../../../Settings/settings.main.dart';

// #region new stories widget
class StoriesNewUpdatedData extends StatefulWidget {
  const StoriesNewUpdatedData({
    super.key,
    required this.data,
  });

  final List<Widget> data;
  @override
  State<StoriesNewUpdatedData> createState() => _StoriesNewUpdatedDataState();
}

class _StoriesNewUpdatedDataState extends State<StoriesNewUpdatedData> {
  @override
  void initState() {
    super.initState();
    _storiesFillRowScales = List<double>.filled(widget.data.length, 1.0);
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
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 400).height,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        children: List.generate(6, (index) {
          var infoStory = widget.data[index] as StoriesImageIncludeSizeBox;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (_) => _onTapDown(index, _storiesFillRowScales),
                onTapUp: (_) => _onTapUp(index, _storiesFillRowScales),
                onTapCancel: () => _onTapUp(index, _storiesFillRowScales),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoriesDetail(
                              storyId: infoStory.storyId,
                              storyTitle: infoStory.nameStory)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.diagonal3Values(
                        _storiesFillRowScales[index],
                        _storiesFillRowScales[index],
                        1.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 115)
                                .width,
                            height: MainSetting.getPercentageOfDevice(context,
                                    expectHeight: 170)
                                .height,
                            child: widget.data[index]),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// #endregion

// #region stories was choice by editors
class StoriesOfCategoriesData extends StatefulWidget {
  const StoriesOfCategoriesData({
    super.key,
    required PageController pageEditorController,
    required this.data,
    required this.padding,
  }) : _pageEditorController = pageEditorController;

  final PageController _pageEditorController;
  final List<Widget> data;
  final double padding;
  @override
  State<StoriesOfCategoriesData> createState() =>
      _StoriesOfCategoriesDataState();
}

class _StoriesOfCategoriesDataState extends State<StoriesOfCategoriesData> {
  List<double> _imageScales = [];
  @override
  void initState() {
    super.initState();
    _imageScales = List<double>.filled(widget.data.length, 1.0);
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
          itemCount: widget.data.length,
          scrollDirection: Axis.horizontal,
          controller: widget._pageEditorController,
          itemExtent: 118,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapDown: (_) => _onTapDown(index),
              onTapUp: (_) => _onTapUp(index),
              onTapCancel: () => _onTapUp(index),
              onTap: () {
                if (widget.data[index] is StoriesImageIncludeSizeBox) {
                  StoriesImageIncludeSizeBox infoStory =
                      widget.data[index] as StoriesImageIncludeSizeBox;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StoriesDetail(
                              storyId: infoStory.storyId,
                              storyTitle: infoStory.nameStory)));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: widget.padding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          child: widget.data[index],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

// #endregion
