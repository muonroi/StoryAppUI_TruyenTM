// import 'package:audio_service/audio_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:muonroi/core/localization/settings.language.code.dart';
// import 'package:muonroi/features/chapters/bloc/group_chapter/group_chapter_bloc.dart';
// import 'package:muonroi/features/chapters/data/service/api.chapter.service.dart';
// import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
// import 'package:muonroi/shared/settings/setting.fonts.dart';
// import 'package:muonroi/shared/settings/setting.main.dart';
// import 'package:muonroi/shared/static/device_info/speak_audio/common.dart';
// import 'package:muonroi/shared/static/device_info/speak_audio/shared.static.audio.background.dart';
// import 'package:rxdart/rxdart.dart';

// class StoryAudioTest extends StatefulWidget {
//   final String author;
//   final String title;
//   final int storyId;
//   final int chapterId;
//   final String imageUrl;
//   final int firstChapterId;
//   final int lastChapterId;
//   final int totalChapter;
//   const StoryAudioTest(
//       {super.key,
//       required this.author,
//       required this.title,
//       required this.storyId,
//       required this.chapterId,
//       required this.imageUrl,
//       required this.firstChapterId,
//       required this.lastChapterId,
//       required this.totalChapter});

//   @override
//   State<StoryAudioTest> createState() => _StoryAudioTestState();
// }

// class _StoryAudioTestState extends State<StoryAudioTest> {
//   @override
//   void initState() {
//     _pageIndex = 1;
//     _groupChaptersBloc = GroupChapterBloc(widget.storyId, _pageIndex, 99);
//     _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
//     _firstLoad = true;
//     _currentTitle = "";
//     _currentSpeed = 2;
//     super.initState();
//   }

