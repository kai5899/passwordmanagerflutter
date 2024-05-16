import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/Views/root.dart';

class OnBoardingController extends GetxController{
  PageController pageController = PageController();
  RxInt? currentPage = 0.obs;

  final GetStorage _localStore = GetStorage();

  @override
  void onInit() {
    super.onInit();
    pageController.addListener(() {
      currentPage!.value = pageController.page!.round();
    });


  }
  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }



  void move(){
    if(currentPage!.value !=3){
      pageController.nextPage(duration: 500.ms, curve: Curves.linear);
    }
    else{

      _localStore.write('firstTime', false);
      Get.offAll(()=> Root());
    }
  }
}