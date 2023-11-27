import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilities/utilities.dart' show ColorPallet;
import '../../controllers/ui_controller.dart';

class ColorTheme extends StatefulWidget {
  final int index;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color mezmurColor;
  final String title;
  const ColorTheme({
    super.key,
    required this.index,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.title,
    required this.mezmurColor,
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
                  backgroundColor: widget.backgroundColor,
                  mezmurColor: widget.mezmurColor,
                );
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: uiController.selectedColorTheme.value == widget.index
                        ? mezmurScreenColor.withOpacity(0.7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30)),
                child: AnimatedContainer(
                  width: uiController.selectedColorTheme.value == widget.index
                      ? 56
                      : 55,
                  height: uiController.selectedColorTheme.value == widget.index
                      ? 56
                      : 55,
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
                      Expanded(
                        child: Container(color: widget.mezmurColor),
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
