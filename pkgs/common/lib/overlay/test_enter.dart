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

  static void showButton() {
    hideButton();
    _entry = OverlayEntry(
      builder: (context) => const FloatingButtonWidget(),
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
  const FloatingButtonWidget({key});

  @override
  _FloatingButtonWidgetState createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: MediaQuery.of(context).padding.bottom + 20,
      child: FloatingActionButton(
        onPressed: () {
          Get.to(const TestPage());
        },
        tooltip: "全局按钮",
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}
