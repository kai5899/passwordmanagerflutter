import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:password_manager/Controllers/MainController.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
import 'package:password_manager/Elements/Widgets/SquareButton.dart';
import 'package:password_manager/Models/CategoryModel.dart';
import 'package:password_manager/Models/PasswordModel.dart';
import 'package:password_manager/core/Colors/Colours.dart';

class DetailPasswordView extends StatefulWidget {
  const DetailPasswordView({Key? key}) : super(key: key);

  @override
  State<DetailPasswordView> createState() => _DetailPasswordViewState();
}

class _DetailPasswordViewState extends State<DetailPasswordView> {
  MainController mainController = Get.put(MainController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Password p = mainController.selectedPassword.value;
      Category c = mainController.categories
          .firstWhere((element) => element.id == p.categoryId);
      DateTime createdAt = DateTime.fromMillisecondsSinceEpoch(p.createdAt);
      DateTime updatedAt = DateTime.fromMillisecondsSinceEpoch(p.updatedAt);

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            //site app
            const Center(
              child: Text(
                "Password's Detail",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //category
            ListTile(
              title: const Text(
                "Category",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                c.name.capitalizeFirst!,
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                c.icon,
                size: 48,
                color: Color(ColorUtils.hexToInt(c.color)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //auth
            ListTile(
              title: const Text(
                "Site / App",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                p.site,
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
              trailing: Icon(
                p.icon,
                size: 48,
                color: Color(ColorUtils.hexToInt(c.color)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //auth
            ListTile(
              title: const Text(
                "Auth",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                p.auth,
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
              trailing: SquareButton(
                onPressed: () {
                 mainController.updatePasswordAuth(context, p);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //password
            ListTile(
              title: const Text(
                "Password",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mainController.decryptedPassword(p.password),
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
              trailing: SquareButton(
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text(
                "Created On",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${DateFormat.yMMMMd().format(createdAt)} at ${DateFormat.jm().format(createdAt)}",
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              title: const Text(
                "Updated On",
                style: TextStyle(
                    fontFamily: 'ocr-a',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${DateFormat.yMMMMd().format(updatedAt)} at ${DateFormat.jm().format(updatedAt)}",
                style: const TextStyle(
                  fontFamily: 'ocr-a',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
