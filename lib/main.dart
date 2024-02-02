import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Riveアニメーションのコントローラー
  late RiveAnimationController controller;

  final AnimatedBear animatedBear = AnimatedBear();

  @override
  void initState() {
    super.initState();
    // アニメーションコントローラーを初期化
    controller = animatedBear.getController();
  }

  _changeAnimation() {
    setState(() {
      animatedBear.changeAnimation();
      controller = animatedBear.getController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        child: RiveAnimation.asset(
          'assets/login_screen_character.riv',
          controllers: [controller],
        ),
        onTap: () => {
          _changeAnimation(),
        },
      )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

enum AnimationName {
  idle,
  success,
  fail,
}

class AnimatedBear {
  AnimationName type = AnimationName.idle;
  SimpleAnimation controller = SimpleAnimation('idle');

  void changeAnimation() {
    if (controller.animationName == 'idle') {
      controller = SimpleAnimation('success');
    } else if (controller.animationName == 'success') {
      controller = SimpleAnimation('fail');
    } else if (controller.animationName == 'fail') {
      controller = SimpleAnimation('idle');
    }

    // switch (type) {
    //   case AnimationName.idle:
    //     controller = SimpleAnimation('idle');
    //     break;
    //   case AnimationName.success:
    //     controller = SimpleAnimation('success');
    //     break;
    //   case AnimationName.fail:
    //     controller = SimpleAnimation('fail');
    //     break;
    //   default:
    //     controller = SimpleAnimation('idle');
    //     break;
    // }
  }

  getController() {
    return controller;
  }
}
