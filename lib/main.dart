import 'package:demo/unknown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: '主页面'),
      builder: (context, child) {
        return child!;
      },
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
        "login": (context) => const LoginRoute(),
        "unknown": (context) => const UnknownRoutePage(),
        // "language": (context) => LanguageRoute(),
      },
      onUnknownRoute: (RouteSettings settings) {
        print('尝试导航到一个未知的路由: ${settings.name}');
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return UnknownRoutePage(
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
  int _counter = 0;

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    //导航到新路由
    Get.to(const LoginRoute());
    // Get.toNamed("unknown");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '你点击按钮次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '增量',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          // 点击事件：例如跳转页面
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginRoute()),
          );
        },
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}
