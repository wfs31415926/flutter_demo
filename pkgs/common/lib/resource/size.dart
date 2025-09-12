import 'package:flutter/material.dart';

import '../comm.dart';

///app的尺寸，控件大小，组件大小，字体大小
class AppSize {
  ///app设计图的宽度
  static const double appWidth = 375;

  ///app设计图的高度
  static const double appHeight = 667;

  ///app标题栏高度
  static double titleBarHeight = 44.w;

  /// safeArea下的底部padding 
  static double bottomPadding = ScreenUtil().bottomBarHeight > 0 ? 0 : 20.w;

  /// 非safeArea下的底部padding 
  static double bottomUnSafePadding = ScreenUtil().bottomBarHeight > 0 ? ScreenUtil().bottomBarHeight : 20.w;
}

class FontSize {
  static final title = 17.zsp;
  static final text_10 = 10.zsp;
  static final text_12 = 12.zsp;
  static final text_13 = 13.zsp;
  static final text_14 = 14.zsp;
  static final text_15 = 15.zsp;
  static final text_16 = 16.zsp;
  static final text_17 = 17.zsp;
  static final text_18 = 18.zsp;
  static final text_20 = 20.zsp;
  static final text_22 = 22.zsp;
  static final text_24 = 24.zsp;
  static final text_25 = 25.zsp;
  static final text_28 = 28.zsp;
  static final text_34 = 34.zsp;
  static final headline = 20.zsp;
  static final text= 17.zsp;
  static final text2= 16.zsp;
  static final subText2= 17.zsp;
  static final subText= 15.zsp;
  static final descText= 14.zsp;
  static final minText= 12.zsp;
}
