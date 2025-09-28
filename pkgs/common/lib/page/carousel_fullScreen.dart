import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/comm.dart';
import 'package:common/resource/style.dart';
import 'package:common/widget/self_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final List<String> netImgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
var localImgList = [
  "packages/common/images/sunset_1.jpg",
  "packages/common/images/sunset_2.jpg",
  "packages/common/images/sunset_3.jpg",
  "packages/common/images/sunset_4.jpg",
  "packages/common/images/sunset_5.jpg"
];

///轮播-全屏
class CarouselFullScreenPage extends StatefulWidget {
  @override
  State<CarouselFullScreenPage> createState() => _CarouselFullScreenPageState();
}

class _CarouselFullScreenPageState extends State<CarouselFullScreenPage>
    with SingleTickerProviderStateMixin {
  OverlayEntry? overlayEntry;
  var bgIndex = 1.obs;
  late SelfAudioPlayer selfAudioPlayer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //设置横屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    _setFullScreen();
    selfAudioPlayer = SelfAudioPlayer.instance;
    selfAudioPlayer.setPlaySource(
        AssetSource("packages/common/assets/blinking_stars.mp3"));
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation =
        Tween<double>(begin: 0, end: 2 * 3.1415926).animate(_controller);
  }

  @override
  void dispose() {
    // 恢复竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // 退出全屏模式
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _setFullScreen() {
    // 多次设置确保生效
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Future.delayed(Duration(milliseconds: 500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    });
  }

  ///弹窗
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setFullScreen();
    });
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: commonImageDecoration(AssetImage(
                    "packages/common/images/background_${bgIndex.value}.jpg")),
                child: Column(children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        autoPlayAnimationDuration: Duration(milliseconds: 1800),
                        autoPlayCurve: Curves.easeInOut,
                        height: MediaQuery.of(context).size.height),
                    items: localImgList.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              decoration: commonDecoration(
                                  radius: 9.w,
                                  color: Colors.transparent,
                                  boxBorder: Border.all(
                                      color: const Color(0XFFDC143C),
                                      width: 1.w)),
                              margin: EdgeInsets.all(8.w),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.w)),
                                child: Image.asset(
                                  item,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                ]));
          }),
          Positioned(
              bottom: 4.w,
              left: 4.w,
              child: GestureDetector(
                onTap: () {
                  var playState = selfAudioPlayer.playState;
                  //开始播放(开始动画),暂停播放(停止动画),
                  // 播放完成,自动停止(停止动画)或者轮播(继续动画)
                  if (playState == PlayState.paused ||
                      playState == PlayState.completed) {
                    selfAudioPlayer.resume();
                    _controller.repeat();
                  } else {
                    selfAudioPlayer.pause();
                    _controller.stop();
                  }
                },
                child: RotationTransition(
                  turns: _animation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.w)),
                    child: Container(
                      height: 20.w,
                      width: 20.w,
                      child: Image.asset(
                        "packages/common/images/bg_audio_play.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        mini: true,
        onPressed: () {
          Get.toNamed(CommonRoute.carouselSetting, arguments: {
            "bgIndex": bgIndex.value,
            "callback": (selectedIndex) {
              bgIndex.value = selectedIndex;
            }
          });
        },
      ),
    );
  }
}
