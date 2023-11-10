import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/bloc/user/stories_for_user_bloc.dart';
import 'package:muonroi/features/story/data/models/enum/enum.story.user.dart';
import 'package:muonroi/features/story/data/repositories/story_repository.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.model.book.case.stories.dart';
import 'package:muonroi/features/story/data/models/models.stories.story.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesItems extends StatefulWidget {
  final AnimationController reload;
  final AnimationController sort;
  final TextEditingController textSearchController;
  final StoryForUserType storiesTypes;
  const StoriesItems(
      {Key? key,
      required this.reload,
      required this.sort,
      required this.textSearchController,
      required this.storiesTypes})
      : super(key: key);
  @override
  State<StoriesItems> createState() => _StoriesItemsState();
}

class _StoriesItemsState extends State<StoriesItems> {
  @override
  void initState() {
    _isFirstLoad = true;
    _initSharedPreferences();
    _selectedIndex = -1;
    pageIndex = 1;
    pageSize = 5;
    _isPrevious = false;
    _isSelected = false;
    _refreshController = RefreshController(initialRefresh: false);
    _storiesForUserBloc = StoriesForUserBloc(
        pageIndex: pageIndex,
        pageSize: pageSize,
        storyForUserType: widget.storiesTypes);
    _storiesForUserBloc.add(StoriesForUserList(true, isPrevious: _isPrevious));
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _storiesForUserBloc
              .add(const StoriesForUserList(false, isPrevious: true));
        });
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _storiesForUserBloc
              .add(const StoriesForUserList(false, isPrevious: false));
        });
      });
    }
    _refreshController.loadComplete();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late int _selectedIndex;
  late bool _isSelected;
  late bool _isPrevious;
  late RefreshController _refreshController;
  var isShort = false;
  bool isShowClearText = false;
  List<StoryItems> storiesSearch = [];
  late StoriesForUserBloc _storiesForUserBloc;
  late int pageIndex;
  late int pageSize;
  late bool _isFirstLoad;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storiesForUserBloc,
      child: BlocListener<StoriesForUserBloc, StoriesForUserState>(
        listener: (context, state) {
          const Center(child: CircularProgressIndicator());
        },
        child: BlocBuilder<StoriesForUserBloc, StoriesForUserState>(
          builder: (context, state) {
            if (state is StoriesForUserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is StoriesForUserLoadedState) {
              var storiesItem = state.stories.result.items;

              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                footer: ClassicFooter(
                  canLoadingIcon: const Icon(Icons.arrow_downward),
                  canLoadingText: L(context,
                      LanguageCodes.viewNextNotificationTextInfo.toString()),
                  idleText: L(context,
                      LanguageCodes.viewNextNotificationTextInfo.toString()),
                ),
                header: ClassicHeader(
                  idleIcon: const Icon(Icons.arrow_upward),
                  refreshingText: L(
                      context,
                      LanguageCodes.viewPreviousNotificationTextInfo
                          .toString()),
                  releaseText: L(
                      context,
                      LanguageCodes.viewPreviousNotificationTextInfo
                          .toString()),
                  idleText: L(
                      context,
                      LanguageCodes.viewPreviousNotificationTextInfo
                          .toString()),
                ),
                child: ListView.builder(
                    itemCount: storiesSearch.isNotEmpty
                        ? storiesSearch.length
                        : storiesItem.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (_isFirstLoad) {
                        _sharedPreferences.setInt(
                            "story-${storiesItem[index].id}-current-page-index",
                            storiesItem[index].pageCurrentIndex == 0
                                ? 1
                                : storiesItem[index].pageCurrentIndex);

                        _sharedPreferences.setInt(
                            "story-${storiesItem[index].id}-current-chapter-index",
                            storiesItem[index].currentIndex);

                        _sharedPreferences.setInt(
                            "story-${storiesItem[index].id}-current-chapter",
                            storiesItem[index].numberOfChapter);

                        _sharedPreferences.setDouble(
                            "scrollPosition-${storiesItem[index].id}",
                            storiesItem[index].chapterLatestLocation);
                        if (context.mounted) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (context.mounted) {
                              setState(() {
                                _isFirstLoad = false;
                              });
                            }
                          });
                        }
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          index == 0
                              ? SizedBox(
                                  height: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectHeight: 80)
                                      .height,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 200)
                                                  .width,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: TextField(
                                              style: CustomFonts.h5(context),
                                              controller:
                                                  widget.textSearchController,
                                              onChanged: (value) {
                                                if (context.mounted) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    _handleSearch(
                                                        value, storiesItem);
                                                  });
                                                }
                                              },
                                              maxLines: 1,
                                              minLines: 1,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(8.0),
                                                  hintMaxLines: 1,
                                                  hintText: L(
                                                      context,
                                                      LanguageCodes
                                                          .searchTextInfo
                                                          .toString()),
                                                  hintStyle:
                                                      CustomFonts.h5(context),
                                                  suffixIcon: Visibility(
                                                    visible: isShowClearText,
                                                    child: IconButton(
                                                      icon: Icon(Icons.clear,
                                                          color: themeMode(
                                                              context,
                                                              ColorCode
                                                                  .textColor
                                                                  .name)),
                                                      onPressed: () {
                                                        widget
                                                            .textSearchController
                                                            .clear();
                                                      },
                                                    ),
                                                  ),
                                                  prefixIcon: IconButton(
                                                    icon: Icon(
                                                      Icons.search,
                                                      color: themeMode(
                                                          context,
                                                          ColorCode
                                                              .textColor.name),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
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
                                                      _storiesForUserBloc.add(
                                                          const OnRefresh());
                                                      widget.reload
                                                          .reverse(from: 1.0);
                                                      widget.reload
                                                          .forward(from: 0.0);
                                                    });
                                                  },
                                                  icon: Icon(
                                                      Icons.refresh_rounded,
                                                      color: themeMode(
                                                          context,
                                                          ColorCode.textColor
                                                              .name))),
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
                                                        storiesItem.sort(
                                                            (a, b) => a
                                                                .storyTitle
                                                                .compareTo(b
                                                                    .storyTitle));
                                                      });
                                                      widget.sort
                                                          .reverse(from: 0.5);
                                                    } else {
                                                      setState(() {
                                                        storiesItem.sort(
                                                            (a, b) => b
                                                                .storyTitle
                                                                .compareTo(a
                                                                    .storyTitle));
                                                      });
                                                      widget.sort
                                                          .forward(from: 0.0);
                                                    }
                                                    isShort = !isShort;
                                                  },
                                                  icon: Icon(
                                                    Icons.sort,
                                                    color: themeMode(
                                                        context,
                                                        ColorCode
                                                            .textColor.name),
                                                  )),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          index > storiesItem.length - 1
                              ? Container()
                              : GestureDetector(
                                  onLongPress: () => {
                                    setState(() {
                                      _selectedIndex = index;
                                      _isSelected = true;
                                    }),
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      builder: (context) {
                                        return SizedBox(
                                            height: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectHeight: 50)
                                                .height,
                                            child: Column(children: [
                                              IconButton(
                                                  onPressed: () async {
                                                    final storiesRepository =
                                                        StoryRepository();
                                                    var result =
                                                        await storiesRepository
                                                            .deleteStoryForUser(
                                                                storiesItem[
                                                                        index]
                                                                    .idForUser!);
                                                    if (result) {
                                                      setState(() {
                                                        storiesItem.remove(
                                                            storiesItem[index]);
                                                        _isSelected = false;
                                                        _selectedIndex = -1;
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                            ]));
                                      },
                                      context: context,
                                    ).then((value) {
                                      if (_isSelected) {
                                        setState(() {
                                          _isSelected = false;
                                          _selectedIndex = -1;
                                        });
                                      }
                                    })
                                  },
                                  child: StoriesBookCaseModelWidget(
                                    storyInfo: storiesSearch.isNotEmpty
                                        ? storiesSearch[index]
                                        : storiesItem[index],
                                    isSelected:
                                        _isSelected && _selectedIndex == index,
                                  ),
                                )
                        ],
                      );
                    }),
              );
            }
            if (state is StoriesForUserNoDataState) {
              return getEmptyData(context);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
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
