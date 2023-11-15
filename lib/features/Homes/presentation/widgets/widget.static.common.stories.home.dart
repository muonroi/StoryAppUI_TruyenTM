import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/bloc/common/common_stories_bloc.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';

class CommonTopStoriesData extends StatefulWidget {
  final EnumStoriesCommon type;
  const CommonTopStoriesData({
    super.key,
    required this.type,
  });

  @override
  State<CommonTopStoriesData> createState() => _CommonTopStoriesDataState();
}

class _CommonTopStoriesDataState extends State<CommonTopStoriesData> {
  @override
  void initState() {
    _commonStoriesBloc = CommonStoriesBloc(1, 4, widget.type);
    _commonStoriesBloc.add(const GetCommonStoriesList(true, isPrevious: false));
    super.initState();
  }

  @override
  void dispose() {
    _commonStoriesBloc.close();
    super.dispose();
  }

  late CommonStoriesBloc _commonStoriesBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _commonStoriesBloc,
      child: BlocListener<CommonStoriesBloc, CommonStoriesState>(
        listener: (context, state) {
          const Center(
            child: CircularProgressIndicator(),
          );
        },
        child: BlocBuilder<CommonStoriesBloc, CommonStoriesState>(
          builder: (context, state) {
            if (state is CommonStoriesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CommonStoriesNoDataState) {
              return getEmptyData(context);
            }
            if (state is CommonStoriesLoadedState) {
              var result = state.stories.result.items;
              return Container(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 250)
                    .height,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.builder(
                  itemCount:
                      result.length > 4 ? result.take(4).length : result.length,
                  itemExtent: 170,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text((index + 1).toString(),
                                          style: CustomFonts.h3(context)
                                              .copyWith(
                                                  color: themeMode(
                                                      context,
                                                      ColorCode
                                                          .mainColor.name))),
                                      SizedBox(
                                          width:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 101.2)
                                                  .width,
                                          height:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectHeight: 145)
                                                  .height,
                                          child: SizedBox(
                                            child: netWorkImage(context,
                                                result[index].imgUrl, true),
                                          )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width:
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectWidth: 140)
                                                .width,
                                        child: Column(
                                          children: [
                                            Text(result[index].storyTitle,
                                                style: CustomFonts.h5(context),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                            Text(result[index].nameCategory,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: CustomFonts.h6(context)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectWidth: 70)
                                      .width,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: themeMode(
                                            context, ColorCode.mainColor.name),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          formatValueNumber(
                                              result[index].totalView * 1.0),
                                          style: CustomFonts.h6(context),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => StoryDetail(
                                                storyId: result[index].id,
                                                storyTitle:
                                                    result[index].storyTitle)));
                                  },
                                  child: Tooltip(
                                    onTriggered: () =>
                                        TooltipTriggerMode.longPress,
                                    message: result[index].storyTitle,
                                    showDuration:
                                        const Duration(milliseconds: 1000),
                                  ),
                                ),
                              ),
                            )
                          ])
                        ],
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
