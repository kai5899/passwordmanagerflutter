import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/onBoardingController.dart';
import 'package:password_manager/Views/OnBoarding/onBoardingPage.dart';
import 'package:password_manager/core/Colors/Colours.dart';
import 'package:password_manager/core/Constants/Constants.dart';

class OnBoardingHolder extends StatelessWidget {
  const OnBoardingHolder({super.key});

  @override
  Widget build(BuildContext context) {
    // PageController _pageController = PageController(initialPage: 0);

    OnBoardingController _controller = Get.put(OnBoardingController());

    List<Color> _colors = [
      Colours.lokiDarkGreen,
      Colours.lokiBeige,
      Colours.lokiGold,
      Colours.lokiLightGreen
    ];
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: () {
                  _controller.move();
                  // _controller.pageController
                  //     .nextPage(duration: 500.ms, curve: Curves.linear);
                },
                child: Obx(() => _controller.currentPage!.value != 3
                    ? const FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: 30,
                        color: Colours.lokiDarkGreen,
                      )
                    : Text(
                        "Enter",
                        style: GoogleFonts.getFont(
                          'Lato',
                          fontSize: 24,
                          color: _colors[3],
                        ),
                      )),
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller.pageController,
            itemCount: Constants.onBoarding.length,
            itemBuilder: (context, index) => OnBoardingPage(
              item: Constants.onBoarding[index],
              color: _colors[index],
            ),
          ),
        ),
        Obx(() => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _colors.length,
                  (index) => AnimatedContainer(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    duration: 300.ms,
                    width: index == _controller.currentPage!.value ? 40 : 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(index == 0 ? 12 : 360),
                        color: index == _controller.currentPage!.value
                            ? _colors[index]
                            : Colors.grey.withOpacity(0.7)),
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
