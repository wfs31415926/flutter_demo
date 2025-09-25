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
  AssetSource assetSource = AssetSource("blinking_starts.mp3");
  // DeviceFileSource fileSource =
  //     DeviceFileSource("packages/common/assets/blinking_starts.mp3");
  UrlSource urlSource =
      UrlSource("https://music.163.com/song?id=2103798428&userid=6400601126");

  @override
  void initState() {
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
          // child: ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(100.w)),
          //   child: Container(
          //     width: 200.w,
          //     height: 200.w,
          //     child: Stack(
          //       children: [
          //         Container(
          //           decoration: BoxDecoration(
          //             image: DecorationImage(
          //               image: AssetImage(bgAudioPlay),
          //               fit: BoxFit.fitHeight,
          //               colorFilter: ColorFilter.mode(
          //                 Colors.black54,
          //                 BlendMode.overlay,
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //             child: BackdropFilter(
          //           filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          //           child: Opacity(
          //             opacity: 0.5,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: Colors.grey.shade900,
          //               ),
          //             ),
          //           ),
          //         )),
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}
