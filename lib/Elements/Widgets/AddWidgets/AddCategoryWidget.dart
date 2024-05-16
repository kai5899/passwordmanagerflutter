import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
import 'package:password_manager/Models/CategoryModel.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();
  final _descriptionController = TextEditingController();

  IconData iconData = FontAwesomeIcons.person;

  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;

  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  final MainController _mainController = Get.put(MainController());




  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.fontAwesomeIcons],
        backgroundColor: Colours.lokiGold,
        iconColor: Colors.white,
        iconSize: 48,
        title: const Text(
          "Pick an Icon for your category",
          style: TextStyle(
            color: Colors.white,
          ),
          textScaleFactor: 1.25,
        ),
        closeChild: const Text(
          "Close",
          style: TextStyle(
            color: Colors.white,
          ),
          textScaleFactor: 1.25,
        ));

    iconData = icon!;
    setState(() {});
  }

  void _addCategory() async {
    if (_formKey.currentState!.validate()) {
      int time = DateTime.now().millisecondsSinceEpoch;
      Category category = Category(
        name: _nameController.text,
        color: dialogPickerColor.hex,
        icon: iconData,
        description: _descriptionController.text,
        createdAt: time,
        updatedAt: time,
      );

      _mainController.addCategory(category);

      _nameController.clear();
      _colorController.clear();
      _descriptionController.clear();

      // You can add additional logic like showing a confirmation dialog
    }
  }

  @override
  void initState() {
    super.initState(); // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
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
              height: 25,
            ),
            const Text(
              "Add a new Category",
              style: TextStyle(
                fontFamily: 'ocr-a',
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomInputField(
              controller: _nameController,
              label: "Category Name",
              iconData: FontAwesomeIcons.box,
            ),
            const SizedBox(height: 20),
            CustomInputField(
              controller: _descriptionController,
              label: "Category Description",
              iconData: FontAwesomeIcons.fileLines,
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Select a Color for your category',
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 14,
                ),
              ),
              trailing: ColorIndicator(
                width: 30,
                height: 30,
                borderRadius: 22,
                color: dialogPickerColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = dialogPickerColor;
                  // Wait for the picker to close, if dialog was dismissed,
                  // then restore the color we had before it was opened.
                  bool a = await colorPickerDialog();

                  if (!a) {
                    setState(() {
                      dialogPickerColor = colorBeforeDialog;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Select an Icon for you category',
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 14,
                ),
              ),
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  iconData,
                  color: dialogPickerColor,
                  size: 33,
                ),
              ),
              onTap: _pickIcon,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCategory,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Get.put(RootController()).secondaryColor.value), // Set the background color
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white),
                ), // Set the padding
              ),
              child: const Text(
                'Add Category',
                style: TextStyle(
                    fontFamily: 'ocr-a', fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: dialogPickerColor,
      // Update the dialogPickerColo[r using the callback.
      onColorChanged: (Color color) {
        setState(() => dialogPickerColor = color);
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
