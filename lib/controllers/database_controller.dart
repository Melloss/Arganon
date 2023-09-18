import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import './mezmur_controller.dart';
import '../helper/helper.dart' show ColorPallet;
import '../models/mezmurs.dart' show Mezmur, initMezmurs;
import '../models/mezmurs_file_id.dart' show fileUniqueAddress;

class DatabaseController extends GetxController with ColorPallet {
  MezmurController mezmurController = Get.find();
  late Database db;
  init() async {
    final path = join(await getDatabasesPath(), 'ArganonMezmurs.db');
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
            catagory TEXT NOT NULL
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
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      final response = await databaseReference.child('mezmurs').get();

      Map<dynamic, dynamic> snapShot =
          Map<dynamic, dynamic>.from(response.value as Map<dynamic, dynamic>);
      int newMezmurs = 0;
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
          );
          mezmurController.mezmurList.add(m);
          mezmurController.createCatagories();
          addMezmur(snapShot[key]['id']);
          print(snapShot[key]['title'] + 'added');
          newMezmurs++;
        }
      });

      if (newMezmurs > 0) {
        Get.snackbar(
          'Success',
          '$newMezmurs Mezmur Added Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: blurWhite,
          colorText: backgroudColor,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        );
      } else {
        Get.snackbar(
          'No New',
          'There is no new Mezmur added',
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
}
