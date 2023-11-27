import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/utilities.dart'
    show ColorPallet, screenWidth, Constants;
import '../../controllers/mezmur_controller.dart';
import '../../screens/mezmur_screen_scroller.dart';
import '../../controllers/database_controller.dart';

// ignore: must_be_immutable
class MezmurTile extends StatefulWidget {
  String image;
  String title;
  String subtitle;
  bool isFavorite;
  String from;
  int index;
  String catagory;

  MezmurTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.isFavorite,
    required this.index,
    this.from = 'fromHome',
    this.catagory = '',
  });

  @override
  State<MezmurTile> createState() => _MezmurTileState();
}

class _MezmurTileState extends State<MezmurTile> with ColorPallet, Constants {
  MezmurController mezmurController = Get.find();
  DatabaseController databaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    return widget.from == fromFavorite
        ? AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            duration: const Duration(milliseconds: 500),
            child: mezmurController.mezmurList[widget.index].isFavorite.value
                ? _buildTile()
                : const SizedBox.shrink(),
          )
        : _buildTile();
  }

  _buildTile() {
    return InkWell(
      onTap: () {
        Get.to(
          () => MezmurScreenScroller(
              from: widget.from, currentIndex: widget.index),
          arguments: widget.catagory,
          transition: Transition.topLevel,
          duration: const Duration(milliseconds: 500),
        );

        //Get.toNamed(mezmurScreen, arguments: [widget.index]);
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 7),
        width: screenWidth(context),
        height: 65,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              databaseController.settings.foregroundColor!.value,
              databaseController.settings.foregroundColor!.value
                  .withOpacity(0.8),
            ]),
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: Colors.black12,
              )
            ]),
        child: Stack(
          children: [
            ListTile(
              leading: Hero(
                transitionOnUserGestures: true,
                tag: 'mezmur${widget.index}',
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              contentPadding:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
              title: Text(widget.title,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              dense: true,
              selected: true,
              splashColor: blurWhite,
              trailing: IconButton(
                onPressed: () async {
                  if (widget.from != fromFavorite) {
                    mezmurController.toggleFavorite(widget.index);
                    await databaseController.updateMezmur(widget.index);
                  } else {
                    mezmurController.toggleFavorite(widget.index);
                    await databaseController.updateMezmur(widget.index);
                    setState(() {
                      mezmurController.favoriteMezmurIndexs =
                          mezmurController.favoriteMezmurIndexs;
                    });
                    //mezmurController.favoriteMezmurIndexs.remove(widget.index);
                  }
                },
                icon: Obx(
                  () => Icon(
                    mezmurController.mezmurList[widget.index].isFavorite.value
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color: blurWhite.withOpacity(0.8),
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Obx(
                () => Visibility(
                  visible:
                      !mezmurController.mezmurList[widget.index].isSeen.value,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: blurWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
