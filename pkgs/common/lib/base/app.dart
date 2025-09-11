import 'package:common/constant/app_constant.dart';
import 'package:common/utils/shared_preferences_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

///应用全局类、
///进行初始化，配置等工作
class App {
  static bool isAsyncInit = false;

  ///是否是主引擎
  static bool mainEngine = true;

  ///原生环境的env
  static String rawEnv = "product";

  ///项目初始化
  static Future init({bool mainEngine = true}) async {
    App.mainEngine = mainEngine;
    //保证初始化完成
    WidgetsFlutterBinding.ensureInitialized();
    await initBase();
    //配置日志
    Logger.level = DebugConstant.enableLog ? Level.verbose : Level.nothing;
    //强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static String getH5BaseUrl() {
    return "";
  }

  ///基层的初始化
  static Future<void> initBase() async {
    //创建SP缓存
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreferencesUtil().init();
  }
}
