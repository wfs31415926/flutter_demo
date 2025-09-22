import 'package:carousel_slider/carousel_slider.dart';
import 'package:common/comm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///轮播-示意
class CarouselTestPage extends StatefulWidget {
  @override
  State<CarouselTestPage> createState() => _CarouselTestPageState();
}

class _CarouselTestPageState extends State<CarouselTestPage> {
  var imagesList = [
    "packages/common/images/sunset_1.jpg",
    "packages/common/images/sunset_2.jpg",
    "packages/common/images/sunset_3.jpg",
    "packages/common/images/sunset_4.jpg",
    "packages/common/images/sunset_5.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('轮播演示'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(children: [
          CarouselSlider(
            options: CarouselOptions(autoPlay: true),
            items: imagesList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 0.5.w),
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
