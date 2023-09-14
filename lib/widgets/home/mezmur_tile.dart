import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/helper.dart' show ColorPallet, screenWidth, Constants;
import '../../models/mezmurs.dart';
import '../../controllers/mezmur_controller.dart';
import '../../screens/mezmur_screen.dart';

class MezmurTile extends StatefulWidget {
  String image;
  String title;
  String subtitle;
  bool isFavorite;
  bool fromFavoriteTab;
  int index;
  MezmurTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isFavorite,
    required this.index,
    this.fromFavoriteTab = false,
  });

  @override
  State<MezmurTile> createState() => _MezmurTileState();
}

class _MezmurTileState extends State<MezmurTile> with ColorPallet, Constants {
  MezmurController mezmurController = Get.find();

  @override
  Widget build(BuildContext context) {
    return widget.fromFavoriteTab
        ? AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            duration: const Duration(milliseconds: 500),
            child: mezmurs[widget.index]['isFavorite']
                ? _buildTile()
                : const SizedBox.shrink(),
          )
        : _buildTile();
  }

  _buildTile() {
    return InkWell(
      onTap: () {
        Get.to(
          () => const MezmurScreen(),
          arguments: [widget.index],
          transition: Transition.topLevel,
          duration: const Duration(milliseconds: 500),
          opaque: true,
        );

        //Get.toNamed(mezmurScreen, arguments: [widget.index]);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: screenWidth(context),
        height: 70,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              foregroundColor,
              foregroundColor.withOpacity(0.8),
            ]),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                color: Colors.black12,
              )
            ]),
        child: ListTile(
          leading: Hero(
            transitionOnUserGestures: true,
            tag: 'mezmur${widget.index}',
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          contentPadding:
              const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 5),
          title:
              Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
          subtitle: Text(
            widget.subtitle,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          dense: true,
          selected: true,
          splashColor: blurWhite,
          trailing: Obx(
            () => IconButton(
              onPressed: () {
                if (widget.fromFavoriteTab == false) {
                  mezmurController.toggleFavorite(widget.index);
                } else {
                  mezmurController.toggleFavorite(widget.index);
                  setState(() {
                    mezmurController.favoriteMezmurIndexs =
                        mezmurController.favoriteMezmurIndexs;
                  });
                  //mezmurController.favoriteMezmurIndexs.remove(widget.index);
                }
              },
              icon: Icon(
                mezmurController.mezmurList[widget.index]['isFavorite']
                    ? Icons.favorite
                    : Icons.favorite_outline,
                color: blurWhite.withOpacity(0.8),
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
