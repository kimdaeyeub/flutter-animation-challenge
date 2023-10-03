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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _onMoveScreen(
                  const ImplicitAnimation(),
                ),
                child: const MenuButton(
                  text: "Day 1",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
