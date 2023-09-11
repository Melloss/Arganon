import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_tab.dart';
import './helper/helper.dart' show ColorPallet;

class Arganon extends StatelessWidget with ColorPallet {
  Arganon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
      home: const Home(),
    );
  }

  _buildThemeData() {
    return ThemeData(
      primaryColor: backgroudColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroudColor,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        iconColor: backgroudColor,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        fillColor: blurWhite,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: backgroudColor, width: 3)),
        filled: true,
      ),
      scaffoldBackgroundColor: backgroudColor,
      textTheme: TextTheme(
        titleSmall: TextStyle(
          color: blurWhite.withOpacity(0.7),
          fontSize: 12,
        ),
        titleLarge: TextStyle(
          color: blurWhite,
          fontSize: 16,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        collapsedTextColor: blurWhite.withOpacity(0.6),
        collapsedIconColor: blurWhite.withOpacity(0.6),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        iconColor: blurWhite,
        textColor: blurWhite,
        childrenPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      ),
    );
  }
}

void main() {
  runApp(Arganon());
}
