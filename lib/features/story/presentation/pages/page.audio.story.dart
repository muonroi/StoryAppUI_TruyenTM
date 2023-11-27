import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/chapters/bloc/group_chapter/group_chapter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/data/service/api.chapter.service.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.list.chapter.audio.dart';
import 'package:muonroi/features/story/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoryAudio extends StatefulWidget {
  final String title;
  final int storyId;
  final int chapterId;
  final String imageUrl;
  final int firstChapterId;
  final int lastChapterId;
  final int totalChapter;
  const StoryAudio(
      {super.key,
      required this.title,
      required this.storyId,
      required this.chapterId,
      required this.imageUrl,
      required this.firstChapterId,
      required this.lastChapterId,
      required this.totalChapter});

  @override
  State<StoryAudio> createState() => _StoryAudioState();
}

class _StoryAudioState extends State<StoryAudio> with WidgetsBindingObserver {
  @override
  void initState() {
    _textTimerController = TextEditingController();
    _fromToChapterList = "";
    _chapterId = [];
    _currentChapterIndex = 0;
    _isOptionVolume = true;
    _totalChapter = 0;
    _isDisplayPauseIcon = false;
    _currentChapterChunkIndex = 0;
    _chapterSplit = [];
    _pageIndex = 1;
    _volume = 2.5;
    _pitch = 1.0;
    _rate = 0.5;
    _newVoiceText = "";
    _flutterTts = FlutterTts();
    _flutterTts.setLanguage("vi-VN");
    _chapterController = ScrollController(initialScrollOffset: 0.0);
    _groupChaptersBloc = GroupChapterBloc(widget.storyId, _pageIndex, 99);
    _speakingChapterContent();
    _textTimerController = TextEditingController();
    _getVoice();
    _voices = [];

    super.initState();
    _initSharedPreferences();
  }

  @override
  void dispose() {
    _textTimerController.dispose();
    _chapterController.dispose();
    _stop();
    super.dispose();
  }
// #region method

