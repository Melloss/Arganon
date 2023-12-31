import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './mezmur_controller.dart';
import '../utilities/utilities.dart' show ColorPallet;
import '../models/mezmurs.dart' show Mezmur, initMezmurs;
import '../models/mezmurs_file_id.dart' show fileUniqueAddress;
import '../models/settings.dart';

class DatabaseController extends GetxController with ColorPallet {
  MezmurController mezmurController = Get.find();
  late Database db;
  init() async {
    await initSettings();
    final path = join(await getDatabasesPath(), '5.db');
    try {
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (newdb, version) async {
          await newdb.execute('''
          CREATE TABLE mezmurs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            lyrics TEXT NOT NULL,
            image TEXT NOT NULL,
            isFavorite BOOL NOT NULL,
            catagory TEXT NOT NULL,
            isSeen BOOL NOT NULL
          )
        ''');
          List<Mezmur> mezmurList = initMezmurs();
          //This is where all mezmurs are added for the first time
          for (int i = 0; i < mezmurList.length; i++) {
            await newdb.insert('mezmurs', {
              'title': mezmurList[i].title,
              'lyrics': mezmurList[i].lyrics,
              'image': mezmurList[i].image,
              'isFavorite': mezmurList[i].isFavorite.value == true ? 1 : 0,
              'catagory': mezmurList[i].catagory.join(','),
              'isSeen': mezmurList[i].isSeen.value == true ? 1 : 0,
            });
          }
        },
        onOpen: (db) async {
          List<Map<String, dynamic>> rowData = await db.query('mezmurs');

          List<Mezmur> mezmursList = [];
          for (int i = 0; i < rowData.length; i++) {
            //inorder to get liked mezmurs from the database
            if (rowData[i]['isFavorite'] == 1) {
              mezmurController.favoriteMezmurIndexs.add(rowData[i]['id'] - 1);
            }

            //to initialized mezmurList list
            String catagory = rowData[i]['catagory'];
            mezmursList.add(
              Mezmur(
                id: rowData[i]['id'] - 1,
                title: rowData[i]['title'],
                lyrics: rowData[i]['lyrics'],
                catagory: catagory.split(','),
                image: rowData[i]['image'],
                isFavorite:
                    rowData[i]['isFavorite'] == 1 ? true.obs : false.obs,
                fileId: fileUniqueAddress[i],
                isSeen: rowData[i]['isSeen'] == 1 ? true.obs : false.obs,
              ),
            );
          }

          mezmurController.mezmurList = mezmursList;
        },
      );
    } catch (error) {
      print(error);
    }
  }

  updateMezmur(int index) async {
    try {
      int rowAffect = await db.update(
          'mezmurs',
          {
            'id': index + 1,
            'title': mezmurController.mezmurList[index].title,
            'lyrics': mezmurController.mezmurList[index].lyrics,
            'image': mezmurController.mezmurList[index].image,
            'isFavorite':
                mezmurController.mezmurList[index].isFavorite.value == true
                    ? 1
                    : 0,
            'catagory': mezmurController.mezmurList[index].catagory.join(','),
            'isSeen':
                mezmurController.mezmurList[index].isSeen.value == true ? 1 : 0,
          },
          where: 'id = ?',
          whereArgs: [index + 1]);
      print('rowAffect $rowAffect');
    } catch (error) {
      print(error);
    }
  }

  addMezmur(int i) async {
    int rowAffect = await db.insert('mezmurs', {
      'title': mezmurController.mezmurList[i].title,
      'lyrics': mezmurController.mezmurList[i].lyrics,
      'image': mezmurController.mezmurList[i].image,
      'isFavorite':
          mezmurController.mezmurList[i].isFavorite.value == true ? 1 : 0,
      'catagory': mezmurController.mezmurList[i].catagory.join(','),
      'isSeen': mezmurController.mezmurList[i].isSeen.value == true ? 1 : 0,
    });
    print('row affect: $rowAffect');
  }

  bool isThisIdFound(int id) {
    for (int i = 0; i < mezmurController.mezmurList.length; i++) {
      if (id == mezmurController.mezmurList[i].id) {
        return true;
      }
    }
    return false;
  }

  fetchMezmurs() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.ethernet ||
          connectivityResult == ConnectivityResult.vpn) {
        DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
        final response = await databaseReference.child('mezmurs').get();

        int newMezmurs = 0;

        Map<dynamic, dynamic> snapShot =
            Map<dynamic, dynamic>.from(response.value as Map<dynamic, dynamic>);

        snapShot.forEach((key, value) {
          if (isThisIdFound(snapShot[key]['id']) == false) {
            Mezmur m = Mezmur(
              id: snapShot[key]['id'],
              title: snapShot[key]['title'],
              lyrics: snapShot[key]['lyrics'],
              image: snapShot[key]['image'],
              isFavorite: false.obs,
              catagory: snapShot[key]['catagory'],
              fileId: snapShot[key]['fileId'],
              isSeen: false.obs,
            );
            mezmurController.mezmurList.add(m);
            mezmurController.createCatagories();
            addMezmur(snapShot[key]['id']);
            newMezmurs++;
          }
        });

        if (newMezmurs > 0) {
          Get.snackbar(
            'Success',
            '$newMezmurs መዝሙር ተጨምሯል',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: blurWhite,
            colorText: backgroudColor,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          );
        } else {
          Get.snackbar(
            'No New',
            'አዲስ መዝሙር የለም',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: blurWhite,
            colorText: backgroudColor,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          );
        }
      } else {
        Get.snackbar(
          'No Internet',
          'በመጀመሪያ ኢንተርኔት ያብሩ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: blurWhite,
          colorText: backgroudColor,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  final String showCarouselSettings = 'ShowCarouselSettings';
  final String mezmurLyricsFontSizeSettings = 'MezmurLyricsFontSizeSettings';
  Settings settings =
      Settings(mezmurLyricsFontSize: 19, showCarousel: true, selectedTheme: 0);
  final String selectedThemeSettings = 'SelectedThemeSettings';
  final String forgrounColorSettings = 'forgroundColorSettings';
  final String backgroundColorSettings = 'backgroundColorSettings';
  final String mezmurColorSettings = 'mezmurColorSettings';
  final String makeKidaseAudioLoop = 'makeKidaseAudioLoop';

  initSettings() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(showCarouselSettings) &&
        !preferences.containsKey(mezmurLyricsFontSizeSettings) &&
        !preferences.containsKey(makeKidaseAudioLoop)) {
      preferences.setBool(showCarouselSettings, true);
      preferences.setBool(makeKidaseAudioLoop, true);
      preferences.setDouble(mezmurLyricsFontSizeSettings, 19);
      preferences.setInt(selectedThemeSettings, 0);
      preferences.setString(forgrounColorSettings,
          const Color(0xFF37718E).value.toRadixString(16));
      preferences.setString(backgroundColorSettings,
          const Color(0xFF254E70).value.toRadixString(16));
      preferences.setString(
          mezmurColorSettings, const Color(0xFF063645).value.toRadixString(16));
    }
    settings.mezmurLyricsFontSize =
        preferences.getDouble(mezmurLyricsFontSizeSettings);
    settings.showCarousel = preferences.getBool(showCarouselSettings);
    settings.makeKidaseAudioLoop = preferences.getBool(makeKidaseAudioLoop);
    settings.selectedTheme = preferences.getInt(selectedThemeSettings);
    int foregroundColorValue =
        int.parse(preferences.getString(forgrounColorSettings)!, radix: 16);
    settings.foregroundColor = Color(foregroundColorValue).obs;
    int backgroundColorValue =
        int.parse(preferences.getString(backgroundColorSettings)!, radix: 16);
    settings.backgroundColor = Color(backgroundColorValue).obs;
    int mezmurColorValue =
        int.parse(preferences.getString(mezmurColorSettings)!, radix: 16);
    settings.mezmurColor = Color(mezmurColorValue).obs;
  }
}
