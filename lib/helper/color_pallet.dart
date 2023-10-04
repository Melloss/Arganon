import 'package:flutter/material.dart' show Color;
import 'package:get/get.dart';
import '../controllers/database_controller.dart';

DatabaseController databaseController = Get.find();
mixin ColorPallet {
  Color backgroudColor =
      const Color(0xFF254E70); //databaseController.settings.backgroundColor!;
  Color foregroundColor =
      const Color(0xFF37718E); //databaseController.settings.foregroundColor!;
  final blurWhite = const Color(0xFFD9D9D9);
  Color mezmurScreenColor = const Color(0xFF063645);
}
