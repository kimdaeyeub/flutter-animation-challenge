import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintScreen extends StatefulWidget {
  const CustomPaintScreen({super.key});

  @override
  State<CustomPaintScreen> createState() => _CustomPaintScreenState();
}

class _CustomPaintScreenState extends State<CustomPaintScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  );

  late final AnimationController _btnController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  bool _isPlaying = false;
  int _seconds = 10;
  Timer? timer;

  void _togglePlay() {
    if (_isPlaying) {
      _animationController.stop();
      _btnController.reverse();
      _isPlaying = false;
      timer!.cancel();
    } else {
      _animationController.forward();
      _btnController.forward();
      _isPlaying = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds = _seconds - 1;
        setState(() {});
      });
    }
    setState(() {});
  }

  void _onStop() {
    _animationController.stop();
    _btnController.reverse();
    _isPlaying = false;
    if (_seconds != 10) {
      timer!.cancel();
    }
  }

  void _reset() {
    if (_isPlaying) {
      _isPlaying = false;
    }
    _animationController.reset();
    _btnController.reverse();
    if (_seconds != 10) {
      timer!.cancel();
    }
    _seconds = 10;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reset();
        _btnController.reverse();
        _isPlaying = false;
        timer!.cancel();
        _seconds = 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return CustomPaint(
                          size: const Size(
                            250,
                            250,
                          ),
                          painter: TimerPainter(
                            progress: _animationController.value,
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    child: Text(
                      _seconds >= 10 ? "00:$_seconds" : "00:0$_seconds",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _reset,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xffFE767A),
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedIcon(
                      icon: AnimatedIcons.play_pause,
                      progress: _btnController,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: _onStop,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.stop,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;

  TimerPainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final circlePaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawCircle(center, size.width / 2, circlePaint);

    final timerRect = Rect.fromCircle(center: center, radius: size.width / 2);
    final timerPaint = Paint()
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.pink.shade400;
    canvas.drawArc(
        timerRect, -1 / 2 * pi, progress * 2 * pi, false, timerPaint);
  }

  @override
  bool shouldRepaint(covariant TimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
