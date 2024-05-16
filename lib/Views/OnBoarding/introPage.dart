import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/Views/OnBoarding/onBoardingHolder.dart';
import 'package:password_manager/core/Colors/Colours.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                "assets/images/loki-bg.jpg",
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              // const FaIcon(
              //   FontAwesomeIcons.crown,
              //   size: 36,
              //   color: Colours.lokiGold,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "LOK",
                    style: TextStyle(
                        fontFamily: "CloisterBlack",
                        color: Colours.lokiLightBeige,
                        fontSize: context.height * 0.1),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                        color: Colours.lokiLightBeige,
                        fontFamily: "Oldengl",
                        fontSize: context.height * 0.1),
                  ),
                  Text(
                    "ey",
                    style: TextStyle(
                        color: Colours.lokiLightBeige,
                        fontFamily: "Oldengl",
                        fontSize: context.height * 0.1),
                  ),
                ],
              ),
              FaIcon(
                FontAwesomeIcons.shield,
                size: Get.height * 0.15,
                color: Colours.lokiGold,
              ).animate().shimmer(
                    duration: 1000.ms,
                  ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              const Text(
                'Unlock the Power of Security with LOK-ey\nYour Trusted Password Guardian!',
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              const Text(
                'Click below to continue!',
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const OnBoardingHolder());
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
