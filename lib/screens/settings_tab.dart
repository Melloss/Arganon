import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/widgets.dart' show SettingsButton, ColorTheme;
import '../utilities/utilities.dart' show ColorPallet, screenWidth;
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
  bool showSampleKidase = false;

  resetHandler() async {
    const forgrounColorSettings = 'forgroundColorSettings';
    const backgroundColorSettings = 'backgroundColorSettings';
    const mezmurColorSettings = 'mezmurColorSettings';
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(databaseController.showCarouselSettings, true);
    await preferences.setDouble(
        databaseController.mezmurLyricsFontSizeSettings, 19);
    await preferences.setInt(databaseController.selectedThemeSettings, 0);
    preferences.setString(
        forgrounColorSettings, const Color(0xFF37718E).value.toRadixString(16));
    preferences.setString(backgroundColorSettings,
        const Color(0xFF254E70).value.toRadixString(16));
    preferences.setString(
        mezmurColorSettings, const Color(0xFF1D3557).value.toRadixString(16));
    setState(() {
      databaseController.settings.mezmurLyricsFontSize = 19;
      databaseController.settings.showCarousel = true;
      databaseController.settings.selectedTheme = 0;
    });
    uiController.selectedColorTheme.value = 0;
    databaseController.settings.backgroundColor!.value =
        const Color(0xFF254E70);
    databaseController.settings.foregroundColor!.value =
        const Color(0xFF37718E);
    databaseController.settings.mezmurColor!.value = const Color(0xFF1D3557);
  }

  @override
  void initState() {
    uiController.selectedColorTheme.value =
        databaseController.settings.selectedTheme!;
    super.initState();
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
              Get.dialog(
                AlertDialog(
                  actionsAlignment: MainAxisAlignment.center,
                  backgroundColor: blurWhite,
                  contentPadding: EdgeInsets.zero,
                  actionsPadding: EdgeInsets.zero,
                  content: Wrap(alignment: WrapAlignment.center, children: [
                    ColorTheme(
                      index: 0,
                      foregroundColor: foregroundColor,
                      backgroundColor: backgroudColor,
                      mezmurColor: mezmurScreenColor,
                      title: 'የተለመደ',
                    ),
                    const ColorTheme(
                      index: 1,
                      foregroundColor: Color(0XFF35A29F),
                      backgroundColor: Color(0xFF088395),
                      mezmurColor: Color(0xFF26577C),
                      title: 'ሎሚ',
                    ),
                    const ColorTheme(
                      index: 2,
                      foregroundColor: Color(0xFFAE445A),
                      backgroundColor: Color(0xFF662549),
                      mezmurColor: Color(0XFF451952),
                      title: 'ቀይ ስር',
                    ),
                    const ColorTheme(
                      index: 3,
                      foregroundColor: Color(0xFFA78295),
                      backgroundColor: Color(0xFF5C5470),
                      mezmurColor: Color(0xFF352F44),
                      title: 'ቡና',
                    ),
                    const ColorTheme(
                      index: 4,
                      foregroundColor: Color(0xFF526D82),
                      backgroundColor: Color(0XFF474E68),
                      mezmurColor: Color(0xFF404258),
                      title: 'ሽሮ',
                    ),
                    const ColorTheme(
                      index: 5,
                      foregroundColor: Color(0xFF7D7C7C),
                      backgroundColor: Color(0xFF393E46),
                      mezmurColor: Color(0xFF222831),
                      title: 'ማታ',
                    ),
                  ]),
                ),
              );
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
          Visibility(
            visible: !showSampleMezmur,
            child: SettingsButton(
              text: 'ስለ',
              onPressed: () async {
                await uiController.flipCardController.toggleCard();
              },
              icon: Bootstrap.info,
            ),
          ),
        ],
      ),
      back: AboutScreen(),
    );
  }

  _buildShowCarouselSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        children: [
          Text(
            'ስላይደር (Carousel) ይኑረው',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                ),
          ),
          Expanded(child: Container()),
          Obx(
            () => Switch(
                inactiveThumbColor: databaseController
                    .settings.mezmurColor!.value
                    .withOpacity(0.4),
                activeColor: blurWhite,
                trackColor: MaterialStatePropertyAll(
                  databaseController.settings.foregroundColor!.value,
                ),
                value: databaseController.settings.showCarousel!,
                onChanged: (value) async {
                  final preferences = await SharedPreferences.getInstance();
                  await preferences.setBool(
                      databaseController.showCarouselSettings, value);
                  databaseController.settings.showCarousel =
                      !databaseController.settings.showCarousel!;

                  setState(() {
                    databaseController.settings.showCarousel;
                  });
                }),
          )
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
