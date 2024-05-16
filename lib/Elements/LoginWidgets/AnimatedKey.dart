import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/FirstTimeLoginController.dart';
import 'package:password_manager/core/Colors/Colours.dart';

class AnimatedKey extends StatefulWidget {
  const AnimatedKey({super.key, required this.title});

  final int title;

  @override
  State<AnimatedKey> createState() => _AnimatedKeyState();
}

class _AnimatedKeyState extends State<AnimatedKey>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _radiusAnimation;

  final Color _startColor = Colors.transparent;
  final Color _endColor = Colours.lokiGold;

  final double _startRadius = 200;
  final double _endRadius = 0;

  final FirstTimeLoginController _loginController = Get.put(FirstTimeLoginController());

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: 500.ms,
      vsync: this,
    );

    // Create a ColorTween for the animation
    final colorTween = ColorTween(begin: _startColor, end: _endColor);
    final radiusTween = Tween<double>(begin: _startRadius, end: _endRadius);

    // Create the animation
    _colorAnimation = colorTween.animate(_controller);
    _radiusAnimation = radiusTween.animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(360),
      child: Container(
          height: 75,
          width: 75,
          decoration:  BoxDecoration(
            color: widget.title!=-1 ? Colours.lokiDarkGreen : Colours.lokiBeige,
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    height: _radiusAnimation.value,
                    width: _radiusAnimation.value,
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      shape: BoxShape.circle,
                      // color: Colors.red,
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  widget.title!=-1 ? widget.title.toString() : "<",

                  style:const  TextStyle(
                    fontFamily:'ocr-a',
                    fontSize: 36,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
      onTap: () {


        _controller.forward().whenComplete(() => _controller.reverse());
        _loginController.addToCombo(widget.title.toString());
        // print(_radiusAnimation.value);
      },
    );
  }
}
