
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/utils/logger.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;


  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }

  Future<void> initializeThemeData() async {
    _darkTheme =  DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
   }

  ThemeData getDarkTheme(){
    return _darkTheme;
  }

  ThemeData getLightheme(){
    return _lightTheme;
  }

  void changeTheme() {
    AppLogger.i('Is Dark theme - ${Get.isDarkMode}');
    Get.changeTheme(Get.isDarkMode ? _lightTheme : _darkTheme);
  }
}
