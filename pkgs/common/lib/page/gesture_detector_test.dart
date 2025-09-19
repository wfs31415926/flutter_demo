import 'package:common/comm.dart';
import 'package:common/utils/log.dart';
import 'package:common/widget/float_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

enum GestureType {
  translate, //平移
  scale, //缩放
}

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
  GestureType _gestureType = GestureType.translate; // 跟踪当前手势类型
  double _currentScale = 1.0; // 当前缩放值
  double _startScale = 1.0; // 记录缩放开始时的初始缩放值
  Matrix4 _transform = Matrix4.identity(); // 当前的变换矩阵
  Matrix4 _startTransform = Matrix4.identity(); // 每次手势开始时的变换矩阵
  Offset _startFocalPoint = Offset.zero; //开始时触控焦点位置

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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Text("手势识别")),
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _gestureStatus = '轻击 (Tap)！';
//             });
//             print('Tap detected!');
//           },
//           onDoubleTap: () {
//             setState(() {
//               _gestureStatus = '双击 (Double Tap)！';
//             });
//             print('Double Tap detected!');
//           },
//           onLongPress: () {
//             setState(() {
//               _gestureStatus = '长按 (Long Press)！';
//             });
//             print('Long Press detected!');
//           },
//
//           onScaleStart: (details) {
//             _startTransform = _transform; // 记录手势开始时的变换
//             _startFocalPoint = details.focalPoint; // 记录手势开始时的焦点
//             if (details.pointerCount > 1) {
//               //缩放模式
//               _gestureType = GestureType.scale;
//             } else {
//               _gestureType = GestureType.translate;
//             }
//           },
//           onScaleUpdate: (details) {
//             setState(() {
//               switch (_gestureType) {
//                 case GestureType.translate:
//                   // 单指平移：计算从开始到现在的总偏移
//                   Offset offset = details.focalPoint - _startFocalPoint;
//                   _transform = _startTransform.clone();
//                   _transform.translate(offset.dx, offset.dy);
//                   break;
//                 case GestureType.scale:
//                   // 多指缩放
//                   _transform = _startTransform.clone();
//                   // 计算缩放中心（这里使用手势开始时的焦点作为缩放中心）
//                   // 注意：缩放中心可以选择当前焦点，但为了简化，我们使用开始时的焦点
//                   // 如果你需要更精确的缩放中心，可以使用details.localFocalPoint或details.focalPoint
//                   final center = _startFocalPoint;
//                   // 应用缩放
//                   _transform.translate(center.dx, center.dy);
//                   _currentScale=details.scale.clamp(0.5, 4);
//                   _transform
//                       .scale(_currentScale); //限制在0.5倍到4倍之间
//                   _transform.translate(-center.dx, -center.dy);
//                   break;
//               }
//             });
//           },
//           onScaleEnd: (details) {
//             // 重置手势类型
//             _gestureType = GestureType.translate;
//           },
//           child: Transform(
//             transform: _transform,
//             child: Container(
//               width: 200.w,
//               height: 200.w,
//               color: Colors.blue,
//               alignment: Alignment.center,
//               child: Text(
//                 '点击、长按、拖动、缩放我！',
//                 style: TextStyle(
//                     color: Colors.white, fontSize: 16 * _currentScale),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           '当前手势状态: $_gestureStatus',
//           style: TextStyle(fontSize: 18),
//         ),
//
//         // Sized
//       ],
//     ),
//   );
// }
}
