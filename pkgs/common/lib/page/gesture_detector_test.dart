import 'package:common/comm.dart';
import 'package:common/resource/style.dart';
import 'package:common/utils/log.dart';
import 'package:common/widget/float_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///手势识别演示
class GestureDetectorTestPage extends StatefulWidget {
  const GestureDetectorTestPage({key});

  @override
  State<GestureDetectorTestPage> createState() =>
      _GestureDetectorTestPageState();
}

class _GestureDetectorTestPageState extends State<GestureDetectorTestPage> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      showEntry();
    });
  }

  @override
  void dispose() {
    dismissEntry();
    super.dispose();
  }

  ///弹窗
  void showEntry() {
    dismissEntry();
    overlayEntry = OverlayEntry(builder: (context) {
      return FloatWidget(
        () {
          logger.d("单击");
        },
        () {
          logger.d("双击");
        },
      );
    });
    Overlay.of(Get.overlayContext!).insert(overlayEntry!);
  }

  ///移除
  void dismissEntry() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("手势识别")),
      body: Container(
        child: Center(
          child: Text("点击"),
        ),
      ),
    );
  }
}
