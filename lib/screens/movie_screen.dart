import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  int _index = 0;
  bool _moveRight = true;

  void _onPageChanged(int value) {
    if (value > _index) {
      setState(() {
        _moveRight = true;
      });
    } else {
      _moveRight = false;
    }
    setState(() {
      _index = value;
    });
  }

  bool _isDragDown = false;

  void _toggleDrag() {
    setState(() {
      _isDragDown = !_isDragDown;
    });
  }

  final List<String> _title = [
    "인터스텔라",
    "캐래비안의 해적",
    "블레이드 러너",
    "듄",
    "배트맨",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),
            child: Container(
              key: ValueKey(_index),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/${_index + 1}.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  _title[_index],
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Official Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: Colors.white,
                  height: 30,
                ),
                const Text(
                  "Packages on pub.dev",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Flutter has a rich ecosystem of packages that have been contributed by the Flutter team and the broader open source community to a central repository. Among the thousands of packages, you'll find support for Firebase, Google Fonts, hardware services like Bluetooth and camera, new widgets and animations, and integration with other popular web services. You can browse those packages at pub.dev.",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                )
              ],
            )
                .animate(target: _isDragDown ? 1 : 0)
                .slideY(begin: -1, end: 0.05, duration: 500.ms),
          ),
          // .fadeIn(begin: 0, duration: 600.ms),
          PageView.builder(
            onPageChanged: _onPageChanged,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: _toggleDrag,
                          child: FaIcon(
                            _isDragDown
                                ? FontAwesomeIcons.chevronUp
                                : FontAwesomeIcons.chevronDown,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: _isDragDown ? 50 : 200,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 250,
                              ),
                              Text(
                                _title[index],
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                width: 300,
                                child: Text(
                                  "If they are swapped fast enough (i.e. before duration elapses), more than one previous child can exist and be transitioning out while the newest one is transitioning in.",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Office Rating",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ).animate().slideX(begin: _moveRight ? 1 : -1, end: 0),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: 50,
                    child: Container(
                      height: 380,
                      width: 330,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        "assets/${index + 1}.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                        .animate(
                          delay: 500.ms,
                        )
                        .slideX(begin: _moveRight ? 1 : -1, end: 0)
                        .fadeIn(begin: 0, duration: 300.ms),
                  )
                      .animate(target: _isDragDown ? 1 : 0)
                      .slideY(begin: 0, end: 0.1),
                ],
              )
                  .animate(target: _isDragDown ? 1 : 0)
                  .slideY(begin: 0, end: 0.75);
            },
          ),
        ],
      ),
    );
  }
}
