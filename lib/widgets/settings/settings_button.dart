import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';
import '../../helper/helper.dart' show ColorPallet, screenWidth;
import '../../controllers/database_controller.dart';

class SettingsButton extends StatelessWidget with ColorPallet {
  final String text;
  final Function() onPressed;
  final IconData icon;
  SettingsButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});
  DatabaseController databaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.centerLeft,
        width: screenWidth(context) * 0.9,
        height: 55,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: databaseController.settings.foregroundColor!.value,
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            children: [
              const SizedBox(width: 20),
              Text(
                text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(child: Container()),
              Icon(
                icon,
                color: blurWhite,
                size: icon == FontAwesome.shirt ? 20 : 30,
              ),
              const SizedBox(width: 15),
            ],
          ),
        ),
      ),
    );
  }
}
