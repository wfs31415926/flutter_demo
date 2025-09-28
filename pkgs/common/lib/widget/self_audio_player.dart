import 'package:audioplayers/audioplayers.dart';

enum PlayState { playing, paused, stopped, completed, disposed }

///音频播放组件(封装第三方播放组件,便于替换)
class SelfAudioPlayer {
  AudioPlayer? audioPlayer;
  PlayState? playState;

  static SelfAudioPlayer instance = SelfAudioPlayer();

  SelfAudioPlayer({bool deletePreFix = true}) {
    if (deletePreFix == true) {
      AudioCache.instance = AudioCache(prefix: ''); //去除AssetSource资产前缀
    }
    audioPlayer = AudioPlayer();
  }

  Future<void> setPlaySource(Source playSource, {bool? autoPlay}) async {
    await audioPlayer?.setSource(playSource);
    if (autoPlay != null && autoPlay == true) {
      await audioPlayer?.resume();
      await getPlayState();
    }
  }

  //播放/继续播放
  Future<void> resume() async {
    await audioPlayer?.resume();
    await getPlayState();
  }

  //暂停
  Future<void> pause() async {
    await audioPlayer?.pause();
    await getPlayState();
  }

  //停止
  Future<void> stop() async {
    await audioPlayer?.stop();
    await getPlayState();
  }

  PlayState? getPlayState() {
    //   stopped,playing,paused,completed,disposed,
    var state = audioPlayer?.state;
    if (state == PlayerState.stopped) {
      playState = PlayState.stopped;
    } else if (state == PlayerState.playing) {
      playState = PlayState.playing;
    } else if (state == PlayerState.paused) {
      playState = PlayState.paused;
    } else if (state == PlayerState.completed) {
      playState = PlayState.completed;
    } else {
      playState = PlayState.disposed;
    }
    return playState;
  }
}
