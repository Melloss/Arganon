import 'package:flutter/material.dart' show Color;
import 'package:get/get.dart';

class Settings {
  double? mezmurLyricsFontSize;
  bool? showCarousel;
  int? selectedTheme;
  Rx<Color>? foregroundColor;
  Rx<Color>? backgroundColor;
  Rx<Color>? mezmurColor;
  Settings({
    required mezmurLyricsFontSize,
    required showCarousel,
    required selectedTheme,
  });
}
