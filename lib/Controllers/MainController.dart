import 'dart:async';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/password_generator.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Core/Functions/utilities.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
import 'package:password_manager/Models/CardModel.dart';
import 'package:password_manager/Models/CategoryModel.dart';
import 'package:password_manager/Models/PasswordModel.dart';
import 'package:password_manager/core/Database/DatabaseHelper.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class MainController extends GetxController {

  PanelController panelController = PanelController();

  final secretKey = enc.Key.fromUtf8('sakuraHarunoChannaroUchihaSasuke');

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  RxList<Category> categories = <Category>[].obs;

  RxList<Password> passwords = <Password>[].obs;

  RxList<CardModel> cards = <CardModel>[].obs;

  RxInt currentTab = 0.obs;


  RxString generatedPassword = RxString("Click to generate");

  RxInt addMode = 0
      .obs; // 0 for categories , 1 for passwords , 2 for cards // 3 for details of password (Cards will be done later)

  RxInt filterMode = 1.obs; //to tell if user is now filtering between password

  RxString filterQuery = "".obs;

  PageController pageController = PageController();

  Rx<Password> selectedPassword = Password(
          site: "site",
          auth: "auth",
          password: "password",
          categoryId: 0,
          createdAt: 0,
          updatedAt: 0,
          icon: Icons.add)
      .obs;

  @override
  void onReady() {
    super.onReady();
    getAllCategories();
    getAllPasswords();
    getAllCards();
  }

  void updateSelectedPassword(Password p) {
    selectedPassword.value = p;
    refresh();
  }

  int filterPasswordLength() {
    return passwords
        .where((p0) =>
            p0.site.toLowerCase().contains(filterQuery.value.toLowerCase()) ||
            p0.auth.toLowerCase().contains(filterQuery.value.toLowerCase()))
        .length;
  }

  RxList<Password> filterPassword() {
    return RxList(passwords
        .where((p0) =>
            p0.site.toLowerCase().contains(filterQuery.value.toLowerCase()) ||
            p0.auth.toLowerCase().contains(filterQuery.value.toLowerCase()))
        .toList());
  }

  void changeTab(int index) {
    RootController r = Get.put(RootController());
    if (r.isProfileVisible.value) {
      r.toggleProfileVisibility();
    }
    currentTab.value = index;
    pageController.animateToPage(index,
        duration: 600.milliseconds, curve: Curves.easeInCubic);
  }

  void changeAddMode(int mode) {
    addMode.value = mode;
  }

  //getters
  void getAllCategories() {
    categories.clear();
    _databaseHelper.queryAll("Categories").then((value) {
      for (Map<String, dynamic> c in value) {
        categories.add(Category.fromJson(c));
      }
    });
  }

  void getAllCards() {
    cards.clear();
    _databaseHelper.queryAll("Cards").then((value) {
      for (Map<String, dynamic> c in value) {
        cards.add(CardModel.fromJson(c));
      }
    });
  }

  void getAllPasswords() {
    _databaseHelper.queryAll("Passwords").then((value) {
      for (Map<String, dynamic> c in value) {
        passwords.add(Password.fromJson(c));
      }

      passwords.sort(
          (Password p1, Password p2) => p2.createdAt.compareTo(p1.createdAt));
    });
  }

  //adders
  void addCategory(Category c) {
    _databaseHelper.insert(c.toJson(), "Categories").then((value) {
      if (value != -1) {
        c.id = value;
        categories.add(c);
        panelController.close();
        Get.snackbar(
          "Success",
          "Category added successfully",
          backgroundColor: Colours.lokiGold,
          overlayBlur: 2,
          colorText: Colors.white,
        );
      }
    });
  }

  void addPassword(Password p) {
    final plainText = p.password;


    final b64key =enc.Key.fromUtf8(base64Url.encode(secretKey.bytes).substring(0,32));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = enc.Fernet(b64key);
    final encrypter = enc.Encrypter(fernet);

    final encrypted = encrypter.encrypt(plainText);
    final decrypted = encrypter.decrypt(encrypted);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted.base64); // random cipher text

    p.password = encrypted.base64;



    _databaseHelper.insert(p.toJson(), "Passwords").then((value) {
      if (value != -1) {
        p.id = value;
        passwords.insert(0, p);
        passwords.refresh();
        panelController.close();
        Get.snackbar(
          "Success",
          "Password added successfully",
          backgroundColor: Colours.lokiGold,
          overlayBlur: 2,
          colorText: Colors.white,
        );
      }
    });
  }

  String decryptedPassword(String t){


    final b64key =enc.Key.fromUtf8(base64Url.encode(secretKey.bytes).substring(0,32));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = enc.Fernet(b64key);
    final encrypter = enc.Encrypter(fernet);


    final decrypted = encrypter.decrypt64(t);

    return decrypted;

  }

  void addCard(CardModel c) {
    _databaseHelper.insert(c.toJson(), "Cards").then((value) {
      if (value != -1) {
        c.id = value;
        cards.insert(0, c);
        cards.refresh();
        panelController.close();
        Get.snackbar(
          "Success",
          "Card added successfully",
          backgroundColor: Colours.lokiGold,
          overlayBlur: 2,
          colorText: Colors.white,
        );
      }
    });
  }

  void deleteCategory(BuildContext context, int? id) {
    Utilities.showAlert(context,
        title: 'Deleting Category',
        desc: 'Are you sure you want to delete this category ?',
        type: DialogType.warning, onOkPressed: () {
      _databaseHelper
          .delete("Categories", where: 'id=?', whereArgs: [id]).then((value) {
        if (value != 0) {
          categories.removeWhere((element) => element.id == id);
          Get.back();
          Get.snackbar(
            "Success",
            "Category deleted successfully",
            backgroundColor: Colours.lokiGold,
            overlayBlur: 2,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Error",
            "Cannot delete category. Might have related passwords !",
            backgroundColor: Colors.red,
            overlayBlur: 2,
            colorText: Colors.white,
          );
        }
      });
    });
  }

  void deleteCard(BuildContext context, int? id) {
    Utilities.showAlert(context,
        title: 'Deleting Card',
        desc: 'Are you sure you want to delete this card ?',
        type: DialogType.warning, onOkPressed: () {
      _databaseHelper
          .delete("Cards", where: 'id=?', whereArgs: [id]).then((value) {
        if (value != 0) {
          cards.removeWhere((element) => element.id == id);
          Get.back();
          Timer(const Duration(milliseconds: 400), () {
            Get.snackbar(
              "Success",
              "Card has been deleted successfully",
              backgroundColor: Colours.lokiGold,
              overlayBlur: 2,
              colorText: Colors.white,
            );
          });
        } else {
          Get.snackbar(
            "Error",
            "Cannot delete Card !",
            backgroundColor: Colors.red,
            overlayBlur: 2,
            colorText: Colors.white,
          );
        }
      });
    });
  }

  void deletePassword(BuildContext context, int? id) {
    Utilities.showAlert(context,
        title: 'Deleting Password',
        desc: 'Are you sure you want to delete this password ?',
        type: DialogType.warning, onOkPressed: () {
      _databaseHelper
          .delete("Passwords", where: 'id=?', whereArgs: [id]).then((value) {
        if (value != 0) {
          passwords.removeWhere((element) => element.id == id);
          Get.back();
          Timer(const Duration(milliseconds: 400), () {
            Get.snackbar(
              "Success",
              "Password has been deleted successfully",
              backgroundColor: Colours.lokiGold,
              overlayBlur: 2,
              colorText: Colors.white,
            );
          });
        } else {
          Get.snackbar(
            "Error",
            "Cannot delete password !",
            backgroundColor: Colors.red,
            overlayBlur: 2,
            colorText: Colors.white,
          );
        }
      });
    });
  }

  RxDouble sliderValue = 12.0.obs;

  RxBool hasNumerical = false.obs;
  RxBool hasUppercase = false.obs;
  RxBool hasLowercase = true.obs;
  RxBool hasCharacter = false.obs;

  void generatePassword(){
          final passwordGenerator = PasswordGenerator(
            length: sliderValue.value.round(),
            hasCapitalLetters: hasUppercase.value,
            hasNumbers: hasNumerical.value,
            hasSmallLetters: hasLowercase.value,
            hasSymbols: hasCharacter.value,
          );
            generatedPassword.value = passwordGenerator.generatePassword();

  }

  void updatePasswordAuth(BuildContext context , Password p){
    TextEditingController authController = TextEditingController(text:p.auth );
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: Get.isDarkMode ? null : Colors.white,
      animType: AnimType.scale,
      body: Padding(padding : const EdgeInsets.all(9),child: Column(
        children: [
          const Text("Change Auth",style: TextStyle(fontSize: 24),),
          const SizedBox(height: 10,),
          CustomInputField(
            label: "Auth",
            controller: authController,
            iconData: Icons.person,
          )
        ],
      ),),
      btnCancelOnPress: () {
        Get.back();
      },
      btnOkOnPress: () {
       int updateTime = DateTime.now().millisecondsSinceEpoch;
       Map <String,dynamic> updates ={
         "auth" : authController.text,
         'updated_at': updateTime,

       };
        _databaseHelper.update(
            updates, "Passwords", where: 'id=?', whereArgs: [p.id]).then((value) {
              if(value!=0){
                p.auth = authController.text;
                p.updatedAt =updateTime;
                passwords.firstWhere((element) => p.id==element.id).auth = authController.text;
                passwords.firstWhere((element) => p.id==element.id).updatedAt = updateTime;
                selectedPassword.value = p;
                selectedPassword.refresh();
                passwords.refresh();
                Timer(const Duration(milliseconds: 400), () {
                  Get.snackbar(
                    "Success",
                    "Password's Auth has been successfully updated",
                    backgroundColor: Colours.lokiGold,
                    overlayBlur: 2,
                    colorText: Colors.white,
                  );
                });
              }
        });
        // userUsername.value =  userNameController.text;
        // _localStore.write("username", userNameController.text);
      },
    ).show();
  }
}
