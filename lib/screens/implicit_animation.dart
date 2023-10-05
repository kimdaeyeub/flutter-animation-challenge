import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  final List<Color> _colors = [
    const Color(0xffFFAD11),
    const Color(0xffED4039),
    const Color(0xff1FA0AA),
    const Color(0xffE1E1C6),
  ];
  Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B2E2D),
      appBar: AppBar(
        title: const Text("Implicit Animation"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: SizedBox(
          height: 350,
          width: 350,
          child: GridView.builder(
            itemCount: 100,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              double number = Random().nextDouble();
              return TweenAnimationBuilder(
                onEnd: () => setState(() {}),
                tween: Tween(begin: -20.0 * number, end: 20.0 * number),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  if ((index ~/ 10) % 2 == 0) {
                    //짝수 줄
                    if (index % 2 == 0) {
                      _color = _colors[0];
                    } else {
                      _color = _colors[1];
                    }
                  } else {
                    //홀수 줄
                    if (index % 2 == 0) {
                      _color = _colors[3];
                    } else {
                      _color = _colors[2];
                    }
                  }
                  return Transform.translate(
                    offset: Offset(value, value),
                    child: Container(
                      color: _color,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
