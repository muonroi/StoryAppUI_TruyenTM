import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/chapters/bloc/group_bloc/group_chapters_of_story_bloc.dart';
import 'package:muonroi/features/chapters/bloc/latest_bloc/latest_chapter_of_story_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChapterListPage extends StatefulWidget {
  final int storyId;
  final String author;
  final String storyTitle;
  final int lastChapterId;
  final int firstChapterId;
  final int totalChapter;
  final String storyImageUrl;
  final bool isAudio;
  final Function(int index, int pageIndex)? chapterCallback;
  const ChapterListPage(
      {super.key,
      required this.storyId,
      required this.storyTitle,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.totalChapter,
      required this.storyImageUrl,
      required this.isAudio,
      required this.chapterCallback,
      required this.author});

  @override
  State<ChapterListPage> createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _isNetwork = false;
    _selectedPageIndexUi = 0;
    _selectedItemOffset = 0.0;
    _selectedPageIndexOffset = 0.0;
    _isLoadPageIndex = true;
    _fromId = 0;
    _toId = 0;
    _isLoadItemIndex = true;
    _chapterPagingKeys = [];
    _isShort = false;
    _isLock = true;
    _pageIndexController = ScrollController();
    _itemController = ScrollController();
    _selectedPageIndex = 0;
    _selectedItemIndex = 0;
    _animationSortController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: .5);
    _latestChapterOfStoryBloc =
        LatestChapterOfStoryBloc(widget.storyId, false, 1, 100, 0);
    _groupChapterOfStoryBloc =
        GroupChapterOfStoryBloc(widget.storyId, 1, 15, false, 0);
    _groupChapterOfStoryBloc.add(GroupChapterOfStoryList());
    super.initState();
    _initSharedPreferences().then((value) => _latestChapterOfStoryBloc.add(
        GetFromToChapterOfStoryList(
            pageIndex: _selectedPageIndexUi,
            fromChapterId: _fromId,
            toChapterId: _toId)));
  }

  @override
  void dispose() {
    _isLoadItemIndex = false;
    _isLoadPageIndex = false;
    _animationSortController.dispose();
    _pageIndexController.dispose();
    _itemController.dispose();
    _groupChapterOfStoryBloc.close();
    _latestChapterOfStoryBloc.close();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _selectedPageIndexUi = _sharedPreferences.getInt(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index-ui") ??
        0;
    _selectedItemIndex = _sharedPreferences.getInt(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-item-index") ??
        0;
    _selectedPageIndex = _sharedPreferences.getInt(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index") ??
        1;
    _fromId = _sharedPreferences.getInt(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-from-chapter-id") ??
        -1;
    _toId = _sharedPreferences.getInt(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-to-chapter-id") ??
        0;

    _selectedItemOffset = _sharedPreferences.getDouble(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-item-index-offset") ??
        0.0;
    _selectedPageIndexOffset = _sharedPreferences.getDouble(
            "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index-offset") ??
        0.0;
    _isNetwork = _sharedPreferences.getBool('availableInternet')!;
    _isLock = _isNetwork == false ? false : true;
  }

  void _loadScrollItem() {
    if (_isLoadPageIndex &&
        _pageIndexController.hasClients &&
        _chapterPagingKeys.isNotEmpty) {
      scrollItem(_selectedPageIndex);
    }
  }

  void _loadPageIndex() {
    if (_isLoadPageIndex && mounted && _pageIndexController.hasClients) {
      _pageIndexController.jumpTo(_selectedPageIndexOffset);
      if (_fromId != 0 || _toId != 0) {
        _latestChapterOfStoryBloc.add(GetFromToChapterOfStoryList(
            pageIndex: _selectedPageIndex,
            fromChapterId: _fromId,
            toChapterId: _toId));
      }
      _isLoadPageIndex = false;
    }
  }

  void loadItemIndex() {
    if (_isLoadItemIndex &&
        mounted &&
        _itemController.hasClients &&
        _selectedItemOffset > 0) {
      _itemController.jumpTo(_selectedItemOffset);
      _isLoadItemIndex = false;
    }
  }

  late bool _isNetwork;
  late int _fromId;
  late int _toId;
  late SharedPreferences _sharedPreferences;
  late AnimationController _animationSortController;
  late ScrollController _pageIndexController;
  late ScrollController _itemController;
  late List<GlobalKey> _chapterPagingKeys;
  late bool _isShort;
  late GroupChapterOfStoryBloc _groupChapterOfStoryBloc;
  late LatestChapterOfStoryBloc _latestChapterOfStoryBloc;
  late int _selectedPageIndex;
  late int _selectedPageIndexUi;
  late bool _isLock;
  late int _selectedItemIndex;
  late bool _isLoadPageIndex;
  late bool _isLoadItemIndex;
  late double _selectedPageIndexOffset;
  late double _selectedItemOffset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeMode(context, ColorCode.modeColor.name),
        appBar: !widget.isAudio
            ? AppBar(
                backgroundColor: themeMode(context, ColorCode.modeColor.name),
                elevation: 0,
                leading: IconButton(
                  splashRadius: 22,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                  color: themeMode(context, ColorCode.textColor.name),
                ),
                title: Title(
                    color: themeMode(context, ColorCode.modeColor.name),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          L(
                              context,
                              LanguageCodes.listChapterStoryTextInfo
                                  .toString()),
                          style: CustomFonts.h5(context)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Stack(children: [
                          Text(
                            widget.storyTitle,
                            style:
                                CustomFonts.h6(context).copyWith(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          showToolTip(widget.storyTitle)
                        ]),
                      ],
                    )),
              )
            : AppBar(
                backgroundColor: themeMode(context, ColorCode.modeColor.name),
                elevation: 1,
                automaticallyImplyLeading: false,
                title: Title(
                  color: themeMode(context, ColorCode.modeColor.name),
                  child: Text(
                    L(context,
                        LanguageCodes.listChapterStoryTextInfo.toString()),
                    style: CustomFonts.h5(context)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
        body: Column(
          children: [
            Container(
              color: themeMode(context, ColorCode.modeColor.name),
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 50)
                      .height,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    flex: 1,
                    child: RotationTransition(
                      turns: Tween(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(_animationSortController),
                      child: IconButton(
                          onPressed: () {
                            if (_isShort) {
                              _animationSortController.reverse(from: 0.5);
                            } else {
                              _animationSortController.forward(from: 0.0);
                            }
                            _isShort = !_isShort;

                            _sharedPreferences.setBool(
                                "iShort-${widget.storyId}", _isShort);
                            _selectedItemIndex = -1;
                          },
                          icon: Icon(
                            Icons.sort,
                            color: themeMode(context, ColorCode.textColor.name),
                          )),
                    )),
                BlocProvider(
                  create: (context) => _groupChapterOfStoryBloc,
                  child: BlocListener<GroupChapterOfStoryBloc,
                      GroupChapterOfStoryState>(
                    listener: (context, state) {
                      const Center(child: CircularProgressIndicator());
                    },
                    child: BlocBuilder<GroupChapterOfStoryBloc,
                        GroupChapterOfStoryState>(
                      builder: (context, state) {
                        if (state is GroupChapterOfStoryLoadingState) {
                          if (!_isNetwork) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                _isLock = false;
                              });
                            });
                            return getNoInternetData(context);
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }
                        if (state is GroupChapterOfStoryLoadedState) {
                          _loadScrollItem();
                          _loadPageIndex();
                          for (int i = 0;
                              i < state.chapter.result.length;
                              i++) {
                            _chapterPagingKeys.add(GlobalKey());
                          }
                          return Expanded(
                              flex: 4,
                              child: ListView.builder(
                                  controller: _pageIndexController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.chapter.result.length,
                                  itemBuilder: ((context, index) {
                                    var chapterPagingInfo =
                                        state.chapter.result[index];
                                    return InkWell(
                                      hoverColor: themeMode(
                                          context, ColorCode.textColor.name),
                                      splashColor: themeMode(
                                              context, ColorCode.mainColor.name)
                                          .withOpacity(0.5),
                                      onTap: !_isLock
                                          ? () async {
                                              _sharedPreferences.setInt(
                                                  "selected-chapter-${widget.storyId}-${widget.isAudio}-from-chapter-id",
                                                  chapterPagingInfo.fromId);
                                              _sharedPreferences.setInt(
                                                  "selected-chapter-${widget.storyId}-${widget.isAudio}-to-chapter-id",
                                                  chapterPagingInfo.toId);
                                              _sharedPreferences.setDouble(
                                                  "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index-offset",
                                                  _pageIndexController.offset);
                                              _sharedPreferences.setInt(
                                                  "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index-ui",
                                                  index);
                                              _sharedPreferences.setInt(
                                                  "selected-chapter-${widget.storyId}-${widget.isAudio}-page-index",
                                                  index + 1);

                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                setState(() {
                                                  _isLock = true;
                                                  _selectedPageIndexUi = index;
                                                  _selectedItemIndex = -1;
                                                  _latestChapterOfStoryBloc.add(
                                                      GetFromToChapterOfStoryList(
                                                          pageIndex:
                                                              chapterPagingInfo
                                                                  .pageIndex,
                                                          fromChapterId:
                                                              chapterPagingInfo
                                                                  .fromId,
                                                          toChapterId:
                                                              chapterPagingInfo
                                                                  .toId));
                                                });
                                              });
                                              await scrollItem(index);
                                            }
                                          : () {},
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              key: _chapterPagingKeys[index],
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              child:
                                                  _selectedPageIndexUi == index
                                                      ? Text(
                                                          '${chapterPagingInfo.from}-${chapterPagingInfo.to}',
                                                          style: TextStyle(
                                                              color: themeMode(
                                                                  context,
                                                                  ColorCode
                                                                      .mainColor
                                                                      .name)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      : Text(
                                                          '${chapterPagingInfo.from}-${chapterPagingInfo.to}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: themeMode(
                                                                  context,
                                                                  ColorCode
                                                                      .textColor
                                                                      .name)),
                                                        ))
                                        ],
                                      ),
                                    );
                                  })));
                        }
                        if (!_isNetwork) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _isLock = false;
                            });
                          });
                          return getNoInternetData(context);
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ]),
            ),
            BlocProvider(
              create: (context) => _latestChapterOfStoryBloc,
              child: BlocListener<LatestChapterOfStoryBloc,
                  LatestChapterOfStoryState>(
                listener: (context, state) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                child: BlocBuilder<LatestChapterOfStoryBloc,
                    LatestChapterOfStoryState>(
                  builder: (context, state) {
                    if (state is FromToChapterOfStoryLoadingState) {
                      if (!_isNetwork) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            _isLock = false;
                          });
                        });
                        return getNoInternetData(context);
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is FromToChapterOfStoryLoadedState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _isLock = false;
                        });
                      });
                      List<int> originalIndices = List.generate(
                          state.chapter.result.length, (index) => index);
                      return Expanded(
                          child: ListView.builder(
                        controller: _itemController,
                        itemCount: state.chapter.result.length,
                        itemBuilder: ((context, index) {
                          //    _loadItemIndex();

                          if (!_isShort) {
                            state.chapter.result.sort((a, b) =>
                                a.numberOfChapter.compareTo(b.numberOfChapter));
                          }
                          if (_isShort) {
                            state.chapter.result.sort((a, b) =>
                                b.numberOfChapter.compareTo(a.numberOfChapter));
                          }
                          var chapterInfo = state.chapter.result[index];

                          return Container(
                            color: themeMode(context, ColorCode.modeColor.name),
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      _selectedItemIndex = _isShort
                                          ? originalIndices.length - 1 - index
                                          : index;
                                      _sharedPreferences.setDouble(
                                          "selected-chapter-${widget.storyId}-${widget.isAudio}-item-index-offset",
                                          _itemController.offset);

                                      _sharedPreferences.setInt(
                                          "selected-chapter-${widget.storyId}-${widget.isAudio}-item-index",
                                          _selectedItemIndex);

                                      _sharedPreferences.setInt(
                                          "story-${widget.storyId}-current-page-index",
                                          chapterInfo.groupIndex == 0
                                              ? 1
                                              : chapterInfo.groupIndex);

                                      _sharedPreferences.setInt(
                                          "story-${widget.storyId}-current-chapter-index",
                                          _isShort
                                              ? originalIndices.length -
                                                  1 -
                                                  index
                                              : index);
                                      _sharedPreferences.setInt(
                                          "story-${widget.storyId}-current-chapter-id",
                                          chapterInfo.id);
                                      _sharedPreferences.setInt(
                                          "story-${widget.storyId}-current-chapter",
                                          chapterInfo.numberOfChapter);
                                      if (context.mounted) {
                                        !widget.isAudio
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Chapter(
                                                    author: widget.author,
                                                    imageUrl:
                                                        widget.storyImageUrl,
                                                    chapterNumber: chapterInfo
                                                        .numberOfChapter,
                                                    totalChapter:
                                                        widget.totalChapter,
                                                    pageIndex:
                                                        chapterInfo.groupIndex,
                                                    isLoadHistory: false,
                                                    storyId:
                                                        chapterInfo.storyId,
                                                    storyName:
                                                        widget.storyTitle,
                                                    chapterId: chapterInfo.id,
                                                    lastChapterId:
                                                        widget.lastChapterId,
                                                    firstChapterId:
                                                        widget.firstChapterId,
                                                    loadSingleChapter: true,
                                                  ),
                                                ))
                                            : widget.chapterCallback!(
                                                _isShort
                                                    ? originalIndices.length -
                                                        1 -
                                                        index
                                                    : index,
                                                chapterInfo.groupIndex,
                                              );
                                      }
                                    },
                                    child: Stack(children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      style: BorderStyle.solid,
                                                      width: 0.2))),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MainSetting
                                                        .getPercentageOfDevice(
                                                            context,
                                                            expectWidth: 40)
                                                    .width,
                                                child: Text(
                                                  '${chapterInfo.numberOfChapter}',
                                                  style: TextStyle(
                                                    color: themeMode(
                                                        context,
                                                        ColorCode
                                                            .textColor.name),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MainSetting
                                                        .getPercentageOfDevice(
                                                            context,
                                                            expectWidth:
                                                                !widget.isAudio
                                                                    ? 300
                                                                    : 200)
                                                    .width,
                                                child: Text(
                                                  chapterInfo.chapterTitle
                                                      .trim()
                                                      .replaceAll('\n', '')
                                                      .replaceAll(
                                                          RegExp(
                                                              r'Chương \d+: '),
                                                          '')
                                                      .replaceAll(
                                                          RegExp(
                                                              r'chương \d+:: '),
                                                          ''),
                                                  style: CustomFonts.h5(context)
                                                      .copyWith(
                                                          color: index ==
                                                                  _selectedItemIndex
                                                              ? themeMode(
                                                                  context,
                                                                  ColorCode
                                                                      .mainColor
                                                                      .name)
                                                              : null),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              !widget.isAudio
                                                  ? SizedBox(
                                                      child: Icon(
                                                        size: 15,
                                                        Icons.arrow_forward_ios,
                                                        color: themeMode(
                                                            context,
                                                            ColorCode.textColor
                                                                .name),
                                                      ),
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ));
                    }
                    if (!_isNetwork) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _isLock = false;
                        });
                      });
                      return getNoInternetData(context);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  Future scrollItem(int index) async {
    if (mounted) {
      await Scrollable.ensureVisible(_chapterPagingKeys[index].currentContext!,
          alignment: 0.3, duration: const Duration(milliseconds: 300));
    }
  }
}
