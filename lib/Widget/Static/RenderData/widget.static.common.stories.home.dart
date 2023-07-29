import 'package:flutter/material.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import '../../../Models/Stories/TopCommon/models.stories.topcommon.story.dart';
import '../../../Settings/settings.fonts.dart';
import '../../../Settings/settings.main.dart';

class CommonTopStoriesData extends StatefulWidget {
  final List<StoryTopCommon> storiesCommonInfo;

  const CommonTopStoriesData({
    super.key,
    required this.storiesCommonInfo,
  });

  @override
  State<CommonTopStoriesData> createState() => _CommonTopStoriesDataState();
}

class _CommonTopStoriesDataState extends State<CommonTopStoriesData> {
  List<bool> _stateOfWidget = [];
  @override
  void initState() {
    super.initState();
    _stateOfWidget = List<bool>.filled(widget.storiesCommonInfo.length, false);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text((index + 1).toString(),
                                  style: FontsDefault.h3.copyWith(
                                      color: ColorDefaults.mainColor)),
                              widget.storiesCommonInfo[index].image,
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 155)
                                    .width,
                                child: Column(
                                  children: [
                                    Text(widget.storiesCommonInfo[index].name,
                                        style: FontsDefault.h5,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1),
                                    Text(
                                        widget
                                            .storiesCommonInfo[index].category,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: FontsDefault.h6),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MainSetting.getPercentageOfDevice(context,
                                  expectWidth: 65)
                              .width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.remove_red_eye_rounded,
                                color: ColorDefaults.mainColor,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  formatValueNumber(widget
                                      .storiesCommonInfo[index].totalView),
                                  style: FontsDefault.h6,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
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
