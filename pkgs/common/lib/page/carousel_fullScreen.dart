import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/comm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///轮播-全屏
class CarouselFullScreenPage extends StatefulWidget {
  @override
  State<CarouselFullScreenPage> createState() => _CarouselFullScreenPageState();
}

class _CarouselFullScreenPageState extends State<CarouselFullScreenPage> {
  var imagesList = [
    "packages/common/images/sunset_1.jpg",
    "packages/common/images/sunset_2.jpg",
    "packages/common/images/sunset_3.jpg",
    "packages/common/images/sunset_4.jpg",
    "packages/common/images/sunset_5.jpg"
  ];

  @override
  void initState() {
    super.initState();
    //设置全屏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //强制横屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    // 退出全屏模式
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // 强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction:0.85,
            autoPlayAnimationDuration:Duration(milliseconds:400),
            autoPlayCurve: Curves.easeInOut,
            height: MediaQuery.of(context).size.height),
        items: imagesList.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Image.asset(
                    item,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ));
            },
          );
        }).toList(),
      )
    ]));
  }
}
