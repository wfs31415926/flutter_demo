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
        print('尝试导航到一个未知的路由: ${settings.name}');
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
  int currentIndex = 0;
  late PageController _controller;

  List<Map<String, dynamic>> functionMapList = [
    {
      "title": "登录相关",
      "pages": {
        "登录界面": () {
          Get.to(const LoginPage());
        },
        "登录界面2": () {
          Get.to(const LoginPage());
        },
        "登录界面3": () {
          Get.to(const LoginPage());
        }
      }
    },
    {
      "title": "未知",
      "pages": {
        "未知界面": () {
          Get.to(const UnknownPage());
        },
      }
    }
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentIndex);
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
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTab(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: functionMapList.map((e) {
                return _buildContent();
              }).toList(),
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final data = functionMapList[currentIndex]["pages"].entries.toList();
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        color: Colors.white,
        child: ListTile(
          title: Text(
            data[index].key,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          onTap: () {
            data[index].value();
          },
        ),
      ),
      separatorBuilder: (context, index) => Container(
        color: Colors.white,
        child: const Divider(
          height: 0.5,
          thickness: 0.5,
          indent: 10,
          endIndent: 10,
          color: Colors.white,
        ),
      ),
      itemCount: data.length,
    );
  }

  List<Widget> _buildTab() {
    return functionMapList.map((e) {
      int index = functionMapList.indexOf(e);
      bool selected = currentIndex == index;

      return GestureDetector(
        onTap: () {
          currentIndex = index;
          _controller.jumpToPage(currentIndex);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            functionMapList[index]["title"].toString(),
            style: TextStyle(
              color: selected ? Colors.blue : Colors.blueGrey,
              fontSize: selected ? 18 : 16,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      );
    }).toList();
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
          Get.to(const LoginPage());
        },
        tooltip: "全局按钮",
        child: const Icon(Icons.ac_unit),
      ),
    );
  }
}
