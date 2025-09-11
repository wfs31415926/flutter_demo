import 'package:flutter/foundation.dart';

///应用常量
class AppConstant {
  AppConstant._privateConstructor();


}

///测试常量
class DebugConstant {
  DebugConstant._privateConstructor();

  ///是否是测试环境
  static const bool isDebug = kDebugMode;

  ///是否可以打印日志
  static const bool enableLog = isDebug;

  ///染色
  static const String colorTag = "X-Limin-ColorTag";

  ///代理
  static const String proxyTag = "proxyTag";
}

///缓存常量
class SpConstant {
  SpConstant._privateConstructor();

  ///成品质检新增字段缓存
  static const String produceQualityAddCache = "produceQualityAddCache";

}
