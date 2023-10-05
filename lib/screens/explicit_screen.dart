import 'package:flutter/material.dart';

class ExplicitScreen extends StatefulWidget {
  const ExplicitScreen({super.key});

  @override
  State<ExplicitScreen> createState() => _ExplicitScreenState();
}

class _ExplicitScreenState extends State<ExplicitScreen>
    with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    const Color(0xffDCDCD2),
    Colors.black,
  ];

  Color _color = Colors.red;
  Color _bgColor = Colors.black;
  Color _whiteTile = Colors.white;
  Color _blackTile = Colors.black;

  late final AnimationController _animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  );

  late Animation<double> _rotation;

  final Curve _curve = Curves.linear;

  @override
  void initState() {
    super.initState();
    _animation.forward();
    _animation.addListener(() {
      if (_animation.value > 0.5) {
        //black turn
        //white tile=>transparent
        _bgColor = _colors[0];
        _whiteTile = Colors.transparent;
        _blackTile = Colors.black;
      } else {
        //white turn
        _bgColor = Colors.black;
        _blackTile = Colors.transparent;
        _whiteTile = _colors[0];
      }
      setState(() {});
    });
    _animation.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Center(
          child: Container(
            color: _bgColor,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 64,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemBuilder: (context, index) {
                final lineNumber = (index ~/ 8) + 1;
                if ((index ~/ 8) % 2 == 0) {
                  if (index % 2 == 0) {
                    //짝수 흰칸
                    _color = _whiteTile;
                    _rotation = Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: _animation,
                        curve: Interval(
                          0.05 * lineNumber,
                          0.05 * lineNumber + 0.1,
                          curve: _curve,
                        ),
                      ),
                    );
                  } else {
                    //짝수 검은칸
                    _color = _blackTile;
                    _rotation = Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: _animation,
                        curve: Interval(
                          0.05 * (9 + lineNumber),
                          0.05 * (9 + lineNumber) + 0.1,
                          curve: _curve,
                        ),
                      ),
                    );
                  }
                } else {
                  if (index % 2 == 0) {
                    //홀수줄 검은칸
                    _color = _blackTile;
                    _rotation = Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: _animation,
                        curve: Interval(
                          0.05 * (9 + lineNumber),
                          0.05 * (9 + lineNumber) + 0.1,
                          curve: _curve,
                        ),
                      ),
                    );
                  } else {
                    //홀수줄 흰칸
                    _color = _whiteTile;
                    _rotation = Tween(begin: 0.0, end: 0.25).animate(
                      CurvedAnimation(
                        parent: _animation,
                        curve: Interval(
                          0.05 * lineNumber,
                          0.05 * lineNumber + 0.1,
                          curve: _curve,
                        ),
                      ),
                    );
                  }
                }
                return RotationTransition(
                  turns: _rotation,
                  child: Container(
                    color: _color,
                  ),
                );
                // return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
