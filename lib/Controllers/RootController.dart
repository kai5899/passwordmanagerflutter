import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/Core/Colors/Colours.dart';
import 'package:password_manager/Core/Colors/Themes.dart';
import 'package:password_manager/Elements/Widgets/CustomInputField.dart';
class RootController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GetStorage _localStore = GetStorage();

  bool get isFirstTime => _localStore.read('firstTime') ?? true;

  String get passcode => _localStore.read('passcode') ?? "";

  String get username => _localStore.read("username") ?? "User";

  Rx<Color> primaryColor = Rx(Colours.lokiGold);

  Rx<Color> secondaryColor = Rx(Colours.lokiGold);

  RxString userUsername = "".obs;
  RxString userEmail = "".obs;

  //to Control the profile animation
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<Offset> slideAnimationForBody;
  late Animation<double> animationIcon;
  late Animation<double> fadeAnimation;


  RxBool isProfileVisible = false.obs;

  @override
  void onInit() {
    super.onInit();

    primaryColor.value = Color(ColorUtils.hexToInt(
        _localStore.read("primaryColor") ?? Colours.lokiDarkGreen.hex));
    isDarkMode.value = _localStore.read('isDarkMode') ?? false;

    // isColoredAppBar.value = _localStore.read("isColoredAppBar") ?? false;


    userUsername.value = username;
    userEmail.value = _localStore.read("userEmail") ?? "no email saved";

    //animation initialization
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    slideAnimationForBody = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.9),
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    animationIcon = Tween<double>(
      begin:0,
      end: 1
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));    fadeAnimation = Tween<double>(
      begin:1,
      end: 0
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
  }

  // Color get primaryColor => Color(ColorUtils.hexToInt(
  //     _localStore.read("primaryColor") ?? Colours.lokiDarkGreen.hex));

  // Color get secondaryColor =>
  //     _localStore.read("secondaryColor") ?? Colours.lokiGold;

  RxBool isDarkMode = false.obs;

  // RxBool isColoredAppBar = false.obs;

/*  void toggleColoredAppBar() {
    isColoredAppBar.value = !isColoredAppBar.value;
    _localStore.write('isColoredAppBar', isColoredAppBar.value);
  }*/

  void setUsername(BuildContext context) {
    TextEditingController userNameController = TextEditingController(text:userUsername.value );
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: isDarkMode.value ? null : Colors.white,
      animType: AnimType.scale,
      body: Column(
        children: [
          const Text("Change username",style: TextStyle(fontSize: 24),),
          const SizedBox(height: 10,),
          CustomInputField(
            label: "username",
            controller: userNameController,
            iconData: Icons.person,
          )
        ],
      ),
      btnCancelOnPress: () {
        Get.back();
      },
      btnOkOnPress: () {
        userUsername.value =  userNameController.text;
        _localStore.write("username", userNameController.text);
      },
    ).show();
  }

  void setEmail(BuildContext context) {
    TextEditingController emailController = TextEditingController(text:userEmail.value );
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: isDarkMode.value ? null : Colors.white,
      animType: AnimType.scale,
      body: Column(
        children: [
          const Text("Change Email",style: TextStyle(fontSize: 24),),
          const SizedBox(height: 10,),
          CustomInputField(
            label: "Email",
            controller: emailController,
            iconData: FontAwesomeIcons.mailBulk,
          )
        ],
      ),
      btnCancelOnPress: () {
        Get.back();
      },
      btnOkOnPress: () {
        userEmail.value =  emailController.text;
        _localStore.write("userEmail", emailController.text);
      },
    ).show();
  }

  void toggleTheme() {

    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? AppTheme.dark : AppTheme.light,
    );
    _localStore.write('isDarkMode', isDarkMode.value);
  }

  void setColor(String key, int mode, Color c) {
    if (mode == 0) {
      primaryColor.value = c;
      primaryColor.refresh();
    } else {
      secondaryColor.value = c;
      secondaryColor.refresh();
    }

    _localStore.write(key, c.hex);
  }

  void setToDefault(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      dialogBackgroundColor: isDarkMode.value ? null : Colors.white,
      animType: AnimType.scale,
      title: 'Default Colors',
      desc:
          'Are you sure about this?It will reset the app to its default color settings',
      btnCancelOnPress: () {
        Get.back();
      },
      btnOkOnPress: () {
        setColor("primaryColor", 0, Colours.lokiDarkGreen);
        setColor("secondaryColor", 1, Colours.lokiGold);
      },
    ).show();
  }

  //toggle animation
  void toggleProfileVisibility() {
    bool isRunning =  animationController.status == AnimationStatus.forward || animationController.status == AnimationStatus.reverse;
    if(!isRunning){
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse().then((value) {
          isProfileVisible.value = !isProfileVisible.value;
        });
      } else {
        isProfileVisible.value = !isProfileVisible.value;
        animationController.forward();
      }
    }
  }


}
