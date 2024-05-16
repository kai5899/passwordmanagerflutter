import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
import 'package:password_manager/Models/PasswordModel.dart';
import 'package:password_manager/core/Colors/Colours.dart';
import 'package:password_manager/Models/CategoryModel.dart';
import 'package:get/get.dart';

class AddPasswordForm extends StatefulWidget {
  const AddPasswordForm({Key? key}) : super(key: key);

  @override
  State<AddPasswordForm> createState() => _AddPasswordFormState();
}

class _AddPasswordFormState extends State<AddPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _siteController = TextEditingController();
  final _authController = TextEditingController();
  final _passwordController = TextEditingController();

  Category? selectedCategory;

  IconData iconData = FontAwesomeIcons.facebook;

  @override
  void initState() {
    super.initState();
    if (_mainController.categories.isNotEmpty) {
      selectedCategory = _mainController.categories[0];
    }
  }

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.fontAwesomeIcons],
        backgroundColor: Colours.lokiGold,
        iconColor: Colors.white,
        iconSize: 48,
        title: const Text(
          "Pick an Icon for your password",
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

  final MainController _mainController = Get.put(MainController());

  void _addPassword() async {
    if (_formKey.currentState!.validate()) {
      int time = DateTime.now().millisecondsSinceEpoch;
      Password password = Password(
          site: _siteController.text,
          auth: _authController.text,
          password: _passwordController.text,
          categoryId: selectedCategory!.id!,
          createdAt: time,
          updatedAt: time,
          icon: iconData);

      _mainController.addPassword(password);

      _authController.clear();
      _siteController.clear();
      _passwordController.clear();

      // You can add additional logic like showing a confirmation dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: _mainController.categories.isEmpty
            ? const Center(
          child: Text("Add a category first",
            style: TextStyle(
              fontFamily: 'ocr-a',
              fontSize: 28,
            ),),
        )
            : Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Add a new Password",
              style: TextStyle(
                fontFamily: 'ocr-a',
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 25,
            ),

            CustomInputField(
              controller: _siteController,
              label: "Site / App",
              iconData: FontAwesomeIcons.mobile,
            ),
            const SizedBox(height: 20),
            CustomInputField(
              controller: _authController,
              label: "Auth : email , phone ...",
              iconData: FontAwesomeIcons.idCard,
            ),
            const SizedBox(height: 20),
            CustomInputField(
              controller: _passwordController,
              label: "password",
              iconData: FontAwesomeIcons.lock,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select a Category",
                      style: TextStyle(
                        fontFamily: 'ocr-a',
                        fontSize: 18,
                      ),
                    ),
                    DropdownButton(
                      icon: Icon(selectedCategory!.icon,color: Color(ColorUtils.hexToInt(selectedCategory!.color)),),
                      hint: const Text("Select a cat"),
                      value: selectedCategory,
                      onChanged: (Category? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                      },
                      items: _mainController.categories.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.name),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListTile(
              title: const Text('Select an Icon for you password',
                style: TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 14,
                ),),
              trailing: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  iconData,
                  color: Color(ColorUtils.hexToInt(selectedCategory!.color)),
                  size: 33,
                ),
              ),
              onTap: _pickIcon,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPassword,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Get.put(RootController()).secondaryColor.value), // Set the background color
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(color: Colors.white),
                ), // Set the padding
              ),
              child: const Text(
                'Save Password',
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
