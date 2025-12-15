import 'package:common/comm.dart';
import 'package:common/widget/custom_paint/check_mark_painter.dart';
import 'package:common/widget/custom_paint/label_layout_delegate.dart';
import 'package:flutter/material.dart';

class CustomWidgetShow extends StatefulWidget {
  @override
  State<CustomWidgetShow> createState() => _CustomWidgetShowState();
}

class _CustomWidgetShowState extends State<CustomWidgetShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义绘制'),
      ),
      body: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CustomPaint(size: Size(18.w, 18.w), painter: CheckMarkPainter()),
              SizedBox(
                width: 200.w,
                height: 60.w,
                child: CustomMultiChildLayout(
                  delegate: LabelLayoutDelegate(),
                  children: [
                    LayoutId(
                      id: LabelLayoutDelegate.icon,
                      child: Icon(Icons.star, size: 30.w, color: Colors.amber),
                    ),
                    LayoutId(
                      id: LabelLayoutDelegate.text,
                      child: Text('Flutter',
                          style: TextStyle(color: Colors.red, fontSize: 24.w)),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
