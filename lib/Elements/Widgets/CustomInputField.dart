import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData iconData;


  const CustomInputField({super.key, required this.label, required this.controller, required this.iconData});

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final  RootController _rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: context.width*0.90,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: _rootController.secondaryColor.value.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: _rootController.primaryColor.value,
        style:  TextStyle(
          fontFamily: 'ocr-a',
          fontSize: 14,
          color: _rootController.primaryColor.value,
        ),
        decoration:  InputDecoration(
          labelText: widget.label,

          prefixIcon:  Icon(
            widget.iconData,
            color:_rootController.primaryColor.value,
          ),
          labelStyle:  TextStyle(
            fontFamily: 'ocr-a',
            fontSize: 12,
            color: _rootController.primaryColor.value,
          ),

          border: InputBorder.none,
        ),

      ),
    );
  }
}
