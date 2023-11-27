import 'package:audio_service/audio_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _tts = FlutterTts();
  bool _finished = false;
  final _player = AudioPlayer();
  @override
  AudioPlayerHandler() {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));
    playbackState.map((_) => _transformEvent);
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _player
        .setUrl(
            "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")
        .then((_) {
      playbackState.add(playbackState.value.copyWith(
        processingState: AudioProcessingState.ready,
      ));
    });
  }
  @override
  Future<void> play() async {
    for (var n = 1; !_finished && n <= 10; n++) {
      _tts.speak("$n");
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Future<void> stop() async {
    _finished = true;
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
