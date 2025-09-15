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

  String _gestureStatus = '无手势操作';
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

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
    // showFloatButton();
  }

  ///移除
  void dismissEntry() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void showFloatButton() {
    var gestureDetector = GestureDetector(
        onTap: () {
          logger.d("onTap");
        },
        onTapDown: (details) {
          logger.d("onTapDown");
        },
        onTapUp: (details) {
          logger.d("onTapUp");
        },
        onDoubleTap: () {
          logger.d("onDoubleTap");
        },
        onPanUpdate: (detail) {
          logger.d("onPanUpdate");
        },
        onPanEnd: (details) {
          logger.d("onPanEnd");
        },
        onPanCancel: () {
          logger.d("onPanCancel");
        },
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimatedPositioned(
              top: 120.w,
              right: 60.w,
              duration: Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Container(
                padding: EdgeInsets.all(2.w),
                child: FloatingActionButton(
                  onPressed: () {},
                  tooltip: "房子",
                  child: const Icon(Icons.account_balance),
                ),
                alignment: Alignment.center,
              ),
            )
          ],
        ));

    Overlay.of(Get.overlayContext!).insert(OverlayEntry(builder: (context) {
      return gestureDetector;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("手势识别")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Center(
          //   child: Text("点击"),
          // ),
          GestureDetector(
            onTap: () {
              setState(() {
                _gestureStatus = '轻击 (Tap)！';
              });
              print('Tap detected!');
            },
            onDoubleTap: () {
              setState(() {
                _gestureStatus = '双击 (Double Tap)！';
              });
              print('Double Tap detected!');
            },
            onLongPress: () {
              setState(() {
                _gestureStatus = '长按 (Long Press)！';
              });
              print('Long Press detected!');
            },
            // onPanUpdate: (details) {
            //   setState(() {
            //     _gestureStatus = '拖动中 (Pan Update): ${details.delta}';
            //   });
            //   print('Pan Update: ${details.delta}');
            // },
            onScaleStart: (details) {
              _baseScaleFactor = _scaleFactor;
              setState(() {
                _gestureStatus = '缩放开始 (Scale Start)';
              });
              print('Scale Start');
            },
            onScaleUpdate: (details) {
              setState(() {
                _scaleFactor = _baseScaleFactor * details.scale;
                _gestureStatus =
                    '缩放中 (Scale Update): ${_scaleFactor.toStringAsFixed(2)}';
              });
              print('Scale Update: ${details.scale}');
            },
            onScaleEnd: (details) {
              setState(() {
                _gestureStatus = '缩放结束 (Scale End)';
              });
              print('Scale End');
            },
            child: Container(
              width: 200.0 * _scaleFactor,
              height: 200.0 * _scaleFactor,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                '点击、长按、拖动、缩放我！',
                style:
                    TextStyle(color: Colors.white, fontSize: 16 / _scaleFactor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '当前手势状态: $_gestureStatus',
            style: TextStyle(fontSize: 18),
          ),

          // Sized
        ],
      ),
    );
  }
}