  Future _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _fromToChapterList = _sharedPreferences
            .getString("getGroupChaptersDataDetail-${widget.storyId}") ??
        "";
    _pageIndex = _sharedPreferences
            .getInt("selected-chapter-${widget.storyId}-true-page-index") ??
        1;
    _currentChapterIndex = _sharedPreferences
            .getInt("selected-chapter-${widget.storyId}-true-item-index") ??
        0;
    _currentChapterChunkIndex = _sharedPreferences.getInt(
            "selected-chapter-chunk-${widget.storyId}-true-page-index") ??
        0;
    _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
  }

  Future _setVolume(value) async {
    _pause();
    await _flutterTts.setVolume(value);
    _speak();
  }

  Future _getVoice() async {
    //vi-vn-x-gft-local
    _voices = await _flutterTts.getVoices;
    setState(() {
      _voices = _voices!.where((voice) => voice['locale'] == 'vi-VN').toList();
    });
  }

  Column _buildButtonColumn(
      Color color, Color splashColor, IconData icon, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
        ]);
  }

  Future _speakingChapterContent() async {
    _flutterTts.setCompletionHandler(() {
      _currentChapterChunkIndex = _currentChapterChunkIndex + 1;
      if (_currentChapterChunkIndex <= _chapterSplit.length - 1) {
        _currentChapterChunkIndex =
            _currentChapterChunkIndex >= _chapterSplit.length - 1
                ? _chapterSplit.length - 1
                : _currentChapterChunkIndex;
        _fastForward(_currentChapterChunkIndex);
      } else {
        _skip(true);
      }
    });
    await _flutterTts.setVolume(_volume);
    await _flutterTts.setSpeechRate(_rate);
    await _flutterTts.setPitch(_pitch);
    // await _flutterTts.awaitSpeakCompletion(true);
  }

  Future _speak({List<String>? data, bool isChangeIcon = true}) async {
    if (isChangeIcon) {
      setState(() {
        _isDisplayPauseIcon = true;
      });
    }
    if (data == null) {
      setState(() {
        _newVoiceText =
            parseHtmlString(_chapterSplit[_currentChapterChunkIndex])
                .trim()
                .trimLeft()
                .trimRight();
      });
    } else {
      setState(() {
        _newVoiceText = parseHtmlString(data[_currentChapterChunkIndex])
            .trim()
            .trimLeft()
            .trimRight();
      });
    }

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await _flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) setState(() => _ttsState = TtsState.stopped);
  }

  Future _pause() async {
    setState(() {
      _isDisplayPauseIcon = false;
    });
    var result = await _flutterTts.pause();
    if (result == 1) setState(() => _ttsState = TtsState.paused);
  }

  Future _updateNewDataWhenSkip(String chapterData) async {
    await _flutterTts.speak(parseHtmlString(chapterData));
  }

  void _skip(bool next) {
    // #region Logic skip
    setState(() {
      _currentChapterChunkIndex = 0;
      _isDisplayPauseIcon = true;
    });
    _stop();
    if (next) {
      setState(() {
        _currentChapterIndex++;
      });
    } else {
      setState(() {
        _currentChapterIndex--;
      });
    }
    setState(() {
      _currentChapterIndex = _currentChapterIndex < 0
          ? 0
          : _currentChapterIndex > _totalChapter - 1
              ? _totalChapter
              : _currentChapterIndex;
    });

    if (_currentChapterIndex > _totalChapter - 1) {
      _pageIndex = _pageIndex + 1;
      _updateChapterId(0, _pageIndex);
      _currentChapterIndex = 0;
    } else if (_currentChapterIndex == 0) {
      if (_pageIndex > 1) {
        _pageIndex = _pageIndex > 0 ? _pageIndex - 1 : _pageIndex;
        _updateChapterId(0, _pageIndex == 0 ? 1 : _pageIndex);
        _currentChapterIndex = 99;
      }
    } else {
      setState(() {
        _newVoiceText = parseHtmlString(_chapterSplit[
            _currentChapterChunkIndex > _chapterSplit.length - 1
                ? 0
                : _currentChapterChunkIndex]);
      });
    }
    // #endregion

    // #region Private audio
    var fromToChapterInfo = listPagingChaptersFromJson(_fromToChapterList);

    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-page-index-audio", _pageIndex);
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-from-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].fromId);
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-to-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].toId);

    // #endregion

    // #region save
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-item-index",
        _currentChapterIndex);

    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-page-index-ui",
        _pageIndex - 1);
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-true-page-index", _pageIndex);
    // #endregion
  }

  void _chapterSelected(int index, int pageIndex) {
    setState(() {
      _currentChapterChunkIndex = 0;
    });
    _updateChapterId(index, pageIndex);

    debugPrint("$index - $pageIndex");
  }

  void _fastForward(value) {
    setState(() {
      _isDisplayPauseIcon = true;
    });
    _pause();
    if (value >= 0 && value <= _chapterSplit.length) {
      setState(() {
        _newVoiceText = parseHtmlString(_chapterSplit[value]);
      });
      if (value <= 0) {
        value = 1;
      }
      _speak();
      _sharedPreferences.setInt(
          "selected-chapter-${widget.storyId}-true-item-index",
          _currentChapterIndex);
      _sharedPreferences.setInt(
          "selected-chapter-chunk-${widget.storyId}-true-page-index", value);
    }
  }

  void _updateChapterId(value, int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
      _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
      _currentChapterIndex = value;
      _isDisplayPauseIcon = true;
    });
  }

  void setTimerAndCallFunction(int minutes, Function callbackFunction) {
    int milliseconds = minutes * 60 * 1000;
    Timer(Duration(milliseconds: milliseconds), () {
      callbackFunction();
    });
  }

  void showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(L(context, LanguageCodes.timerSettingTextInfo.toString())),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: _textTimerController,
            decoration: InputDecoration(
                labelText: L(context,
                    LanguageCodes.timerInfoSettingTextInfo.toString())),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String enteredText = _textTimerController.text;
                setTimerAndCallFunction(int.parse(enteredText), _pause);
                Navigator.of(context).pop();
              },
              child: Text(L(context, LanguageCodes.isSureTextInfo.toString())),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  Text(L(context, LanguageCodes.isNotSureTextInfo.toString())),
            ),
          ],
        );
      },
    );
  }
// #endregion

