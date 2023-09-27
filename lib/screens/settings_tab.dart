import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/widgets.dart' show SettingsButton;
import '../helper/helper.dart' show ColorPallet, screenWidth;
import '../screens/about_screen.dart';
import '../controllers/ui_controller.dart';
import '../controllers/database_controller.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> with ColorPallet {
  UIController uiController = Get.find();
  DatabaseController databaseController = Get.find();
  String sampleMezmur = '''እኔስ በምግባሬ ደካማ ሆኛለሁ /2/
እዘኝልኝ ድንግል እለምንሻለሁ /2/

    ያንን የእሳት ባህር እንዳላይ አደራ
    ድረሽልኝ ድንግል ስምሽን ስጠራ /2/

የዳዊት መሰንቆ የእስራኤል መና
የናሆም መድሃኒት ንኢ በደመና /2/
    ''';

  bool showCarousel = true;
  bool showSampleMezmur = false;

  resetHandler() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(databaseController.showCarouselSettings, true);
    await preferences.setDouble(
        databaseController.mezmurLyricsFontSizeSettings, 19);
    setState(() {
      databaseController.settings.mezmurLyricsFontSize = 19;
      databaseController.settings.showCarousel = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      side: CardSide.FRONT,
      flipOnTouch: false,
      controller: uiController.flipCardController,
      front: Column(
        children: [
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: resetHandler,
                  icon: const Icon(
                    Icons.restore,
                    size: 25,
                  )),
            ),
          ),
          SettingsButton(
            text: 'የመተግበሪያውን ልብስ ቀይር',
            onPressed: () async {
              //TODO:
            },
            icon: FontAwesome.shirt,
          ),
          _buildShowCarouselSettings(),
          const SizedBox(height: 30),
          _buildMezmurLyricsFontSizeSettings(),
          Expanded(child: Container()),
          Visibility(
            visible: showSampleMezmur,
            child: Container(
              width: screenWidth(context) * 0.95,
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: Text(
                sampleMezmur,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize:
                          databaseController.settings.mezmurLyricsFontSize,
                    ),
              ),
            ),
          ),
          Expanded(child: Container()),
          SettingsButton(
            text: 'ስለ',
            onPressed: () async {
              await uiController.flipCardController.toggleCard();
            },
            icon: Bootstrap.info,
          ),
        ],
      ),
      back: AboutScreen(),
    );
  }

  _buildShowCarouselSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            'ስላይደር (Carousel) ይኑረው',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                ),
          ),
          Expanded(child: Container()),
          Switch(
              inactiveThumbColor: mezmurScreenColor.withOpacity(0.4),
              activeColor: blurWhite,
              trackColor: MaterialStatePropertyAll(foregroundColor),
              value: databaseController.settings.showCarousel!,
              onChanged: (value) async {
                final preferences = await SharedPreferences.getInstance();
                await preferences.setBool(
                    databaseController.showCarouselSettings, value!);
                databaseController.settings.showCarousel =
                    !databaseController.settings.showCarousel!;

                setState(() {
                  databaseController.settings.showCarousel;
                });
              })
        ],
      ),
    );
  }

  _buildMezmurLyricsFontSizeSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'የመዝሙር ግጥም የፊደል መጠን',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    onChangeStart: (value) {
                      setState(() {
                        showSampleMezmur = true;
                      });
                    },
                    onChangeEnd: ((value) {
                      setState(() {
                        showSampleMezmur = false;
                      });
                    }),
                    value: databaseController.settings.mezmurLyricsFontSize!,
                    min: 12,
                    max: 26,
                    onChanged: (value) async {
                      final preferences = await SharedPreferences.getInstance();
                      await preferences.setDouble(
                          databaseController.mezmurLyricsFontSizeSettings,
                          value);
                      setState(() {
                        databaseController.settings.mezmurLyricsFontSize =
                            value;
                      });
                    },
                  ),
                  Text(
                      databaseController.settings.mezmurLyricsFontSize!
                          .round()
                          .toString(),
                      style: Theme.of(context).textTheme.titleSmall)
                ]),
          ],
        ),
      ),
    );
  }
}
