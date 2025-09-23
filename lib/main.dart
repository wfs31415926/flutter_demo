import 'package:common/base/app.dart';
import 'package:common/comm.dart';
import 'package:common/module.dart';
import 'package:common/resource/size.dart';
import 'package:common/utils/log.dart';
import 'package:common/widget/float_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/router_report.dart';

void main() {
  startApp();
}

Future<void> startApp() async {
  if (!kIsWeb && (GetPlatform.isAndroid || GetPlatform.isIOS)) {
    await initApp(mainEngine: true);
  }
}

///初始化
Future<void> initApp({bool mainEngine = true}) async {
  // 如果需要 ensureInitialized，请在这里运行。
  await App.init(mainEngine: mainEngine);
  addAppPage();
  initModule();
  runApp(const MyApp());
}

///添加app的路由
void addAppPage() {
  AppRoute.addPages([
    // GetPage(name: AppRoute.init, page: () => SplashPage()),
  ]);
}

///初始化各个模块
void initModule() {
  CommonModule.init();
  //注册公共可访问路由
  // if (!GetPlatform.isWeb) {
  //   applicationOpenUrl.registerOpenUrl();
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(AppSize.appWidth, AppSize.appHeight));
    return GetMaterialApp(
      title: 'Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(title: '主页面'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
      ],
      localizationsDelegates: const [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: AppRoute.pages,
      routes: <String, WidgetBuilder>{
        "/login": (context) => const LoginPage(),
      },
      routingCallback: (routing) {
        //路由回调，打印数据
        logger.d(
            "[routeName:${routing?.current}] [args:${routing?.args}] [removed:${routing?.removed}] [isBack:${routing?.isBack}] [isDialog:${routing?.isDialog}] [isBottomSheet:${routing?.isBottomSheet}]");
      },
      navigatorObservers: [
        GetXRouterObserver(),
        MyApp.routeObserver,
        CommonModule.routeObserver,
      ],
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return UnknownPage(
                routeName: settings.name, arguments: settings.arguments);
          },
        );
      },
    );
  }
}

///GetxController无法被释放的场景：不使用GetX路由
///使用这个监听可以处理大部分
class GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterReportManager.reportCurrentRoute(route);
    // if (previousRoute?.settings.name != null) {
    //   EventCollectUtil().pageEnd(previousRoute?.settings.name ?? "");
    // }
    // if (route.settings.name != null) {
    //   EventCollectUtil().pageStart(route.settings.name ?? "");
    // }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    RouterReportManager.reportRouteDispose(route);
    // if (route.settings.name != null) {
    //   EventCollectUtil().pageEnd(route.settings.name ?? "");
    // }
    // if (previousRoute?.settings.name != null) {
    //   EventCollectUtil().pageStart(previousRoute?.settings.name ?? "");
    // }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // FloatingButtonManager.showButton();
      showEntry();
    });
  }

  @override
  void dispose() {
    // FloatingButtonManager.hideButton();
    dismissEntry();
    super.dispose();
  }

  ///弹窗
  void showEntry() {
    dismissEntry();
    overlayEntry = OverlayEntry(builder: (context) {
      return FloatWidget(
        () {
          Get.toNamed(CommonRoute.testDemo);
        },
        () {
          //隐藏悬浮按钮
          dismissEntry();
        },
      );
    });
    Overlay.of(Get.overlayContext!).insert(overlayEntry!);
  }

  ///移除
  void dismissEntry() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("主页"),
      ),
    );
  }
}
