import 'package:flutter/material.dart';

class GestureDrivenAnimation extends StatefulWidget {
  @override
  _GestureDrivenAnimationState createState() => _GestureDrivenAnimationState();
}

class _GestureDrivenAnimationState extends State<GestureDrivenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _dragOffset = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
    _controller.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta.dy;
      // 限制拖拽范围
      _dragOffset = _dragOffset.clamp(-100.0, 100.0);

      // 根据拖拽位置计算动画值
      final normalizedValue = (_dragOffset + 100) / 200;
      _controller.value = normalizedValue;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;

    // 根据最终位置决定动画方向
    if (_dragOffset > 0) {
      _controller.animateTo(1.0);
    } else {
      _controller.animateTo(0.0);
    }

    _dragOffset = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: _onDragStart,
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: Transform.translate(
        offset:
            Offset(0, _isDragging ? _dragOffset : _animation.value * 200 - 100),
        child: Container(
          width: 50,
          height: 50,
          color: Color.lerp(Colors.red, Colors.blue, _animation.value),
        ),
      ),
    );
  }
}
