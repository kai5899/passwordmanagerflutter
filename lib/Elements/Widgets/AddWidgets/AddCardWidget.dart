import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Controllers/temps/AddCardController.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
import 'package:password_manager/Elements/Widgets/PaymentCard.dart';
import 'package:password_manager/Models/CardModel.dart';
import 'package:password_manager/core/Colors/Colours.dart';
import 'package:get/get.dart';

class AddCardForm extends StatefulWidget {
  const AddCardForm({Key? key}) : super(key: key);

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  final _formKey = GlobalKey<FormState>();
  final AddCardController _addCardController = Get.put(AddCardController());

  late Color topColor;
  late Color bottomColor;

  @override
  void initState() {
    super.initState();
    topColor = Colors.yellow;
    bottomColor = Colors.red;
  }


  final MainController _mainController = Get.put(MainController());


  void _addCard() async {
    if (_formKey.currentState!.validate()) {
      int time = DateTime.now().millisecondsSinceEpoch;

      CardModel c = CardModel(
          cardNumber: _addCardController.cardNumber.value,
          cardHolder: _addCardController.cardHolder.value,
          colorBottom: bottomColor.hex,
          colorTop: topColor.hex,
          validThru: _addCardController.validThru.value,
          cardType: _addCardController.cardType.value,
          createdAt: time);

      _mainController.addCard(c);

      _addCardController.cardNumberController.clear();
      _addCardController.holderController.clear();
      _addCardController.validThruController.clear();

      // You can add additional logic like showing a confirmation dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Add a new Card",
              style: TextStyle(
                fontFamily: 'ocr-a',
                fontSize: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Obx(
                    () => PaymentCardUi(
                  cardHolderFullName: _addCardController.cardHolder.value,
                  cardNumber: _addCardController.cardNumber.value,
                  validThru: _addCardController.validThru.value,
                  scale: 0.9,
                  cardType: _addCardController.cardType.value,
                  showValidFrom: false,
                  bottomRightColor: bottomColor,
                  topLeftColor: topColor,
                  placeNfcIconAtTheEnd: true,
                ),
              ),
            ),
            CustomInputField(
              controller: _addCardController.cardNumberController,
              label: "Card Number",
              iconData: FontAwesomeIcons.creditCard,
            ),
            const SizedBox(height: 20),
            CustomInputField(
              controller: _addCardController.holderController,
              label: "Card Holder",
              iconData: FontAwesomeIcons.idCard,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select a Card Type",
                      style: TextStyle(
                        fontFamily: 'ocr-a',
                        fontSize: 12,
                      ),
                    ),
                    Obx(() => DropdownButton(
                      dropdownColor: Colours.lokiGold,
                      style: const TextStyle(
                        fontFamily: 'ocr-a',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      hint: const Text("Select a card type"),
                      value: _addCardController.cardType.value,
                      onChanged: (CardType? newValue) {
                        _addCardController.cardType.value = newValue!;
                      },
                      items: CardType.values.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontFamily: 'ocr-a',
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Valid thru",
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 12,
                ),
              ),
              trailing: Obx(()=>Text(
                _addCardController.validThru.value,
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
              onTap: () {
                showDatePicker(
                  context: context,

                  initialDate: DateTime(2023),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  _addCardController.validThru.value =
                  '${value?.month}/${value?.year.toString().substring(2)}';
                });
              },
            ),
            ListTile(
              title: const Text('Select a top color',
                  style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 12,
                  )),
              trailing: ColorIndicator(
                width: 30,
                height: 30,
                borderRadius: 22,
                color: topColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = topColor;
                  // Wait for the picker to close, if dialog was dismissed,
                  // then restore the color we had before it was opened.
                  bool a = await colorPickerDialog(
                    topColor,
                        (p0) {
                      setState(() {
                        topColor = p0;
                      });
                    },
                  );

                  if (!a) {
                    setState(() {
                      topColor = colorBeforeDialog;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Select a bottom color',
                  style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 12,
                  )),
              trailing: ColorIndicator(
                width: 30,
                height: 30,
                borderRadius: 22,
                color: bottomColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = bottomColor;
                  // Wait for the picker to close, if dialog was dismissed,
                  // then restore the color we had before it was opened.
                  bool a = await colorPickerDialog(
                    bottomColor,
                        (p0) {
                      setState(() {
                        bottomColor = p0;
                      });
                    },
                  );
                  if (!a) {
                    setState(() {
                      bottomColor = colorBeforeDialog;
                    });
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addCard,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Get.put(RootController()).secondaryColor.value), // Set the background color
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white),
                ), // Set the padding
              ),
              child: const Text(
                'Save Card',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<bool> colorPickerDialog(
      Color c, Function(Color) onColorChanged) async {
    Color selectedColor = c;
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: c,
      // Update the dialogPickerColo[r using the callback.
      onColorChanged: (Color color) {
        selectedColor = color;
        onColorChanged(selectedColor);
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: false,
      showColorName: false,
      showColorCode: false,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      // transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
