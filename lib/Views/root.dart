import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Views/Auth/RegisterAndLogin.dart';
import 'package:password_manager/Views/Home/HomeScreen.dart';
import 'package:password_manager/Views/OnBoarding/introPage.dart';

class Root extends StatelessWidget {
  Root({super.key});



  final RootController _controller = Get.put(RootController());
  @override
  Widget build(BuildContext context) {


    if(!_controller.isFirstTime! && _controller.passcode.isEmpty){
      return  RegisterAndLogin();

    }

    if(_controller.passcode.isNotEmpty){
      return HomeScreen();
    }

    return const IntroPage();




  }
}
