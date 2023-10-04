import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../helper/helper.dart' show ColorPallet;
import '../controllers/ui_controller.dart';
import '../controllers/database_controller.dart';

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget with ColorPallet {
  AboutScreen({super.key});

  UIController uiController = Get.find();
  DatabaseController databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: databaseController.settings.backgroundColor!.value,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () async {
                  await uiController.flipCardController.toggleCard();
                },
                icon: const Icon(Icons.keyboard_arrow_left)),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'አርጋኖን መተግበሪያ',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 22,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ይህ መተግበሪያ የተሰራው በሚኪያስ ተካልኝ(ሜሎስ) ሲሆን\n አላማውም የኦርቶዶክስ ተዋህዶ ዝማሬዎችን እና ቅዳሴ \n በቀላሉ ለመማር እና ለማጥናት እንዲያስችል በማሰብ ነው።',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 16,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Text(
            'ለየትኛውም አይነት አስተያየት እና ሀሳብ በነዚ አድራሻዎች ያግኙኝ',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 15,
                ),
          ),
          const SizedBox(height: 10),
          _buildAddress(context, Bootstrap.phone, '+251917266009'),
          _buildAddress(
              context, Bootstrap.github, 'https://github.com/melloss'),
          _buildAddress(context, Bootstrap.google, 'mikiyaass@gmail.com'),
          _buildAddress(context, Bootstrap.linkedin,
              'https://www.linkedin.com/in/melloss'),
        ],
      ),
    );
  }

  _buildAddress(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          const SizedBox(width: 25),
          SelectableText(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 16,
                ),
          )
        ],
      ),
    );
  }
}
