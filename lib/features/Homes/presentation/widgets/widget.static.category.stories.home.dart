import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/story/bloc/special/special_bloc.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.list.stories.image.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';

// #region new stories widget
class StoriesNewUpdatedData extends StatefulWidget {
  final EnumStoriesSpecial type;
  const StoriesNewUpdatedData({
    super.key,
    required this.type,
  });

  @override
  State<StoriesNewUpdatedData> createState() => _StoriesNewUpdatedDataState();
}

class _StoriesNewUpdatedDataState extends State<StoriesNewUpdatedData> {
  @override
  void initState() {
    _specialStoriesBloc = SpecialStoriesBloc(1, 20, widget.type);
    _specialStoriesBloc
        .add(const GetSpecialStoriesList(true, isPrevious: false));

    super.initState();
  }

  @override
  void dispose() {
    _specialStoriesBloc.close();
    super.dispose();
  }

  late SpecialStoriesBloc _specialStoriesBloc;
  bool isTapDown = false;
  double scale = 1.0;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _specialStoriesBloc,
      child: BlocListener<SpecialStoriesBloc, SpecialStoriesState>(
        listener: (context, state) {
          const Center(child: CircularProgressIndicator());
        },
        child: BlocBuilder<SpecialStoriesBloc, SpecialStoriesState>(
          builder: (context, state) {
            if (state is SpecialStoriesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SpecialStoriesNoDataState) {
              return getEmptyData(context);
            }
            if (state is SpecialStoriesLoadedState) {
              var result = state.stories.result.items;
              return SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 400)
                    .height,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  children: List.generate(result.take(6).length, (index) {
                    var infoStory = result[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              selectedIndex = index;
                              isTapDown = true;
                            });
                            startResizeAnimation();
                          },
                          onTapUp: (_) {
                            setState(() {
                              selectedIndex = -1;
                              isTapDown = false;
                            });
                            cancelResizeAnimation();
                          },
                          onTapCancel: () {
                            setState(() {
                              selectedIndex = -1;
                              isTapDown = false;
                            });
                            cancelResizeAnimation();
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoryDetail(
                                        storyId: infoStory.id,
                                        storyTitle: infoStory.storyTitle)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                transform: Matrix4.diagonal3Values(
                                  selectedIndex == index ? 0.9 : 1.0,
                                  selectedIndex == index ? 0.9 : 1.0,
                                  1.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(
                                      width: MainSetting.getPercentageOfDevice(
                                              context,
                                              expectWidth: 115)
                                          .width,
                                      height: MainSetting.getPercentageOfDevice(
                                              context,
                                              expectHeight: 170)
                                          .height,
                                      child: netWorkImage(
                                          context, result[index].imgUrl, true)),
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
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void startResizeAnimation() {
    setState(() {
      scale = 0.9;
    });
  }

  void cancelResizeAnimation() {
    setState(() {
      scale = 1.0;
    });
  }
}

// #endregion

// #region stories was choice by editors
// ignore: must_be_immutable
class StoriesOfCategoriesData extends StatefulWidget {
  StoriesOfCategoriesData({
    super.key,
    required PageController pageEditorController,
    required this.padding,
    required this.type,
    required this.isHaveData,
    this.data,
  }) : _pageEditorController = pageEditorController;
  final bool isHaveData;
  late List<Widget>? data;
  final PageController _pageEditorController;
  final EnumStoriesSpecial type;
  final double padding;
  @override
  State<StoriesOfCategoriesData> createState() =>
      _StoriesOfCategoriesDataState();
}

class _StoriesOfCategoriesDataState extends State<StoriesOfCategoriesData> {
  List<double> _imageScales = [];
  @override
  void initState() {
    _specialStoriesBloc = SpecialStoriesBloc(1, 20, widget.type);
    _specialStoriesBloc
        .add(const GetSpecialStoriesList(true, isPrevious: false));
    if (widget.isHaveData) {
      _imageScales = List<double>.filled(widget.data!.length, 1.0);
    }
    super.initState();
  }

  @override
  void dispose() {
    _specialStoriesBloc.close();
    super.dispose();
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

  late SpecialStoriesBloc _specialStoriesBloc;
  bool isTapDown = false;
  double scale = 1.0;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return !widget.isHaveData
        ? BlocProvider(
            create: (context) => _specialStoriesBloc,
            child: BlocListener<SpecialStoriesBloc, SpecialStoriesState>(
              listener: (context, state) {
                buildLoadingListView(
                    context,
                    MainSetting.getPercentageOfDevice(context, expectWidth: 90)
                        .width,
                    MainSetting.getPercentageOfDevice(context,
                            expectHeight: 145)
                        .height,
                    MainSetting.getPercentageOfDevice(context, expectWidth: 100)
                        .width!);
              },
              child: BlocBuilder<SpecialStoriesBloc, SpecialStoriesState>(
                builder: (context, state) {
                  if (state is SpecialStoriesLoadingState) {
                    return buildLoadingListView(
                        context,
                        MainSetting.getPercentageOfDevice(context,
                                expectWidth: 90)
                            .width,
                        MainSetting.getPercentageOfDevice(context,
                                expectHeight: 145)
                            .height,
                        MainSetting.getPercentageOfDevice(context,
                                expectWidth: 100)
                            .width!);
                  }
                  if (state is SpecialStoriesNoDataState) {
                    return getEmptyData(context);
                  }
                  if (state is SpecialStoriesLoadedState) {
                    var result = state.stories.result.items;
                    return SizedBox(
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 150)
                          .height,
                      child: ListView.builder(
                          itemCount: result.length,
                          scrollDirection: Axis.horizontal,
                          controller: widget._pageEditorController,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTapDown: (_) {
                                setState(() {
                                  selectedIndex = index;
                                  isTapDown = true;
                                });
                                startResizeAnimation();
                              },
                              onTapUp: (_) {
                                setState(() {
                                  selectedIndex = -1;
                                  isTapDown = false;
                                });
                                cancelResizeAnimation();
                              },
                              onTapCancel: () {
                                setState(() {
                                  selectedIndex = -1;
                                  isTapDown = false;
                                });
                                cancelResizeAnimation();
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoryDetail(
                                            storyId: result[index].id,
                                            storyTitle:
                                                result[index].storyTitle)));
                              },
                              child: Stack(children: [
                                AnimatedContainer(
                                  curve: Curves.easeInOut,
                                  transform: Matrix4.diagonal3Values(
                                    selectedIndex == index ? 0.9 : 1.0,
                                    selectedIndex == index ? 0.9 : 1.0,
                                    1.0,
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.padding),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: SizedBox(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: netWorkImage(context,
                                                  result[index].imgUrl, true,
                                                  isHome: true)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                showToolTip(result[index].storyTitle)
                              ]),
                            );
                          }),
                    );
                  }
                  return buildLoadingListView(
                      context,
                      MainSetting.getPercentageOfDevice(context,
                              expectWidth: 90)
                          .width,
                      MainSetting.getPercentageOfDevice(context,
                              expectHeight: 145)
                          .height,
                      MainSetting.getPercentageOfDevice(context,
                              expectWidth: 100)
                          .width!);
                },
              ),
            ),
          )
        : SizedBox(
            height:
                MainSetting.getPercentageOfDevice(context, expectHeight: 150)
                    .height,
            child: ListView.builder(
                itemCount: widget.data!.length,
                scrollDirection: Axis.horizontal,
                controller: widget._pageEditorController,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTapDown: (_) => _onTapDown(index),
                    onTapUp: (_) => _onTapUp(index),
                    onTapCancel: () => _onTapUp(index),
                    onTap: () {
                      if (widget.data![index] is StoriesImageIncludeSizeBox) {
                        StoriesImageIncludeSizeBox infoStory =
                            widget.data![index] as StoriesImageIncludeSizeBox;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryDetail(
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
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeInOut,
                              transform: Matrix4.diagonal3Values(
                                _imageScales.isNotEmpty
                                    ? _imageScales[index]
                                    : 0.9,
                                _imageScales.isNotEmpty
                                    ? _imageScales[index]
                                    : 0.9,
                                1.0,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: widget.data![index]),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
  }

  void startResizeAnimation() {
    setState(() {
      scale = 0.9;
    });
  }

  void cancelResizeAnimation() {
    setState(() {
      scale = 1.0;
    });
  }
}

// #endregion
