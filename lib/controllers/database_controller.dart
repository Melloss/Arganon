import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import './mezmur_controller.dart';
import '../models/mezmurs.dart' show Mezmur, initMezmurs;
import '../models/mezmurs_file_id.dart' show fileUniqueAddress;

class DatabaseController extends GetxController {
  MezmurController mezmurController = Get.find();
  late Database db;
  init() async {
    final path = join('new', 'm4.db');
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
    print(index);
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
}
