

import 'package:password_manager/Elements/Widgets/PaymentCard.dart';
import 'package:password_manager/models/OnBoardingPageModel.dart';

class Constants {
  static List<OnBoardingPageModel> onBoarding = [
    OnBoardingPageModel(
        title: "Master the Chaos",
        icon: "shieldv1.png",
        description:
            "With LOK-ey, effortlessly manage and organize your passwords across devices. No more forgotten keys ! LOK-ey has you covered."),
    OnBoardingPageModel(
        title: "Futuristic Features",
        icon: "biometrics.png",
        description:
            "Embrace the future with cutting-edge encryption, biometric access, and seamless synchronization. Your data, your rules."),
    OnBoardingPageModel(
        title: "A Realm of Possibilities",
        icon: "hammer.png",
        description:
            "Explore the cosmos of security with LOK-ey. From strong password generation to breach alerts, we've got every aspect covered."),
    OnBoardingPageModel(
        title: "Join the League of Loki",
        icon: "elite.png",
        description:
        "Be part of the elite circle that values privacy and security above all.\nLOK-ey - where power meets protection."),
  ];


  CardType getType(String s){
    switch(s){
      case 'credit':
        return CardType.credit;
      case 'debit':
        return CardType.debit;
      case 'prepaid':
        return CardType.prepaid;
      case 'giftCard':
        return CardType.giftCard;
      default:
        return CardType.other;
    }

  }
}