// #region variable
  TtsState _ttsState = TtsState.stopped;
  get isPlaying => _ttsState == TtsState.playing;
  get isStopped => _ttsState == TtsState.stopped;
  get isPaused => _ttsState == TtsState.paused;
  get isContinued => _ttsState == TtsState.continued;

  late TextEditingController _textTimerController;
  late List<int> _chapterId;
  late String _fromToChapterList;
  late SharedPreferences _sharedPreferences;
  late List<dynamic>? _voices;
  late double _volume;
  late double _pitch;
  late double _rate;
  late int _pageIndex;
  late String? _newVoiceText;
  late FlutterTts _flutterTts;
  late int _currentChapterIndex;
  late GroupChapterBloc _groupChaptersBloc;
  late List<String> _chapterSplit;
  late int _currentChapterChunkIndex;
  late bool _isDisplayPauseIcon;
  late int _totalChapter;
  late ScrollController _chapterController;
  late bool _isOptionVolume;

  // #endregion

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: chapterAudioKey,
        appBar: AppBar(
          leading: IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              color: themeMode(context, ColorCode.textColor.name),
              highlightColor: const Color.fromARGB(255, 255, 175, 0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: backButtonCommon(context)),
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          title: Text(
            widget.title,
            style:
                CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
          ),
          bottom: TabBar(
              indicatorColor: themeMode(context, ColorCode.disableColor.name),
              tabs: const [
                Tab(
                  icon: Icon(Icons.queue_music_rounded),
                ),
                Tab(
                  icon: Icon(Icons.list),
                ),
              ]),
        ),
        body: BlocProvider(
          create: (context) => _groupChaptersBloc,
          child: BlocListener<GroupChapterBloc, GroupChapterBlocState>(
            listener: (context, state) {},
            child: BlocBuilder<GroupChapterBloc, GroupChapterBlocState>(
              builder: (context, state) {
                if (state is GroupChapterLoadedState) {
                  var chapterIno =
                      state.chapter.result.items[_currentChapterIndex];
                  _chapterSplit = convertDynamicToList(chapterIno.bodyChunk,
                      "${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${chapterIno.numberOfChapter}: ${chapterIno.chapterTitle} \n");
                  _chapterId =
                      state.chapter.result.items.map((e) => e.id).toList();
                  _totalChapter = state.chapter.result.items.length;
                }
                return TabBarView(children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 150)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 300)
                                    .height,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: netWorkImage(
                                      context, widget.imageUrl, true),
                                ),
                              ),
                              Stack(children: [
                                Text(
                                  widget.title,
                                  style: CustomFonts.h4(context)
                                      .copyWith(fontSize: 20),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                showToolTip(widget.title)
                              ]),
                              if (state is GroupChapterLoadedState)
                                ChapterTitleWidget(
                                    callback: _updateNewDataWhenSkip,
                                    chapterSplit: _chapterSplit)
                            ],
                          ),
                        ),
                        if (state is GroupChapterLoadedState)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Slider(
                                        allowedInteraction:
                                            SliderInteraction.slideOnly,
                                        inactiveColor: themeMode(context,
                                            ColorCode.disableColor.name),
                                        activeColor: themeMode(
                                            context, ColorCode.mainColor.name),
                                        min: 0,
                                        max: _chapterSplit.length - 1 * 1.0,
                                        value: _currentChapterChunkIndex <= 0
                                            ? 0
                                            : _currentChapterChunkIndex >=
                                                    _chapterSplit.length - 1
                                                ? _chapterSplit.length - 1 * 1.0
                                                : _currentChapterChunkIndex *
                                                    1.0,
                                        onChanged: (value) {
                                          setState(() {
                                            _currentChapterChunkIndex =
                                                value >= 0
                                                    ? value.ceil()
                                                    : value <= 0
                                                        ? 0
                                                        : value.ceil();
                                            _fastForward(
                                                _currentChapterChunkIndex);
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                        flex: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (_rate == 3) {
                                              setState(() {
                                                _isOptionVolume = false;
                                              });
                                            }
                                            if (_rate == 0) {
                                              setState(() {
                                                _isOptionVolume = true;
                                              });
                                            }
                                            if (_rate < 3 && _isOptionVolume) {
                                              _pause();
                                              setState(() {
                                                _rate += 0.5;
                                              });
                                              await _flutterTts
                                                  .setSpeechRate(_rate);
                                              _speak();
                                            } else if (_rate >= 0 &&
                                                !_isOptionVolume) {
                                              _pause();
                                              setState(() {
                                                _rate -= 0.5;
                                              });
                                              await _flutterTts
                                                  .setSpeechRate(_rate);
                                              _speak();
                                            }
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text('$_rate x')),
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${((_currentChapterChunkIndex / (_chapterSplit.isNotEmpty ? _chapterSplit.length - 1 : _chapterSplit.length)) * 100).ceil()}%"),
                                    const Text("100%"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildButtonColumn(
                                        themeMode(
                                            context,
                                            _chapterId[_currentChapterIndex] ==
                                                    widget.firstChapterId
                                                ? ColorCode.disableColor.name
                                                : ColorCode.textColor.name),
                                        themeMode(
                                            context,
                                            _chapterId[_currentChapterIndex] ==
                                                    widget.firstChapterId
                                                ? ColorCode.disableColor.name
                                                : ColorCode.textColor.name),
                                        Icons.skip_previous_sharp,
                                        _chapterId[_currentChapterIndex] ==
                                                widget.firstChapterId
                                            ? () {}
                                            : () => _skip(false)),
                                    _buildButtonColumn(
                                        themeMode(
                                            context, ColorCode.textColor.name),
                                        themeMode(
                                            context, ColorCode.textColor.name),
                                        Icons.keyboard_double_arrow_left_sharp,
                                        () => {
                                              _currentChapterChunkIndex--,
                                              _currentChapterChunkIndex =
                                                  _currentChapterChunkIndex <= 0
                                                      ? 0
                                                      : _currentChapterChunkIndex,
                                              _fastForward(
                                                  _currentChapterChunkIndex)
                                            }),
                                    _buildButtonColumn(
                                        themeMode(
                                            context, ColorCode.mainColor.name),
                                        themeMode(
                                            context, ColorCode.mainColor.name),
                                        !_isDisplayPauseIcon
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        !_isDisplayPauseIcon ? _speak : _pause),
                                    _buildButtonColumn(
                                        themeMode(
                                            context, ColorCode.textColor.name),
                                        themeMode(
                                            context, ColorCode.textColor.name),
                                        Icons.keyboard_double_arrow_right_sharp,
                                        () => {
                                              _currentChapterChunkIndex++,
                                              _currentChapterChunkIndex =
                                                  _currentChapterChunkIndex >=
                                                          _chapterSplit.length -
                                                              1
                                                      ? _chapterSplit.length - 1
                                                      : _currentChapterChunkIndex,
                                              _fastForward(
                                                  _currentChapterChunkIndex)
                                            }),
                                    _buildButtonColumn(
                                        themeMode(
                                            context,
                                            _chapterId[_currentChapterIndex] ==
                                                    widget.lastChapterId
                                                ? ColorCode.disableColor.name
                                                : ColorCode.textColor.name),
                                        themeMode(
                                            context,
                                            _chapterId[_currentChapterIndex] ==
                                                    widget.lastChapterId
                                                ? ColorCode.disableColor.name
                                                : ColorCode.textColor.name),
                                        Icons.skip_next_sharp,
                                        _chapterId[_currentChapterIndex] ==
                                                widget.lastChapterId
                                            ? () {}
                                            : () => _skip(true)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (state is GroupChapterLoadingState)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: ListView.builder(
                              controller: _chapterController,
                              itemCount: _chapterSplit.length,
                              itemBuilder: (itemBuilder, index) {
                                return ListTile(
                                  tileColor: index == _currentChapterChunkIndex
                                      ? themeMode(
                                          context, ColorCode.mainColor.name)
                                      : null,
                                  title: index == 0
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                ' \n${parseHtmlString(_chapterSplit[index])}')
                                          ],
                                        )
                                      : Text(
                                          parseHtmlString(_chapterSplit[index]),
                                          style: CustomFonts.h6(context)
                                              .copyWith(fontSize: 16),
                                        ),
                                );
                              })),
                    ],
                  )
                ]);
              },
            ),
          ),
        ),
        drawer: ChapterListAudio(
            chapterCallback: _chapterSelected,
            storyId: widget.storyId,
            storyTitle: widget.title,
            firstChapterId: widget.firstChapterId,
            lastChapterId: widget.lastChapterId,
            totalChapter: widget.totalChapter,
            storyImageUrl: widget.imageUrl),
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut,
          child: BottomAppBar(
            color: themeMode(context, ColorCode.disableColor.name),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    splashRadius: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 25)
                        .width,
                    onPressed: () => chapterAudioKey.currentState!.openDrawer(),
                    icon: Icon(
                      Icons.list_rounded,
                      size: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 30)
                          .width,
                      color: themeMode(context, ColorCode.textColor.name),
                    ),
                  ),
                  IconButton(
                    splashRadius: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 25)
                        .width,
                    onPressed: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  child: Text(
                                    L(
                                        context,
                                        LanguageCodes.languageTextInfo
                                            .toString()),
                                    style: CustomFonts.h5(context),
                                  ),
                                ),
                                SizedBox(
                                  width: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectWidth: 200)
                                      .width,
                                  child: DropdownSearch<String>(
                                    items: _voices!.toList().map((e) {
                                      return e['name'].toString();
                                    }).toList(),
                                    selectedItem: "vi-vn-x-gft-local",
                                    onChanged: (String? newValue) async {
                                      _pause();
                                      await _flutterTts.setVoice({
                                        "name": "$newValue",
                                        "locale": "vi-VN"
                                      });
                                      _speak();
                                    },
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                              color: themeMode(context,
                                                  ColorCode.mainColor.name),
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  child: Text(
                                    L(
                                        context,
                                        LanguageCodes.audioSettingTextInfo
                                            .toString()),
                                    style: CustomFonts.h5(context),
                                  ),
                                ),
                                SizedBox(
                                    width: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectWidth: 225)
                                        .width,
                                    child: RateSlider(
                                      min: 0,
                                      max: 3,
                                      initValue: _volume,
                                      onChange: _setVolume,
                                    )),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    icon: Icon(
                      Icons.settings,
                      size: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 30)
                          .width,
                      color: themeMode(context, ColorCode.textColor.name),
                    ),
                  ),
                  IconButton(
                    splashRadius: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 25)
                        .width,
                    onPressed: () => showInputDialog(context),
                    icon: Icon(
                      Icons.lock_clock,
                      size: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 30)
                          .width,
                      color: themeMode(context, ColorCode.textColor.name),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChapterTitleWidget extends StatefulWidget {
  final Function(String) callback;
  const ChapterTitleWidget({
    super.key,
    required List<String> chapterSplit,
    required this.callback,
  }) : _chapterSplit = chapterSplit;

  final List<String> _chapterSplit;

  @override
  State<ChapterTitleWidget> createState() => _ChapterTitleWidgetState();
}

