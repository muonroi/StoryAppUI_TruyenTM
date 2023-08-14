import 'package:flutter/material.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import '../../../../../Settings/settings.colors.dart';
import '../../../../../Settings/settings.main.dart';
import '../../../Buttons/widget.static.button.search.dart';

class StoriesItems extends StatefulWidget {
  final List<StoryItems> storiesData;
  final List<Widget> dataEachRow;
  final AnimationController reload;
  final AnimationController sort;
  final bool isShowClearText;
  final ValueChanged<String> onChanged;
  final TextEditingController textSearchController;
  const StoriesItems({
    Key? key,
    required this.storiesData,
    required this.reload,
    required this.sort,
    required this.isShowClearText,
    required this.onChanged,
    required this.textSearchController,
    required this.dataEachRow,
  }) : super(key: key);
  @override
  State<StoriesItems> createState() => _StoriesItemsState();
}

class _StoriesItemsState extends State<StoriesItems> {
  var isShort = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.storiesData.length + 1,
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
                              child: SearchContainer(
                                  isShowClearText: widget.isShowClearText,
                                  onChanged: widget.onChanged,
                                  searchController:
                                      widget.textSearchController),
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
                                          widget.sort.reverse(from: 0.5);
                                        } else {
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
                  : widget.dataEachRow[index]
            ],
          );
        });
  }
}
