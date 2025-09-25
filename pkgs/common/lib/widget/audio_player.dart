import 'package:audioplayers/audioplayers.dart';
import 'package:common/widget/player_widget.dart';
import 'package:flutter/cupertino.dart';

///音频播放组件(封装第三方播放组件,便于替换)
class AudioPlayerWidget extends StatefulWidget {
  Source playSource; //播放源,可能为网络资源,文件资源,本地资源,流资源
  bool autoPlay; //是否自动播放
  bool loopPlay; //是否循环播放

  AudioPlayerWidget(this.playSource, this.autoPlay, this.loopPlay, {Key? key})
      : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await audioPlayer.setSource(widget.playSource);
      await audioPlayer.resume();
    });
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerWidget(player: audioPlayer);
  }
}
