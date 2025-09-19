import 'package:common/comm.dart';
import 'package:flutter/material.dart';

class GestureDetectorTest2Page extends StatefulWidget {
  const GestureDetectorTest2Page({key});

  @override
  State<GestureDetectorTest2Page> createState() => _GestureDetectorTest2PageState();
}

class _GestureDetectorTest2PageState extends State<GestureDetectorTest2Page> {
  // 记录对象的位置
  Offset _position = const Offset(0, 0);

  // 是否正在拖拽
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('跟随手指移动示例'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // 背景网格，帮助可视化移动
          CustomPaint(
            painter: GridPainter(),
            size: Size.infinite,
          ),

          // 可拖拽的对象
          Positioned.fill(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _isDragging = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  // 更新对象位置为当前手指位置
                  _position = _position + details.delta;
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _isDragging = false;
                });
              },
              onPanCancel: () {
                setState(() {
                  _isDragging = false;
                });
              },
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(_position.dx, _position.dy),
                child: Center(
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: _isDragging ? Colors.lightGreen : Colors.blue,
                      borderRadius: BorderRadius.circular(30.w),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6.w,
                          offset: const Offset(2, 4),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 使用Transform定位的可移动对象

          // 位置指示器
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '位置: (${_position.dx.toStringAsFixed(1)}, ${_position.dy.toStringAsFixed(1)})',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 网格绘制器
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    // 绘制网格线
    for (double i = 0; i < size.width; i += 20) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 20) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // 绘制中心十字线
    final centerPaint = Paint()
      ..color = Colors.blue[200]!
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      centerPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      centerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
