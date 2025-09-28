import 'package:audioplayers/audioplayers.dart';
import 'package:common/widget/player_widget.dart';
import 'package:flutter/material.dart';

///音频播放
class AudioPlayPage extends StatefulWidget {
  const AudioPlayPage({Key? key}) : super(key: key);

  @override
  State<AudioPlayPage> createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  var bgAudioPlay = "packages/common/images/bg_audio_play.jpg";
  late AudioPlayer player;
  AssetSource assetSource =
      AssetSource("packages/common/assets/blinking_stars.mp3");

  @override
  void initState() {
    AudioCache.instance = AudioCache(prefix: ''); //去除AssetSource资产前缀
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(assetSource);
      await player.resume();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('音频播放'),
        ),
        body: Center(
          child: PlayerWidget(
            player: player,
          ),
        ));
  }
}