//   late GroupChapterBloc _groupChaptersBloc;
//   late bool _firstLoad;
//   late int _pageIndex;
//   late String _currentTitle;
//   late double _currentSpeed;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               splashRadius:
//                   MainSetting.getPercentageOfDevice(context, expectWidth: 25)
//                       .width,
//               color: themeMode(context, ColorCode.textColor.name),
//               highlightColor: const Color.fromARGB(255, 255, 175, 0),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: backButtonCommon(context)),
//           backgroundColor: themeMode(context, ColorCode.mainColor.name),
//           title: Text(
//             widget.title,
//             style:
//                 CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
//           ),
//           bottom: TabBar(
//               indicatorColor: themeMode(context, ColorCode.disableColor.name),
//               tabs: const [
//                 Tab(
//                   icon: Icon(Icons.queue_music_rounded),
//                 ),
//                 Tab(
//                   icon: Icon(Icons.list),
//                 ),
//               ]),
//         ),
//         body: BlocProvider(
//           create: (context) => _groupChaptersBloc,
//           child: BlocListener<GroupChapterBloc, GroupChapterBlocState>(
//             listener: (context, state) {},
//             child: BlocBuilder<GroupChapterBloc, GroupChapterBlocState>(
//               builder: (context, state) {
//                 if (state is GroupChapterLoadedState) {
//                   // if (_firstLoad) {
//                   //   List<MediaItem> tempItems = [];
//                   //   var index = 1;
//                   //   for (var i in state.chapter.result.items) {
//                   //     var chapterSplit = convertDynamicToList(i.bodyChunk,
//                   //         "${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${i.numberOfChapter}: ${i.chapterTitle} \n");
//                   //     var singleMediaItem = MediaItem(
//                   //         id: "${i.numberOfChapter}",
//                   //         album: widget.title,
//                   //         title:
//                   //             "${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${i.numberOfChapter}: ${i.chapterTitle} ",
//                   //         artist: widget.author,
//                   //         extras: {"${i.numberOfChapter}": chapterSplit},
//                   //         duration: Duration(minutes: index),
//                   //         artUri: Uri.parse(widget.imageUrl));
//                   //     tempItems.add(singleMediaItem);
//                   //     index++;
//                   //   }
//                   //   audioHandler.addQueueItems(tempItems);
//                   //   _firstLoad = false;
//                   // }
//                 }
//                 return TabBarView(children: [
//                   Container(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 12.0),
//                                 width: MainSetting.getPercentageOfDevice(
//                                         context,
//                                         expectWidth: 150)
//                                     .width,
//                                 height: MainSetting.getPercentageOfDevice(
//                                         context,
//                                         expectHeight: 300)
//                                     .height,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(8.0),
//                                   child: netWorkImage(
//                                       context, widget.imageUrl, true),
//                                 ),
//                               ),
//                               TitleChapter(
//                                 currentChapter: widget.title,
//                                 fontSize: 20,
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               TitleChapter(
//                                 currentChapter: _currentTitle,
//                                 fontSize: 14,
//                               ),
//                             ],
//                           ),
//                         ),
//                         if (state is GroupChapterLoadedState)
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               SizedBox(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       flex: 2,
//                                       child: StreamBuilder<MediaState>(
//                                         stream: _mediaStateStream,
//                                         builder: (context, snapshot) {
//                                           final mediaState = snapshot.data;
//                                           debugPrint(mediaState
//                                               ?.mediaItem?.duration
//                                               .toString());
//                                           debugPrint(
//                                               mediaState?.position.toString());
//                                           return SeekBar(
//                                             duration: mediaState
//                                                     ?.mediaItem?.duration ??
//                                                 Duration.zero,
//                                             position: mediaState?.position ??
//                                                 Duration.zero,
//                                             onChangeEnd: (newPosition) {
//                                               audioHandler.seek(newPosition);
//                                             },
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     Expanded(
//                                         flex: 0,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             audioHandler.seekForward(true);
//                                             //  audioHandler.skipToQueueItem(2);
//                                           },
//                                           child: Container(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: Text('${_currentSpeed}x')),
//                                         ))
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     StreamBuilder<QueueState>(
//                                       stream: _queueStateStream,
//                                       builder: (context, snapshot) {
//                                         final queueState = snapshot.data;
//                                         final queue =
//                                             queueState?.queue ?? const [];
//                                         final mediaItem = queueState?.mediaItem;
//                                         return StreamBuilder<bool>(
//                                           stream: audioHandler.playbackState
//                                               .map((state) => state.playing)
//                                               .distinct(),
//                                           builder: (context, snapshot) {
//                                             final playing =
//                                                 snapshot.data ?? false;
//                                             return Row(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 if (queue.isNotEmpty)
//                                                   IconButton(
//                                                     icon: const Icon(
//                                                         Icons.skip_previous),
//                                                     iconSize: 24.0,
//                                                     onPressed:
//                                                         mediaItem == queue.first
//                                                             ? null
//                                                             : audioHandler
//                                                                 .skipToPrevious,
//                                                   ),
//                                                 if (playing)
//                                                   _pauseButton()
//                                                 else
//                                                   _playButton(),
//                                                 _stopButton(),
//                                                 if (queue.isNotEmpty)
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       IconButton(
//                                                         icon: const Icon(
//                                                             Icons.skip_next),
//                                                         iconSize: 24.0,
//                                                         onPressed: mediaItem ==
//                                                                 queue.last
//                                                             ? null
//                                                             : audioHandler
//                                                                 .skipToNext,
//                                                       ),
//                                                     ],
//                                                   ),
//                                               ],
//                                             );
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         if (state is GroupChapterLoadingState)
//                           const Center(
//                             child: CircularProgressIndicator(),
//                           )
//                       ],
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         color: Colors.red,
//                       )
//                     ],
//                   )
//                 ]);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Stream<MediaState> get _mediaStateStream =>
//       Rx.combineLatest2<MediaItem?, Duration, MediaState>(
//           audioHandler.mediaItem,
//           AudioService.position,
//           (mediaItem, position) => MediaState(mediaItem, position));

//   Stream<QueueState> get _queueStateStream =>
//       Rx.combineLatest2<List<MediaItem>, MediaItem?, QueueState>(
//           audioHandler.queue,
//           audioHandler.mediaItem,
//           (queue, mediaItem) => QueueState(queue, mediaItem));

//   IconButton _playButton() => IconButton(
//         icon: const Icon(Icons.play_arrow),
//         iconSize: 24.0,
//         onPressed: audioHandler.play,
//       );

//   IconButton _pauseButton() => IconButton(
//         icon: const Icon(Icons.pause),
//         iconSize: 24.0,
//         onPressed: audioHandler.pause,
//       );

//   IconButton _stopButton() => IconButton(
//         icon: const Icon(Icons.stop),
//         iconSize: 24.0,
//         onPressed: audioHandler.stop,
//       );
// }

// class TitleChapter extends StatelessWidget {
//   final String currentChapter;
//   final double fontSize;
//   const TitleChapter(
//       {super.key, required this.currentChapter, required this.fontSize});

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: [
//       Text(
//         currentChapter,
//         style: CustomFonts.h5(context).copyWith(fontSize: fontSize),
//         overflow: TextOverflow.ellipsis,
//         maxLines: 2,
//       ),
//       showToolTip(currentChapter)
//     ]);
//   }
// }
