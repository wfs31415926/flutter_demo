import 'package:common/base/app.dart';
import 'package:common/base/route.dart';
import 'package:common/comm.dart';
import 'package:common/module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'login.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      routes: <String, WidgetBuilder>{
        "login": (context) => const LoginPage(),
        // "unknown": (context) => const UnknownPage(),
      },
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

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FloatingButtonManager.showButton(context);
    });
  }

  @override
  void dispose() {
    FloatingButtonManager.hideButton();
    super.dispose();
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

// 悬浮按钮管理类
class FloatingButtonManager {
  static OverlayEntry? _entry;

  static void showButton(BuildContext context) {
    if (_entry == null) {
      _entry = OverlayEntry(
        builder: (context) => const FloatingButtonWidget(),
      );
      Overlay.of(context).insert(_entry!);
    }
  }

  static void hideButton() {
    _entry?.remove();
    _entry = null;
  }
}

// 悬浮按钮 Widget
class FloatingButtonWidget extends StatefulWidget {
  const FloatingButtonWidget({super.key});

  @override
  _FloatingButtonWidgetState createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 80,
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
