import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_generator/src/password_generator.dart';
import 'package:flutter/services.dart';

class PasswordGeneratorView extends StatefulWidget {
  const PasswordGeneratorView({Key? key}) : super(key: key);

  @override
  State<PasswordGeneratorView> createState() => _PasswordGeneratorViewState();
}

class _PasswordGeneratorViewState extends State<PasswordGeneratorView> {
  // double sliderValue = 12;
  //
  // bool hasNumerical = false;
  // bool hasUppercase = false;
  // bool hasLowercase = true;
  // bool hasCharacter = false;

  // String generatedPassword = "";

  final RootController _rootController = Get.put(RootController());
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          "Password Generator",
          style: TextStyle(
            fontFamily: 'ocr-a',
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: context.height * 0.15,
          width: context.width * 0.8,
          decoration: BoxDecoration(
              color: _rootController.primaryColor.value,
              borderRadius: BorderRadius.circular(36)),
          child: Center(
            child: Padding(padding: const EdgeInsets.all(16),child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(child: Text(
                  _mainController.generatedPassword.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'ocr-a',
                    fontSize: 18,
                  ),
                ),),
                const SizedBox(height: 40,),
                Center(child: InkWell(
                  onTap: (){
                    Clipboard.setData(ClipboardData(text: _mainController.generatedPassword.value));

                  },
                  child: const Icon(FontAwesomeIcons.paste,size: 24,color: Colors.white,),
                ),)
              ],
            ),),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 60,
                inactiveTrackColor: _rootController.secondaryColor.value.withOpacity(0.3),
                activeTrackColor: _rootController.secondaryColor.value,
                thumbColor: Colours.lokiLightBeige,
                valueIndicatorTextStyle: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'ocr-a',
                  fontSize: 24,
                ),
                overlayColor: Colours.lokiDarkGreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Length",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                    ),
                  ),
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: context.width * 0.6,
                          height: 60,
                          child: Slider(
                            label: _mainController.sliderValue.value.round().toString(),
                            value: _mainController.sliderValue.value,
                            min: 8,
                            max: 30,
                            onChanged: (value) {
                              _mainController.sliderValue.value = value;
                            },
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              _mainController.sliderValue.value.round().toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _mainController.sliderValue.value > 15
                                    ? Colors.white
                                    : Colors.black,
                                fontFamily: 'ocr-a',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            buildCell("Lowercase", _mainController.hasLowercase.value, (b) {

            }),
            buildCell("Uppercase", _mainController.hasUppercase.value, (b) {
              setState(() {
                _mainController.hasUppercase.value = b;
              });
            }),
            buildCell("Numbers", _mainController.hasNumerical.value, (b) {
              setState(() {
                _mainController.hasNumerical.value = b;
              });
            }),
            buildCell("Characters",_mainController.hasCharacter.value, (b) {
              setState(() {
                _mainController.hasCharacter.value = b;
              });
            }),
          ],
        ),
        // Expanded(
        //     child: Center(
        //   child: ElevatedButton(
        //     onPressed: () {
        //       final passwordGenerator = PasswordGenerator(
        //         length: sliderValue.round(),
        //         hasCapitalLetters: hasUppercase,
        //         hasNumbers: hasNumerical,
        //         hasSmallLetters: hasLowercase,
        //         hasSymbols: hasCharacter,
        //       );
        //       setState(() {
        //         generatedPassword = passwordGenerator.generatePassword();
        //       });
        //
        //       // We call the generatePassword method on the PasswordGenerator instance
        //       // that returns a String.
        //     },
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(
        //           _rootController.secondaryColor.value), // Set the background color
        //       textStyle: MaterialStateProperty.all<TextStyle>(
        //         const TextStyle(color: Colors.white),
        //       ), // Set the padding
        //     ),
        //     child: const Text(
        //       'Generate Password',
        //       style: TextStyle(
        //           fontFamily: 'ocr-a', fontSize: 24, color: Colors.white),
        //     ),
        //   ),
        // ))
      ],
    ));
  }

  TableRow buildCell(String title, bool b, Function(bool b) onTap) {
    return TableRow(children: [
      TableCell(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 48.0),
            // Adjust the padding as needed
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.center,
                // Center the text horizontally within the cell
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),
      TableCell(
        child: Center(
          child: Transform.scale(
            scale: 1.5,
            child: Checkbox(
              checkColor: _rootController.primaryColor.value,
              shape: const CircleBorder(),
              activeColor: _rootController.secondaryColor.value,
              onChanged: (b) {
                onTap(b!);
              },
              value: b,
            ),
          ),
        ),
      ),
    ]);
  }
}
