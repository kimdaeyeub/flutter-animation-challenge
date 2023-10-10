import 'dart:math';

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  void _onTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    print(_animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: _onTap,
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(_animation.value * pi),
          child: Container(
            width: 350,
            height: 600,
            color: Colors.red,
            child: _animation.value >= 0.5
                ? Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.rotationY(1 * pi),
                    child: const Text("Fuck"),
                  )
                : const Text("Hello"),
          ),
        ),
      ),
    ));
  }
}
