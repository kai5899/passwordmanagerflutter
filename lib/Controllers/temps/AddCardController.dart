
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Elements/Widgets/PaymentCard.dart';

class AddCardController extends GetxController{
  final cardNumberController = TextEditingController();
  final holderController = TextEditingController();
  final validThruController = TextEditingController();

  RxString cardNumber = ''.obs;
  RxString cardHolder = ''.obs;
  RxString validThru ='${ DateTime.now().month.toString()}/${ DateTime.now().year.toString().substring(2)}'.obs;




  Rx<CardType> cardType = Rx(CardType.credit);
  @override
  void onInit() {
    super.onInit();
    cardNumberController.addListener(() {
      cardNumber.value = cardNumberController.text;
      cardNumber.refresh();
    });
    holderController.addListener(() {
      cardHolder.value = holderController.text;
      cardHolder.refresh();
    });
  }
}