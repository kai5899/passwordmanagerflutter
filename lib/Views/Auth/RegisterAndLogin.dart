import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/FirstTimeLoginController.dart';
import 'package:password_manager/core/Colors/Colours.dart';
import 'package:password_manager/elements/LoginWidgets/AnimatedKey.dart';

class RegisterAndLogin extends StatelessWidget {
  RegisterAndLogin({super.key});

  final FirstTimeLoginController controller =
      Get.put(FirstTimeLoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/icon_loki.png',
              height: 175,
              width: 175,
            ),
             Text(
              "Welcome".toUpperCase(),
              style: const TextStyle(
                fontFamily: 'ocr-a',
                fontSize: 30,
                color: Colours.lokiDarkGreen,
              ),
            ),
            const Text(
              "Enter your security code. it should be of length 5",
              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily: 'ocr-a',
                fontSize: 16,
                color: Colours.lokiBeige,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Center(
                child: SizedBox(
                  height: 100,
                  width: Get.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      controller.combo.value.length,
                      (index) => Container(
                        // margin: const EdgeInsets.all(10),
                        height: 80,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colours.lokiGold,
                        ),
                        child: Center(
                          child: Text(
                            controller.combo.value[index],
                            style: const TextStyle(
                              fontFamily: 'ocr-a',
                              fontSize: 36,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .shake(duration: 300.ms)
                          .shimmer(duration: 300.ms),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedKey(title: 1),
                AnimatedKey(title: 2),
                AnimatedKey(title: 3),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
             const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedKey(title: 4),
                AnimatedKey(title: 5),
                AnimatedKey(title: 6),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimatedKey(title: 7),
                AnimatedKey(title: 8),
                AnimatedKey(title: 9),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [AnimatedKey(title: 0), AnimatedKey(title: -1)],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                  controller.saveAndContinue();
              },
              child: Container(
                height: 70,
                width: 250,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colours.lokiBeige, Colours.lokiGold]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Save and continue",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
