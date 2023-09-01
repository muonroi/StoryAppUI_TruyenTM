import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.model.book.case.stories.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';

class StoriesItems extends StatefulWidget {
  final List<StoryItems> storiesData;
  final AnimationController reload;
  final AnimationController sort;
  final TextEditingController textSearchController;
  const StoriesItems({
    Key? key,
    required this.storiesData,
    required this.reload,
    required this.sort,
    required this.textSearchController,
  }) : super(key: key);
  @override
  State<StoriesItems> createState() => _StoriesItemsState();
}

class _StoriesItemsState extends State<StoriesItems> {
  @override
  void initState() {
    super.initState();
  }

  var isShort = false;
  bool isShowClearText = false;
  List<StoryItems> storiesSearch = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: storiesSearch.isNotEmpty
            ? storiesSearch.length
            : widget.storiesData.length + 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              index == 0
                  ? SizedBox(
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 80)
                          .height,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 200)
                                  .width,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextField(
                                  controller: widget.textSearchController,
                                  onChanged: (value) {
                                    if (context.mounted) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        _handleSearch(
                                            value, widget.storiesData);
                                      });
                                    }
                                  },
                                  maxLines: 1,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(8.0),
                                      hintMaxLines: 1,
                                      hintText:
                                          L(ViCode.searchTextInfo.toString()),
                                      suffixIcon: Visibility(
                                        visible: isShowClearText,
                                        child: IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            widget.textSearchController.clear();
                                          },
                                        ),
                                      ),
                                      prefixIcon: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {},
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                RotationTransition(
                                  turns: Tween(
                                    begin: 0.0,
                                    end: 1.0,
                                  ).animate(widget.reload),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          widget.reload.reverse(from: 1.0);
                                          widget.reload.forward(from: 0.0);
                                        });
                                      },
                                      icon: const Icon(Icons.refresh_rounded)),
                                ),
                                RotationTransition(
                                  turns: Tween(
                                    begin: 0.0,
                                    end: 1.0,
                                  ).animate(widget.sort),
                                  child: IconButton(
                                      onPressed: () {
                                        if (isShort) {
                                          setState(() {
                                            widget.storiesData.sort((a, b) => a
                                                .storyTitle
                                                .compareTo(b.storyTitle));
                                          });
                                          widget.sort.reverse(from: 0.5);
                                        } else {
                                          setState(() {
                                            widget.storiesData.sort((a, b) => b
                                                .storyTitle
                                                .compareTo(a.storyTitle));
                                          });
                                          widget.sort.forward(from: 0.0);
                                        }
                                        isShort = !isShort;
                                      },
                                      icon: const Icon(
                                        Icons.sort,
                                        color: ColorDefaults.thirdMainColor,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
              index > widget.storiesData.length - 1
                  ? Container()
                  : StoriesBookCaseModelWidget(
                      storyInfo: storiesSearch.isNotEmpty
                          ? storiesSearch[index]
                          : widget.storiesData[index])
            ],
          );
        });
  }

  void _handleSearch(String value, List<StoryItems> data) {
    final isInputNotEmpty = value.isNotEmpty;
    List<StoryItems> searchedStories = [];
    if (isInputNotEmpty) {
      searchedStories.addAll(data.where((element) =>
          element.storyTitle.toLowerCase().contains(value.toLowerCase())));
    }
    setState(() {
      isShowClearText = isInputNotEmpty;
      storiesSearch = searchedStories;
    });
  }
}
