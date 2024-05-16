import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/models/OnBoardingPageModel.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.item, required this.color});

  final OnBoardingPageModel item;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Image.asset(
          "assets/icons/boarding/${item.icon}",
          height: Get.height * 0.25,
          width: Get.width * 0.9,
        ).animate().scale().then().shimmer(duration: 1000.ms),
        SizedBox(
          height: context.height * 0.05,
        ),
        Text(
          item.title.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 36, color: color, fontFamily: 'dameron'),
        ).animate().fade(duration: 500.ms).scale(delay: 300.ms),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            item.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'ocr-a',
              fontSize: 24,
              color: Colors.grey.withOpacity(0.85),
            ),
          ).animate().fade(duration: 1000.ms),
        ),
      ],
    );
  }
}
