import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnknownRoutePage  extends StatelessWidget {
  final String? routeName;
  final Object? arguments;

  const UnknownRoutePage({super.key, this.routeName, this.arguments});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('未知路由'),
      ),
      body: Center(
        child: Text('找不到名为 ${routeName ?? 'null'} 的路由'),
      ),
    );
  }
}
