import 'package:get/get.dart';

///路由管理
class AppRoute {
  ///默认路由，初始页面
  static const init = '/splash';

  /// 首页
  static const home = "/home";

  ///路由列表
  static var pages = <GetPage>[];

  ///添加路由
  ///[pages] 模块的路由
  static addPages(List<GetPage> pageList) {
    if (pageList.isNotEmpty) {
      pages.addAll(pageList);
    }
  }
}

class H5Route {
  ///通用网页
  static const h5 = "/comm/h5";
}

class UserRoute {
  ///User登录页
  static const login = '/login';

  // 设置服务器
  static const setServer = "/setServer";

  // 忘记密码(需要登录)
  static const forgetPwdLogin = "/forgetPwdLogin";

  // 忘记密码
  static const forgetPwd = "/forgetPwd";

  // 选择租户
  static const selectTenantPage = "/selectTenantPage";
}

class CommonRoute {
  ///404 notFind
  static const unKnown = "/404";
  static const testDemo = "/testDemo";
  static const gestureTest = "/gestureTest";
  static const gestureTest2 = "/gestureTest2";
  static const gestureTest3 = "/gestureTest3";
  static const carouselTest = "/carouselTest";
  static const carouselFullScreen = "/carouselFullScreen";
  static const carouselSetting = "/carouselSetting";
  static const audioPlay = "/audioPlay";
}
