import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/helper.dart' show ColorPallet;
import '../../controllers/ui_controller.dart';

class ColorTheme extends StatefulWidget {
  final int index;
  final Color foregroundColor;
  final Color backgroundColor;
  final String title;
  const ColorTheme({
    super.key,
    required this.index,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.title,
  });

  @override
  State<ColorTheme> createState() => _ColorThemeState();
}

class _ColorThemeState extends State<ColorTheme> with ColorPallet {
  UIController uiController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
      child: Obx(
        () => Column(
          children: [
            InkWell(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                uiController.selectedColorTheme.value = widget.index;
                await preferences.setInt('SelectedThemeSettings', widget.index);
                uiController.setThemeColor(
                    foregroundColor: widget.foregroundColor,
                    backgroundColor: widget.backgroundColor);
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: uiController.selectedColorTheme.value == widget.index
                        ? mezmurScreenColor.withOpacity(0.7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30)),
                child: AnimatedContainer(
                  width: uiController.selectedColorTheme.value == widget.index
                      ? 51
                      : 50,
                  height: uiController.selectedColorTheme.value == widget.index
                      ? 51
                      : 50,
                  duration: const Duration(microseconds: 700),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(children: [
                      Expanded(
                        child: Container(color: widget.foregroundColor),
                      ),
                      Expanded(
                        child: Container(color: widget.backgroundColor),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: uiController.selectedColorTheme.value == widget.index
                      ? mezmurScreenColor
                      : foregroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
