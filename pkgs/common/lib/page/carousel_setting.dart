import 'package:common/comm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselSettingPage extends StatefulWidget {
  @override
  State<CarouselSettingPage> createState() => _CarouselSettingPageState();
}

class _CarouselSettingPageState extends State<CarouselSettingPage> {
  var backgroundImgList = [
    "packages/common/images/background_0.jpg",
    "packages/common/images/background_1.jpg",
  ];
  var selectedBgIndex = 0.obs;
  late Function(int)? callback;

  @override
  void initState() {
    selectedBgIndex.value = Get.arguments?["bgIndex"] ?? 0;
    callback = Get.arguments?["callback"];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) {
        // 当返回操作被触发时，这个回调会被调用。
        // 如果didPop为false，说明我们拦截了返回操作，我们可以在这里处理拦截后的逻辑。
        callback?.call(selectedBgIndex.value);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('设置'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          margin: EdgeInsets.all(16.w),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "轮播设置",
                    style: TextStyle(fontSize: 20.zsp),
                  ),
                ),
                ...backgroundImgList
                    .asMap()
                    .keys
                    .map((index) => Container(
                          margin: EdgeInsets.only(top: 6.w),
                          child: GestureDetector(
                            onTap: () {
                              if (index != selectedBgIndex.value) {
                                selectedBgIndex.value = index;
                              }
                            },
                            child: Row(
                              children: [
                                Image.asset(backgroundImgList[index],
                                    width: 64.w,
                                    height: 36.w,
                                    fit: BoxFit.cover),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Image.asset(
                                    index == selectedBgIndex.value
                                        ? "packages/common/icon/ic_selected.png"
                                        : "packages/common/icon/ic_unselect.png",
                                    width: 12.w,
                                    height: 12.w)
                              ],
                            ),
                          ),
                        ))
                    .toList()
              ],
            );
          }),
        ),
      ),
    );
  }
}
