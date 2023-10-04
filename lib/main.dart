import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import './screens/home_tab.dart';
import './helper/helper.dart' show ColorPallet, Constants, initControllers;
import './controllers/database_controller.dart';
import './screens/catagory_list_display.dart';
import './controllers/mezmur_controller.dart';
import './controllers/ui_controller.dart';
import './firebase_options.dart';

class Arganon extends StatefulWidget {
  const Arganon({super.key});

  @override
  State<Arganon> createState() => _ArganonState();
}

class _ArganonState extends State<Arganon> with ColorPallet, Constants {
  DatabaseController databaseController = Get.find();
  @override
  void initState() {
    backgroudColor = databaseController.settings.backgroundColor!.value;
    foregroundColor = databaseController.settings.foregroundColor!.value;
    super.initState();
  }

  @override
  void dispose() {
    databaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      initialRoute: homeScreen,
      routes: {
        homeScreen: (context) => const Home(),
        catagoryListDisplayScreen: (context) => const CatagoryListDisplay(),
      },
    );
  }

  _buildThemeData() {
    return ThemeData(
      primaryColor: backgroudColor,
      primarySwatch: Colors.teal,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroudColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: blurWhite,
        ),
        toolbarHeight: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: backgroudColor,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        fillColor: blurWhite,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: backgroudColor!,
            )),
        filled: true,
      ),
      scaffoldBackgroundColor: backgroudColor,
      textTheme: TextTheme(
          titleSmall: TextStyle(
            color: blurWhite.withOpacity(0.7),
            fontSize: 14,
          ),
          titleLarge: TextStyle(
            color: blurWhite,
            fontSize: 16.5,
          ),
          displayLarge: const TextStyle(
            color: Colors.white,
            fontSize: 19,
          )),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedTextColor: blurWhite.withOpacity(0.6),
        collapsedIconColor: blurWhite.withOpacity(0.6),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        iconColor: blurWhite,
        textColor: blurWhite,
        childrenPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.white.withOpacity(0.5),
        inactiveTrackColor: blurWhite.withOpacity(0.2),
        thumbColor: Colors.white.withOpacity(0.5),
        trackHeight: 4,
        trackShape: const RectangularSliderTrackShape(),
      ),
      iconTheme: IconThemeData(
        color: blurWhite.withOpacity(0.6),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initControllers();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initialize all controllers
  DatabaseController dbController = Get.find();
  MezmurController mezmurController = Get.find();
  UIController uiController = Get.find();
  await dbController.init();
  mezmurController.generateRandomMezmurs();
  mezmurController.createCatagories();
  dbController.dispose();

  uiController.dispose();

  runApp(const Arganon());
}
