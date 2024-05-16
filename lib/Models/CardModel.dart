

import 'package:password_manager/Core/Constants/Constants.dart';
import 'package:password_manager/Elements/Widgets/PaymentCard.dart';

class CardModel {
  int? id;
  String cardNumber;
  String cardHolder;
  String validThru;
  String colorTop;
  String colorBottom;
  CardType cardType;
  int createdAt;

  CardModel({
    this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.colorBottom,
    required this.colorTop,
    required this.validThru,
    required this.cardType,
    required this.createdAt,
  });


  // Factory method to create a Card object from a JSON string
  factory CardModel.fromJson(Map<String, dynamic> json) {
    CardType type =Constants().getType(json['cardType']) ;
    return CardModel(
      id: json['id'],
      cardNumber: json['cardNumber'],
      cardHolder: json['cardHolder'],
      validThru: json['validThru'],
      colorTop: json['colorTop'],
      colorBottom: json['colorBottom'],
      cardType:type,
      createdAt: json['created_at']
    );
  }

  // Convert the Card object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardNumber': cardNumber,
      'cardHolder': cardHolder,
      'validThru': validThru,
      'colorTop': colorTop,
      'colorBottom': colorBottom,
      'cardType' : cardType.toString().split(".")[1],
      'created_at':createdAt,
    };
  }





}
