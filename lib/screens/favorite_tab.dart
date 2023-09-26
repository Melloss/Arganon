import 'package:arganon/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              'የተመረጠ መዝሙር የለም',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: ListView.builder(
              itemCount: mezmurController.favoriteMezmurIndexs.length,
              itemBuilder: ((context, index) {
                return MezmurTile(
                  image: mezmurController
                      .mezmurList[mezmurController.favoriteMezmurIndexs[index]]
                      .image,
                  index: mezmurController.favoriteMezmurIndexs[index],
                  isFavorite: mezmurController
                      .mezmurList[mezmurController.favoriteMezmurIndexs[index]]
                      .isFavorite
                      .value,
                  title: mezmurController
                      .mezmurList[mezmurController.favoriteMezmurIndexs[index]]
                      .title,
                  subtitle: mezmurController.getSubtitle(
                      mezmurController.favoriteMezmurIndexs[index]),
                  from: fromFavorite,
                );
              }),
            ),
          );
  }
}
