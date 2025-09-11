import 'package:common/comm.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CommonModule {
  static Future<void> init() async {
    ///添加路由
    AppRoute.addPages([
      GetPage(name: CommonRoute.testDemo, page: () => TestPage()),
      GetPage(name: CommonRoute.unKnown, page: () => UnknownPage()),
    ]);
    // HttpAPI.setup(httpAPI);
    // FlutterInfoAPI.setup(flutterInfoAPI);
    // if (App.mainEngine) {
    //   MainEngineAPI.setup(mainEngineAPI);
    // } else {
    //   SharedObserverAPI.setup(sharedObserverAPI);
    // }
  }

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
}
