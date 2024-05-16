import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Elements/Widgets/PaymentCard.dart';
import 'package:password_manager/Models/CardModel.dart';

class CardsViewPage extends StatefulWidget {
  const CardsViewPage({Key? key}) : super(key: key);

  @override
  State<CardsViewPage> createState() => _CardsViewPageState();
}

class _CardsViewPageState extends State<CardsViewPage> {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _mainController.cards.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              height: 50,
                              child: Text(
                                "Saved Cards",
                                style: TextStyle(
                                  fontFamily: 'ocr-a',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ] +
                      List.generate(_mainController.cards.length, (index) {
                        CardModel card = _mainController.cards[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: InkWell(
                                onLongPress: () {
                                  _mainController.deleteCard(context, card.id);
                                },
                                child: PaymentCardUi(
                                  cardHolderFullName: card.cardHolder,
                                  cardNumber: card.cardNumber,
                                  validThru: card.validThru,
                                  scale: 1.25,
                                  cardType: card.cardType,
                                  showValidFrom: false,
                                  bottomRightColor: Color(
                                      ColorUtils.hexToInt(card.colorBottom)),
                                  topLeftColor:
                                      Color(ColorUtils.hexToInt(card.colorTop)),
                                  placeNfcIconAtTheEnd: true,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        );
                      })),
            )
          :  Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Add some Cards",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Icon(FontAwesomeIcons.arrowDown,size: context.height*0.3,).animate().shake(delay: 1000.ms)
                ],
              ),
            ),
    );
  }
}
