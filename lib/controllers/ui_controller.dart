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

  void setThemeColor(
      {required Color? foregroundColor,
      required Color? backgroundColor,
      required Color? mezmurColor}) async {
    const forgrounColorSettings = 'forgroundColorSettings';
    const backgroundColorSettings = 'backgroundColorSettings';
    const mezmurColorSettings = 'mezmurColorSettings';
    DatabaseController databaseController = Get.find();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        forgrounColorSettings, foregroundColor!.value.toRadixString(16));
    preferences.setString(
        backgroundColorSettings, backgroundColor!.value.toRadixString(16));
    preferences.setString(
        mezmurColorSettings, mezmurColor!.value.toRadixString(16));
    databaseController.settings.foregroundColor!.value = foregroundColor;
    databaseController.settings.backgroundColor!.value = backgroundColor;
    databaseController.settings.mezmurColor!.value = mezmurColor;
  }
}
