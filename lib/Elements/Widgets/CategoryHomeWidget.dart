import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Models/CategoryModel.dart';

class CategoryHomeWidget extends StatelessWidget {
  final int index;
  final Category category;
  final Function onTap;

  const CategoryHomeWidget({
    super.key,
    required this.index,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: context.height * 0.125,
        decoration: BoxDecoration(
          color: Color(ColorUtils.hexToInt(category.color)),
          borderRadius: BorderRadius.circular(24),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                category.name.capitalizeFirst!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'ocr-a',
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),

        // width: 100,
      ),
    );
  }
}

// TODO : request the password everytime , after sometime.

// Todo : create a top secret vault , even the avengers can't have access to it.
