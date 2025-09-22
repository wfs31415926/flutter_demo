import 'package:common/comm.dart';
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

  // 用于记录偏移量
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('跟随手指移动示例'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onPanStart: (DragStartDetails details) {
                // 手势开始：记录当前偏移量
              },
              onPanUpdate: (DragUpdateDetails details) {
                // 手势更新：计算新的偏移量并更新UI
                setState(() {
                  _offset = _offset + details.delta;
                });
              },
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
          Transform(
            // 应用平移变换
            transform: Matrix4.identity()..translate(_offset.dx, _offset.dy),
            child: Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  '拖拽我',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
