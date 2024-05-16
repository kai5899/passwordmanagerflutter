import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:password_manager/Controllers/RootController.dart';
import 'package:password_manager/Core/Colors/Themes.dart';
import 'package:password_manager/Views/root.dart';


void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Manager',
      theme: AppTheme.light,

      darkTheme: AppTheme.dark,
      themeMode: Get.put(RootController()).isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      home:  Root(),
    ));
  }
}


