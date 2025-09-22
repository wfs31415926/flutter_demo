import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/comm.dart';
import 'package:common/resource/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _CarouselFullScreenPageState extends State<CarouselFullScreenPage> {
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
        body: Container(
      decoration: commonImageDecoration(
          AssetImage("packages/common/images/background_1.jpg")),
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
                            color: const Color(0XFFDC143C), width: 1.w)),
                    margin: EdgeInsets.all(8.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.w)),
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
        // CarouselSlider(
        //   options: CarouselOptions(
        //       autoPlay: true,
        //       enlargeCenterPage: true,
        //       viewportFraction: 0.85,
        //       autoPlayAnimationDuration: Duration(milliseconds: 400),
        //       autoPlayCurve: Curves.easeInOut,
        //       height: MediaQuery.of(context).size.height),
        //   items: netImgList.map((item) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //             decoration: BoxDecoration(color: Colors.transparent),
        //             child: Image.network(item,
        //                 width: double.infinity, fit: BoxFit.fitWidth));
        //       },
        //     );
        //   }).toList(),
        // )
      ]),
    ));
  }
}
