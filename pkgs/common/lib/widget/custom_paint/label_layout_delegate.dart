import 'package:common/comm.dart';
import 'package:flutter/cupertino.dart';

class LabelLayoutDelegate extends MultiChildLayoutDelegate {
  // 为子Widget定义ID常量
  static const String icon = 'icon';
  static const String text = 'text';

  @override
  void performLayout(Size size) {
    Size iconSize = layoutChild(icon, BoxConstraints.loose(size));
    Size textSize = layoutChild(text,
        BoxConstraints(maxWidth: size.width - iconSize.width));

    //水平居中
    double totalWidth = iconSize.width + textSize.width;
    double startX = (size.width - totalWidth) / 2;

    //垂直居中
    double iconY = (size.height - iconSize.height) / 2;
    double textY = (size.height - textSize.height) / 2;

    positionChild(icon, Offset(startX, iconY));
    positionChild(text, Offset(startX + iconSize.width, textY));
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 我们选择尽可能大，但也可以根据约束调整
    return Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
