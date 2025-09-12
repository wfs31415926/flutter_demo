import 'package:common/comm.dart';
import 'package:common/debug/debug_controller.dart';
import 'package:common/resource/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///悬浮组件
class FloatWidget extends StatefulWidget {
  VoidCallback onTap;
  VoidCallback onDoubleTap;

  FloatWidget(this.onTap, this.onDoubleTap, {Key? key}) : super(key: key);

  @override
  State<FloatWidget> createState() => _FloatWidgetState();
}

class _FloatWidgetState extends State<FloatWidget> {
  double maxHeight =
      ScreenUtil().screenHeight - ScreenUtil().bottomBarHeight - 50.w;
  double miniHeight = ScreenUtil().statusBarHeight + AppSize.titleBarHeight;
  double defaultDx = 0.w;
  double dx = 0;
  double dy = 0;
  Duration duration = const Duration(milliseconds: 100);
  List<Color> warning = [Colors.transparent, Colors.red];
  var logic = Get.put(DebugController());

  @override
  void initState() {
    super.initState();

    dx = defaultDx;
    dy = ScreenUtil().screenHeight / 2;
  }

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onDoubleTap: widget.onDoubleTap,
      onPanUpdate: (detail) {
        double offsetY = dy + detail.delta.dy;
        dx = dx - detail.delta.dx;

        if (offsetY > maxHeight) {
          dy = maxHeight;
        } else if (offsetY < miniHeight) {
          dy = miniHeight;
        } else {
          dy = offsetY;
        }
        setState(() {
          duration = const Duration(milliseconds: 100);
        });
      },
      onPanEnd: (details) {
        setState(() {
          dx = defaultDx;
          duration = const Duration(milliseconds: 500);
        });
      },
      onPanCancel: () {
        setState(() {
          dx = defaultDx;
          duration = const Duration(milliseconds: 500);
        });
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          AnimatedPositioned(
            top: dy,
            right: dx,
            duration: duration,
            curve: Curves.decelerate,
            child: GetBuilder<DebugController>(builder: (logic) {
              return ClipOval(
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  child: FlutterLogo(
                    size: 32.w,
                  ),
                  alignment: Alignment.center,
                  color: warning[logic.count % 2],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
