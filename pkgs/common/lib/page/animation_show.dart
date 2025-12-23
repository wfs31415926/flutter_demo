import 'package:common/comm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AnimationShowPage extends StatefulWidget {
  @override
  State<AnimationShowPage> createState() => _AnimationShowPageState();
}

class _AnimationShowPageState extends State<AnimationShowPage>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late Animation<Color> _rainbowAnimation;
  late Animation<double> _angleAnimation;
  late Animation<double> _transformAnimation;
  late SpringSimulation _springSimulation; //弹簧
  late Animation<double> _springAnimation; //弹簧动画

  @override
  void initState() {
    super.initState();
    _controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller1.addListener(() {});
    _controller1.addStatusListener((status) {});
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _rainbowAnimation = RainbowTween().animate(_controller2);
    _angleAnimation = AngleTween(begin: 0, end: 360).animate(_controller2);
    _controller3 =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat(reverse: true);
    _transformAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller3);

    //1.创建动画控制器(弹簧动画,时长会被忽略,由模拟决定)
    _controller4 =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    // ..repeat(reverse: true);
    // //2.创建弹簧模拟
    _springSimulation = SpringSimulation(
        SpringDescription(
          mass: 1, // 质量
          stiffness: 1, //刚度,刚度小动画变慢
          damping: 1, //阻尼,阻尼小可能多次震荡
        ),
        0.0, //起始位置
        300.0, //目标位置
        10.0 //初始速度
        );
    //3.控制器驱动弹簧模拟
    // _controller4.animateWith(_springSimulation);
    //4.创建动画
    _springAnimation =
        Tween<double>(begin: 0.0, end: 300.0).animate(_controller4);
    // 添加监听器
    _springAnimation.addListener(() {
      print("弹簧动画${_springAnimation.value}");
    });
    // 确保在下一帧启动动画
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startSpringAnimation();
    });
  }

  //开启弹簧动画
  void startSpringAnimation() {
    _controller4.reset();
    _controller4.animateWith(_springSimulation);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画演示'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("基本操作"),
            AnimatedBuilder(
                animation: _controller1,
                builder: (context, child) {
                  return Container(
                    width: 100 + _controller1.value * 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        "${(_controller1.value * 100).toStringAsFixed(1)}%",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _controller1.forward(), // 正向播放
                  child: const Text('开始'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _controller1.reverse(), // 反向播放
                  child: const Text('反向'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _controller1.stop(), // 停止
                  child: const Text('停止'),
                ),
                const SizedBox(width: 10),
                // 添加重置按钮
                ElevatedButton(
                  onPressed: () => _controller1.reset(),
                  child: const Text('重置'),
                ),
              ],
            ),
            Text("Tween操作"),
            AnimatedBuilder(
              animation: _controller2,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _angleAnimation.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: _rainbowAnimation.value,
                    child: const Center(
                      child: Text(
                        '🌈',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () => _controller2.forward(),
              child: const Text('开启'),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("TransForm变换"),
                // 1. 平移变换
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_transformAnimation.value * 100, 0),
                      child: _buildBox('平移', Colors.blue),
                    );
                  },
                ),
                // 2. 旋转变换
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _transformAnimation.value * 3.14159, // 0-π 弧度
                      child: _buildBox('旋转', Colors.green),
                    );
                  },
                ),
                // 3. 缩放变换

                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.5 + _transformAnimation.value * 0.5, // 0.5-1.0
                      child: _buildBox('缩放', Colors.red),
                    );
                  },
                ),
                // 4. 3D 变换（沿 Y 轴旋转）
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // 透视
                        ..rotateY(_transformAnimation.value * 3.14159),
                      alignment: Alignment.center,
                      child: _buildBox('3D旋转', Colors.purple),
                    );
                  },
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.skewX(_transformAnimation.value * 0.5),
                      // X轴倾斜
                      child: _buildBox('倾斜', Colors.blue),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..translate(_transformAnimation.value * 100.0) // X轴平移
                        ..rotateZ(_transformAnimation.value * 3.14159), // Z轴旋转
                      child: _buildBox('平移+旋转', Colors.green),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001) // 透视
                        ..rotateX(
                            _transformAnimation.value * 3.14159 / 4) // X轴旋转45度
                        ..rotateY(_transformAnimation.value * 3.14159 / 4),
                      // Y轴旋转45度
                      child: _buildBox('3D透视', Colors.red),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: _transformAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4(
                        1.0,
                        _transformAnimation.value * 0.5,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        1.0,
                      ),
                      child: _buildBox('自定义矩阵', Colors.purple),
                    );
                  },
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.w,
                ),
                Text("弹簧"),
                AnimatedBuilder(
                  animation: _springAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_springAnimation.value, 0),
                      child:
                          _buildBox('弹簧', Colors.blue, height: 50, width: 50),
                    );
                  },
                ),
                // 控制按钮
                ElevatedButton(
                  onPressed: startSpringAnimation,
                  child: Text('重新开始弹簧动画'),
                ),
                Text("TweenAnimationBuilder"),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(String text, Color color, {double? width, double? height}) {
    return Container(
      width: width ?? 100,
      height: height ?? 100,
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// 自定义 Tween：彩虹颜色
class RainbowTween extends Tween<Color> {
  RainbowTween() : super(begin: Colors.red, end: Colors.purple);

  @override
  Color lerp(double t) {
    // 根据 t 值返回彩虹色
    final hue = t * 360;
    return HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
  }
}

// 自定义 Tween：角度到弧度
class AngleTween extends Tween<double> {
  AngleTween({double? begin, double? end}) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    // 将 0-1 映射到角度值
    return (begin! + (end! - begin!) * t) * (3.14159 / 180);
  }
}
