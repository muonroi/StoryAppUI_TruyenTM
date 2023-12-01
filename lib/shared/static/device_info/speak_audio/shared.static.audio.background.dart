// import 'dart:async';
// import 'package:audio_service/audio_service.dart';
// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:muonroi/features/story/settings/settings.dart';
// import 'package:muonroi/shared/settings/setting.main.dart';
// import 'package:muonroi/shared/static/device_info/speak_audio/common.dart';
// import 'package:rxdart/rxdart.dart';

// /// The app widget
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Audio Service Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MainScreen(),
//     );
//   }
// }

// /// The main screen.
// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Service Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Queue display/controls.
//             StreamBuilder<QueueState>(
//               stream: _queueStateStream,
//               builder: (context, snapshot) {
//                 final queueState = snapshot.data;
//                 final queue = queueState?.queue ?? const [];
//                 final mediaItem = queueState?.mediaItem;
//                 return Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (queue.isNotEmpty)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.skip_previous),
//                             iconSize: 64.0,
//                             onPressed: mediaItem == queue.first
//                                 ? null
//                                 : audioHandler.skipToPrevious,
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.skip_next),
//                             iconSize: 64.0,
//                             onPressed: mediaItem == queue.last
//                                 ? null
//                                 : audioHandler.skipToNext,
//                           ),
//                         ],
//                       ),
//                     if (mediaItem?.title != null) Text(mediaItem!.title),
//                   ],
//                 );
//               },
//             ),
//             // Play/pause/stop buttons.
//             StreamBuilder<bool>(
//               stream: audioHandler.playbackState
//                   .map((state) => state.playing)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final playing = snapshot.data ?? false;
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (playing) _pauseButton() else _playButton(),
//                     _stopButton(),
//                   ],
//                 );
//               },
//             ),
//             // A seek bar.
//             StreamBuilder<MediaState>(
//               stream: _mediaStateStream,
//               builder: (context, snapshot) {
//                 final mediaState = snapshot.data;
//                 return SeekBar(
//                   duration: mediaState?.mediaItem?.duration ?? Duration.zero,
//                   position: mediaState?.position ?? Duration.zero,
//                   onChangeEnd: (newPosition) {
//                     audioHandler.seek(newPosition);
//                   },
//                 );
//               },
//             ),
//             // Display the processing state.
//             StreamBuilder<AudioProcessingState>(
//               stream: audioHandler.playbackState
//                   .map((state) => state.processingState)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final processingState =
//                     snapshot.data ?? AudioProcessingState.idle;
//                 return Text(
//                     "Processing state: ${describeEnum(processingState)}");
//               },
//             ),
//             // Display the latest custom event.
//             StreamBuilder<dynamic>(
//               stream: audioHandler.customEvent,
//               builder: (context, snapshot) {
//                 return Text("custom event: ${snapshot.data}");
//               },
//             ),
//             // Display the notification click status.
//             StreamBuilder<bool>(
//               stream: AudioService.notificationClicked,
//               builder: (context, snapshot) {
//                 return Text(
//                   'Notification Click Status: ${snapshot.data}',
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// A stream reporting the combined state of the current media item and its
//   /// current position.
//   Stream<MediaState> get _mediaStateStream =>
//       Rx.combineLatest2<MediaItem?, Duration, MediaState>(
//           audioHandler.mediaItem,
//           AudioService.position,
//           (mediaItem, position) => MediaState(mediaItem, position));

//   /// A stream reporting the combined state of the current queue and the current
//   /// media item within that queue.
//   Stream<QueueState> get _queueStateStream =>
//       Rx.combineLatest2<List<MediaItem>, MediaItem?, QueueState>(
//           audioHandler.queue,
//           audioHandler.mediaItem,
//           (queue, mediaItem) => QueueState(queue, mediaItem));

//   IconButton _playButton() => IconButton(
//         icon: const Icon(Icons.play_arrow),
//         iconSize: 64.0,
//         onPressed: audioHandler.play,
//       );

//   IconButton _pauseButton() => IconButton(
//         icon: const Icon(Icons.pause),
//         iconSize: 64.0,
//         onPressed: audioHandler.pause,
//       );

//   IconButton _stopButton() => IconButton(
//         icon: const Icon(Icons.stop),
//         iconSize: 64.0,
//         onPressed: audioHandler.stop,
//       );
// }

// class QueueState {
//   final List<MediaItem> queue;
//   final MediaItem? mediaItem;

//   QueueState(this.queue, this.mediaItem);
// }

// class MediaState {
//   final MediaItem? mediaItem;
//   final Duration position;

//   MediaState(this.mediaItem, this.position);
// }

// class TextPlayerHandler extends BaseAudioHandler with QueueHandler {
//   final _tts = Tts();
//   final _sleeper = Sleeper();
//   Completer<void>? _completer;
//   var _index = 0;
//   bool _interrupted = false;
//   var _running = false;

//   bool get _playing => playbackState.value.playing;

//   TextPlayerHandler() {
//     _init();
//   }

