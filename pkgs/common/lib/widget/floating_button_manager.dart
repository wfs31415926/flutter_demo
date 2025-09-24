import 'package:common/comm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 悬浮按钮管理类
class FloatingButtonManager {
  factory FloatingButtonManager() {
    return _instance;
  }

  static final FloatingButtonManager _instance = FloatingButtonManager._();

  FloatingButtonManager._();

  static OverlayEntry? _entry;

  static void showButton(
      {double? marginRight,
      double? marginBottom,
      Widget? actionWidget,
      Function? onTap,
      bool? actionMini}) {
    hideButton();
    _entry = OverlayEntry(
      builder: (context) => FloatingButtonWidget(
          marginRight, marginBottom, actionWidget, onTap, actionMini),
    );
    Overlay.of(Get.overlayContext!).insert(_entry!);
  }

  static void hideButton() {
    _entry?.remove();
    _entry = null;
  }
}

// 悬浮按钮 Widget
class FloatingButtonWidget extends StatefulWidget {
  double? marginRight;
  double? marginBottom;
  Widget? actionWidget;
  Function? onTap;
  bool? actionMini;

  FloatingButtonWidget(this.marginRight, this.marginBottom, this.actionWidget,
      this.onTap, this.actionMini,
      {Key? key})
      : super(key: key);

  @override
  _FloatingButtonWidgetState createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: widget.marginRight ?? 20,
      bottom:
          MediaQuery.of(context).padding.bottom + (widget.marginBottom ?? 20),
      child: FloatingActionButton(
        mini: widget.actionMini ?? false,
        onPressed: () {
          if (widget.onTap != null) {
            widget.onTap!.call();
          } else {
            Get.toNamed(CommonRoute.testDemo);
          }
        },
        tooltip: "全局按钮",
        child: widget.actionWidget ?? const Icon(Icons.settings),
      ),
    );
  }
}
