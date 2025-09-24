import 'package:common/page/carousel_fullScreen.dart';
import 'package:common/page/carousel_test.dart';
import 'package:common/page/gesture_detector_test.dart';
import 'package:common/page/gesture_detector_test2.dart';
import 'package:common/page/gesture_detector_test3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../comm.dart';

class TestPage extends StatefulWidget {
  const TestPage({key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int currentIndex = 0;
  late PageController _controller;

  List<Map<String, dynamic>> functionMapList = [
    {
      "title": "登录",
      "pages": {
        "登录界面": () {
          Get.to(LoginPage());
        }
      }
    },
    {
      "title": "组件",
      "pages": {
        "手势组件": () {
          Get.to(const GestureDetectorTestPage());
        },
        "手势组件2": () {
          Get.to(const GestureDetectorTest2Page());
        },
        "手势组件3": () {
          Get.to(const GestureDetectorTest3Page());
        },
        "图片轮播--展示": () {
          Get.to(CarouselTestPage());
        },
        "图片轮播--全屏": () {
          Get.to(CarouselFullScreenPage());
        }
      }
    },
    {
      "title": "未知",
      "pages": {
        "未知界面": () {
          Get.to(const UnknownPage());
        },
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("测试"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildTab(),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: functionMapList.map((e) {
                return _buildContent();
              }).toList(),
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final data = functionMapList[currentIndex]["pages"].entries.toList();
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            data[index].key,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          onTap: () {
            data[index].value();
          },
        ),
      ),
      separatorBuilder: (context, index) => Container(
        color: Colors.white,
        child: const Divider(
          height: 0.5,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
          color: Colors.white,
        ),
      ),
      itemCount: data.length,
    );
  }

  List<Widget> _buildTab() {
    return functionMapList.map((e) {
      int index = functionMapList.indexOf(e);
      bool selected = currentIndex == index;

      return GestureDetector(
        onTap: () {
          currentIndex = index;
          _controller.jumpToPage(currentIndex);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            functionMapList[index]["title"].toString(),
            style: TextStyle(
              color: selected ? Colors.blue : Colors.blueGrey,
              fontSize: selected ? 18 : 16,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    }).toList();
  }
}