class _ChapterTitleWidgetState extends State<ChapterTitleWidget> {
  @override
  void didUpdateWidget(covariant ChapterTitleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._chapterSplit.first != oldWidget._chapterSplit.first) {
      widget.callback(widget._chapterSplit.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(children: [
        Text(
          widget._chapterSplit.isEmpty ? '' : widget._chapterSplit.first,
          style: CustomFonts.h6(context).copyWith(fontSize: 14),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        showToolTip(widget._chapterSplit.first)
      ]),
    );
  }
}

class RateSlider extends StatefulWidget {
  final double initValue;
  final int min;
  final int max;
  final Function(double) onChange;
  const RateSlider(
      {super.key,
      required this.min,
      required this.max,
      required this.onChange,
      required this.initValue});

  @override
  State<RateSlider> createState() => _RateSliderState();
}

class _RateSliderState extends State<RateSlider> {
  @override
  void initState() {
    _localValue = widget.initValue * 1.0;
    super.initState();
  }

  late double _localValue;
  @override
  Widget build(BuildContext context) {
    return Slider(
        allowedInteraction: SliderInteraction.slideOnly,
        inactiveColor: themeMode(context, ColorCode.disableColor.name),
        activeColor: themeMode(context, ColorCode.mainColor.name),
        min: widget.min * 1.0,
        max: widget.max * 1.0,
        value: _localValue,
        onChanged: (value) async {
          setState(() {
            _localValue = value;
          });
          widget.onChange(_localValue);
        });
  }
}
