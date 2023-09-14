import 'package:arganon/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/mezmurs.dart';
import '../widgets/widgets.dart' show MezmurTile;
import '../controllers/mezmur_controller.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> with Constants {
  MezmurController mezmurController = Get.find();
  @override
  Widget build(BuildContext context) {
    return mezmurController.favoriteMezmurIndexs.isEmpty
        ? Center(
            child: Text(
              'Favorite is Empty',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: ListView.builder(
              itemCount: mezmurController.favoriteMezmurIndexs.length,
              itemBuilder: ((context, index) {
                return MezmurTile(
                  key: Key(index.toString()),
                  image: mezmurs[mezmurController.favoriteMezmurIndexs[index]]
                      ['image'],
                  index: mezmurController.favoriteMezmurIndexs[index],
                  isFavorite:
                      mezmurs[mezmurController.favoriteMezmurIndexs[index]]
                          ['isFavorite'],
                  title: mezmurs[mezmurController.favoriteMezmurIndexs[index]]
                      ['title'],
                  subtitle:
                      mezmurs[mezmurController.favoriteMezmurIndexs[index]]
                          ['title'],
                  fromFavoriteTab: true,
                );
              }),
            ),
          );
  }
}
