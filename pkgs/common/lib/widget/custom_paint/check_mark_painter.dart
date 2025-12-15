import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width / 3, size.height), paint);
    canvas.drawLine(
        Offset(size.width / 3, size.height), Offset(size.width, 0), paint);
    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2), size.height / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
