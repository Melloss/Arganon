import 'package:flutter/material.dart';
import '../screens/mezmur_screen.dart';
import 'package:get/get.dart';
import '../controllers/mezmur_controller.dart';
import '../controllers/ui_controller.dart';
import '../utilities/utilities.dart' show Constants;

class MezmurScreenScroller extends StatefulWidget {
  final String from;
  final int currentIndex;
  const MezmurScreenScroller(
      {super.key, required this.from, required this.currentIndex});

  @override
  State<MezmurScreenScroller> createState() => _MezmurScreenScrollerState();
}

class _MezmurScreenScrollerState extends State<MezmurScreenScroller>
    with Constants {
  MezmurController mezmurController = Get.find();
  UIController uiController = Get.find();
  late List mezmurs;

  @override
  void initState() {
    if (widget.from == fromHome) {
      mezmurs = mezmurController.mezmurList;
    } else if (widget.from == fromFavorite) {
      mezmurs = mezmurController.favoriteMezmurIndexs;
    } else if (widget.from == fromCatagory) {
      String catagory = Get.arguments;

      mezmurs = mezmurController.getMezmur(catagory);
    }
    uiController.pageController = PageController(
        initialPage: widget.from == fromHome
            ? widget.currentIndex
            : mezmurs.indexOf(widget.currentIndex));
    uiController.currentPage.value = widget.from == fromHome
        ? widget.currentIndex
        : mezmurs.indexOf(widget.currentIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: (i) {
          uiController.currentPage.value = i;
        },
        allowImplicitScrolling: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: mezmurs.length,
        controller: uiController.pageController,
        itemBuilder: (context, index) {
          return MezmurScreen(
            index: widget.from == fromHome ? index : mezmurs[index],
          );
        });
  }
}
