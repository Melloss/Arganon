import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart' show PageController, Color;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './database_controller.dart';

class UIController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  final flipCardController = FlipCardController();
  RxInt selectedColorTheme = 0.obs;
  // Color foregroundColor = const Color(0xFF37718E);
  // Color backgruondColor = const Color(0xFF254E70);

  void setThemeColor({Color? foregroundColor, Color? backgroundColor}) async {
    const forgrounColorSettings = 'forgroundColorSettings';
    const backgroundColorSettings = 'backgroundColorSettings';
    DatabaseController databaseController = Get.find();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        forgrounColorSettings, foregroundColor!.value.toRadixString(16));
    preferences.setString(
        backgroundColorSettings, backgroundColor!.value.toRadixString(16));
    databaseController.settings.foregroundColor!.value = foregroundColor;
    databaseController.settings.backgroundColor!.value = backgroundColor;
  }
}
