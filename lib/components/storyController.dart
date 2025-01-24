import 'package:rxdart/rxdart.dart';

enum PlaybackState { pause, play, next, previous, loading }

class StoryyController {
  final playbackNotifier = BehaviorSubject<PlaybackState>();

  void pause() {
    playbackNotifier.add(PlaybackState.pause);
  }

  void play() {
    playbackNotifier.add(PlaybackState.play);
  }

  void next() {
    playbackNotifier.add(PlaybackState.next);
  }

  void previous() {
    playbackNotifier.add(PlaybackState.previous);
  }

  void loading() {
    playbackNotifier.add(PlaybackState.loading);
  }

  void dispose() {
    playbackNotifier.close();
  }
}
