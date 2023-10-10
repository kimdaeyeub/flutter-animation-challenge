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

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1,
  );

  Color _bgColor = Colors.blue;
  String _title = "";

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
    if (_position.value.isNegative) {
      _bgColor = const Color(0xffFF7951);
      _title = "Need to review";
    } else {
      _bgColor = Colors.green;
      _title = "I got it right";
    }
    setState(() {});
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 4 ? 0 : _index + 1;
      _factor = 0;
      _bgColor = Colors.blue;
    });
    _progressAnimationController.forward();
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      setState(() {
        _factor = _position.value.isNegative ? -1 : 1;
      });
      _animationController.reset();
      _title = "";
      _position
          .animateTo(
            (dropZone) * _factor,
            curve: Curves.easeOut,
          )
          .whenComplete(_whenComplete);
    } else {
      _bgColor = Colors.blue;
      _title = "";

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
    {"question": "한국의 수도", "answer": "서울"},
    {"question": "세상에서 가장 쉬운 숫자는?", "answer": "190000(십구만)"},
    {"question": "날마다 흑심을 품고 다니는 것은?", "answer": "연필"},
    {"question": "손님이 뜸하면 돈을 버는 사람은?", "answer": "한의사"},
    {"question": "오래될수록 젊어 보이는 것은", "answer": "사진"},
  ];

  void _onTap() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  final ValueNotifier<double> _progress = ValueNotifier(0.0);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  double _double = 0.0;

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
    _progressAnimationController.addListener(() {
      _progress.value = _double + _progressAnimationController.value * 0.2;
      if (_progressAnimationController.isCompleted) {
        _double = _index.toDouble() * 0.2;
        _progressAnimationController.reset();
      }
    });
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
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: _bgColor,
                ),
              ),
              Positioned(
                top: 110,
                child: Text(
                  _title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 180,
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
                                    text:
                                        "답변: ${_texts[_index]["answer"].toString()}",
                                  ),
                                )
                              : Card(
                                  index: _index,
                                  text: _texts[_index]["question"]!,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: ValueListenableBuilder(
                  valueListenable: _progress,
                  builder: (context, value, child) {
                    return Container(
                      // width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      // height: 80,
                      child: CustomPaint(
                        size: const Size(350, 30),
                        painter: ProgressBarPainter(
                          value: _progress.value,
                        ),
                      ),
                    );
                  },
                ),
              )
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
      child: Container(
        width: size.width * 0.8,
        height: size.height * 0.55,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
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

class ProgressBarPainter extends CustomPainter {
  final double value;

  ProgressBarPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    // final bgPaint = Paint()..color = Colors.teal.shade300;

    // final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // canvas.drawRect(bgRect, bgPaint);
    final bgPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;

    final progressPaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 15;

    // final volumeRect = Rect.fromLTWH(0, 0, size.width * value, size.height);
    // canvas.drawRect(volumeRect, volumePaint);

    canvas.drawLine(Offset.zero, Offset(size.width, 0), bgPaint);
    canvas.drawLine(Offset.zero, Offset(size.width * value, 0), progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBarPainter oldDelegate) {
    // return oldDelegate.
    return oldDelegate.value != value;
  }
}
