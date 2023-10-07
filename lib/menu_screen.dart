import 'package:animation_course/screens/custom_paint.dart';
import 'package:animation_course/screens/explicit_screen.dart';
import 'package:animation_course/screens/implicit_animation.dart';
import 'package:animation_course/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  void _onMoveScreen(Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => _onMoveScreen(
                  const ImplicitAnimation(),
                ),
                child: const MenuButton(
                  text: "Day 1",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => _onMoveScreen(
                  const ExplicitScreen(),
                ),
                child: const MenuButton(
                  text: "Day 2",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => _onMoveScreen(
                  const CustomPaintScreen(),
                ),
                child: const MenuButton(
                  text: "Day 3",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
