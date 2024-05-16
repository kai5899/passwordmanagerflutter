import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final RootController _rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  title: const Text(
                    "App Primary Color",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(

                      color: _rootController.primaryColor.value,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    Color hold = _rootController.primaryColor.value;
                    colorPickerDialog(
                      _rootController.primaryColor.value,
                      (Color c) {
                        _rootController.setColor("primaryColor", 0, c);
                      },
                    ).then((value){
                      if(value==false){
                        _rootController.primaryColor.value = hold;
                        _rootController.setColor("primaryColor", 0, hold);
                      }
                    });;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  title: const Text(
                    "App Secondary Color",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: _rootController.secondaryColor.value,

                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    Color hold = _rootController.secondaryColor.value;

                    colorPickerDialog(
                      _rootController.secondaryColor.value,
                      (Color c) {
                        _rootController.setColor("secondaryColor", 1, c);
                      },
                    ).then((value){
                      if(value==false){
                        _rootController.secondaryColor.value = hold;
                        _rootController.setColor("secondaryColor", 1,hold);
                      }
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  title: const Text(
                    "Back to default",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                    ),
                  ),
                  trailing: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      gradient:  LinearGradient(
                          colors: [Colours.lokiGold, Colours.lokiDarkGreen]),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    _rootController.setToDefault(context);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(
                      fontFamily: 'ocr-a',
                      fontSize: 18,
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 1.25,
                    child: DayNightSwitcherIcon(
                      isDarkModeEnabled: _rootController.isDarkMode.value,
                      onStateChanged: (isDarkModeEnabled) {
                        _rootController.toggleTheme();
                      },
                    ),
                  ),
                  onTap: () {
                    // _rootController.toggleTheme();
                  },
                ),
              ),
            ),
          ],
        ));
  }

  Future<bool> colorPickerDialog(Color c, Function(Color) onTap) async {
    return ColorPicker(
      heading: const Center(
        child: Text(
          'Select color',
          style: TextStyle(
            fontFamily: 'ocr-a',
            fontSize: 18,
          ),
        ),
      ),
      // Use the dialogPickerColor as start color.
      color: c,
      // Update the dialogPickerColo[r using the callback.

      onColorChanged: (Color color) {
        onTap(color);
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,

      subheading: const Text(
        'Select color shade',
        style: TextStyle(
          fontFamily: 'ocr-a',
          fontSize: 18,
        ),
      ),
      wheelSubheading: const Text(
        'Selected color and its shades',
        style: TextStyle(
          fontFamily: 'ocr-a',
          fontSize: 18,
        ),
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
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      // customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      backgroundColor: Get.theme.colorScheme.background,
      // New in version 3.0.0 custom transitions support.
      // transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
