import 'package:arganon/models/mezmurs.dart';
import 'package:flutter/material.dart';
import '../screens/mezmur_screen.dart';
import 'package:get/get.dart';
import '../controllers/mezmur_controller.dart';
import '../helper/helper.dart' show Constants;

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
  late List mezmurs;
  late PageController pageController;

  @override
  void initState() {
    print(widget.currentIndex);
    if (widget.from == fromHome) {
      mezmurs = mezmurController.mezmurList;
    } else if (widget.from == fromFavorite) {
      mezmurs = mezmurController.favoriteMezmurIndexs;
    } else if (widget.from == fromCatagory) {
      String catagory = Get.arguments;
      print(catagory);
      mezmurs = mezmurController.getMezmur(catagory);
    }
    pageController = PageController(
        initialPage: widget.from == fromHome
            ? widget.currentIndex
            : mezmurs.indexOf(widget.currentIndex));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        allowImplicitScrolling: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: mezmurs.length,
        controller: pageController,
        itemBuilder: (context, index) {
          return MezmurScreen(
            index: widget.from == fromHome ? index : mezmurs[index],
          );
        });
  }
}
