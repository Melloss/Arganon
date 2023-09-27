import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/helper.dart' show ColorPallet, screenWidth;

class SettingsButton extends StatelessWidget with ColorPallet {
  final String text;
  final Function onPressed;
  SettingsButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: screenWidth(context) * 0.95,
      height: 55,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: foregroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Row(
          children: [
            const SizedBox(width: 20),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(child: Container()),
            Icon(
              Icons.keyboard_arrow_right,
              color: blurWhite,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
