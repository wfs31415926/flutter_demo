import 'package:flutter/material.dart';

///白色圆角装饰
BoxDecoration whiteDecoration({double radius = 0}) {
  return commonDecoration(radius: radius, color: Colors.white);
}

///圆角装饰
BoxDecoration commonDecoration(
    {double radius = 0, Color? color, BoxBorder? boxBorder}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color ?? Colors.white,
      border: boxBorder);
}

///圆角装饰
BoxDecoration commonImageDecoration(AssetImage image, {double radius = 0}) {
  return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.fill,
        image: image,
      ),
      borderRadius: BorderRadius.circular(radius));
}

///默认渐变装饰
BoxDecoration primaryDecoration({double radius = 0}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.blueAccent, Colors.blueGrey]));
}

class AppStyle {
  AppStyle._privateConstructor();
}
