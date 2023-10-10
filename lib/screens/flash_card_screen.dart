import 'dart:math';

import 'package:flutter/material.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen>
    with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  int _factor = 0;
  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

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

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  Color _bgColor = Colors.blue;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
    if (_position.value.isNegative) {
      _bgColor = const Color(0xffFF7951);
    } else {
      _bgColor = Colors.green;
    }
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 4 ? 0 : _index + 1;
      _factor = 0;
      _bgColor = Colors.blue;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      setState(() {
        _factor = _position.value.isNegative ? -1 : 1;
      });
      _position
          .animateTo(
            (dropZone) * _factor,
            curve: Curves.easeOut,
          )
          .whenComplete(_whenComplete);
    } else {
      _bgColor = Colors.blue;
      _position.animateTo(
        0,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 0;

  final _texts = [
    "Hello",
    "im fine",
    "and you?",
    "i",
    "me",
  ];

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
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation.transform(
                (_position.value + size.width / 2) / size.width,
              ) *
              pi /
              180;
          final scale = _scale.transform(_position.value.abs() / size.width);
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: _bgColor,
                ),
              ),
              // Positioned(
              //   top: 50,
              //   child: Transform.scale(
              //     scale: min(scale, 1.0),
              //     child: Card(
              //       index: _index == 4
              //           ? 0
              //           : _index == 0
              //               ? 0
              //               : _index + 1,
              //       text: _texts[_index == 4
              //           ? 0
              //           : _index == 0
              //               ? 0
              //               : _index + 1],
              //     ),
              //   ),
              // ),
              Positioned(
                top: 130,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle,
                      child: GestureDetector(
                        onTap: _onTap,
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.0015)
                            ..rotateY(_animation.value * pi),
                          child: _animation.value >= 0.5
                              ? Transform(
                                  alignment: FractionalOffset.center,
                                  transform: Matrix4.rotationY(1 * pi),
                                  child: Card(
                                    index: _index,
                                    text: _texts[_index == 4
                                        ? 0
                                        : _index == 0
                                            ? 0
                                            : _index + 1],
                                  ),
                                )
                              : Card(
                                  index: _index,
                                  text: _texts[_index == 4
                                      ? 0
                                      : _index == 0
                                          ? 0
                                          : _index + 1],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  final String text;

  const Card({
    super.key,
    required this.index,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.65,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
