import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnknownPage  extends StatefulWidget {
  final String? routeName;
  final Object? arguments;

  const UnknownPage({super.key, this.routeName, this.arguments});

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('未知路由'),
      ),
      body: Center(
        child: Text('找不到名为 ${widget.routeName ?? 'null'} 的路由'),
      ),
    );
  }
}