//   Future<void> _init() async {
//     final session = await AudioSession.instance;
//     session.interruptionEventStream.listen((event) {
//       if (event.begin) {
//         if (_playing) {
//           pause();
//           _interrupted = true;
//         }
//       } else {
//         switch (event.type) {
//           case AudioInterruptionType.pause:
//           case AudioInterruptionType.duck:
//             if (!_playing && _interrupted) {
//               play();
//             }
//             break;
//           case AudioInterruptionType.unknown:
//             break;
//         }
//         _interrupted = false;
//       }
//     });
//     session.becomingNoisyEventStream.listen((_) {
//       if (_playing) pause();
//     });
//   }

//   Future<void> run() async {
//     _completer = Completer<void>();
//     _running = true;
//     while (_running) {
//       try {
//         if (_playing) {
//           mediaItem.add(queue.value[_index]);
//           playbackState.add(playbackState.value.copyWith(
//             updatePosition: Duration.zero,
//             queueIndex: _index,
//           ));
//           AudioService.androidForceEnableMediaButtons();
//           for (var i in mediaItem.value!.extras![mediaItem.value!.id]
//               as List<String>) {
//             await Future.wait([
//               _tts.speak(parseHtmlString(i)),
//               _sleeper.sleep(const Duration(seconds: 1)),
//             ]);
//           }

//           if (_index + 1 < queue.value.length) {
//             _index++;
//           } else {
//             _running = false;
//           }
//         } else {
//           await _sleeper.sleep();
//         }
//         // ignore: empty_catches
//       } on SleeperInterruptedException {
//         // ignore: empty_catches
//       } on TtsInterruptedException {}
//     }
//     _index = 0;
//     mediaItem.add(queue.value[_index]);
//     playbackState.add(playbackState.value.copyWith(
//       updatePosition: Duration.zero,
//     ));
//     if (playbackState.value.processingState != AudioProcessingState.idle) {
//       stop();
//     }
//     _completer?.complete();
//     _completer = null;
//   }

//   @override
//   Future<void> skipToQueueItem(int index) async {
//     _index = index;
//     _signal();
//   }

//   @override
//   Future<void> play() async {
//     if (_playing) return;
//     final session = await AudioSession.instance;
//     if (await session.setActive(true)) {
//       playbackState.add(playbackState.value.copyWith(
//         controls: [MediaControl.pause, MediaControl.stop],
//         processingState: AudioProcessingState.ready,
//         playing: true,
//       ));
//       if (_completer == null) {
//         run();
//       } else {
//         _sleeper.interrupt();
//       }
//     }
//   }

//   @override
//   Future<void> pause() async {
//     _interrupted = false;
//     playbackState.add(playbackState.value.copyWith(
//       controls: [MediaControl.play, MediaControl.stop],
//       processingState: AudioProcessingState.ready,
//       playing: false,
//     ));
//     _signal();
//   }

//   @override
//   Future<void> stop() async {
//     playbackState.add(playbackState.value.copyWith(
//       controls: [],
//       processingState: AudioProcessingState.idle,
//       playing: false,
//     ));
//     _running = false;
//     _signal();
//     // Wait for the speech to stop
//     await _completer?.future;
//     // Shut down this task
//     await super.stop();
//   }

//   void _signal() {
//     _sleeper.interrupt();
//     _tts.interrupt();
//   }
// }

// /// An object that performs interruptable sleep.
// class Sleeper {
//   Completer<void>? _blockingCompleter;

//   /// Sleep for a duration. If sleep is interrupted, a
//   /// [SleeperInterruptedException] will be thrown.
//   Future<void> sleep([Duration? duration]) async {
//     _blockingCompleter = Completer();
//     if (duration != null) {
//       await Future.any<void>(
//           [Future.delayed(duration), _blockingCompleter!.future]);
//     } else {
//       await _blockingCompleter!.future;
//     }
//     final interrupted = _blockingCompleter!.isCompleted;
//     _blockingCompleter = null;
//     if (interrupted) {
//       throw SleeperInterruptedException();
//     }
//   }

//   /// Interrupt any sleep that's underway.
//   void interrupt() {
//     if (_blockingCompleter?.isCompleted == false) {
//       _blockingCompleter!.complete();
//     }
//   }
// }

// class SleeperInterruptedException {}

// /// A wrapper around FlutterTts that makes it easier to wait for speech to
// /// complete.
// class Tts {
//   final FlutterTts _flutterTts = FlutterTts();
//   Completer<void>? _speechCompleter;
//   bool _interruptRequested = false;
//   bool _playing = false;

//   Tts() {
//     _flutterTts.setCompletionHandler(() {
//       _speechCompleter?.complete();
//     });
//   }

//   bool get playing => _playing;

//   Future<void> speak(String text) async {
//     _playing = true;
//     if (!_interruptRequested) {
//       _speechCompleter = Completer();
//       await _flutterTts.speak(text);
//       await _speechCompleter!.future;
//       _speechCompleter = null;
//     }
//     _playing = false;
//     if (_interruptRequested) {
//       _interruptRequested = false;
//       throw TtsInterruptedException();
//     }
//   }

//   Future<void> stop() async {
//     if (_playing) {
//       await _flutterTts.stop();
//       _speechCompleter?.complete();
//     }
//   }

//   void interrupt() {
//     if (_playing) {
//       _interruptRequested = true;
//       stop();
//     }
//   }
// }

// class TtsInterruptedException {}
