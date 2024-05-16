import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utilities {

  static void showAlert(BuildContext context,{required String title , required String desc , required DialogType type ,required Function onOkPressed }){
    AwesomeDialog(
      context: context,
      dialogType: type,
      dialogBackgroundColor: Get.theme.colorScheme.background,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnCancelOnPress: () {
        Get.back();
      },
      btnOkOnPress: () {
        onOkPressed();
      },
    ).show();
  }
}