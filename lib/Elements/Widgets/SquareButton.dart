import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';

class SquareButton extends StatelessWidget {
  final Function onPressed;

  const SquareButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Get.put(RootController()).secondaryColor.value,
            borderRadius: BorderRadius.circular(12)),
        child: const Center(
          child: Icon(
            FontAwesomeIcons.pen,
            color: Colors.white,
          ),
        ),
      ),
    ));
  }
}