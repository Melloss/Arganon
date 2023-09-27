import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart' show PageController;
import 'package:get/get.dart';

class UIController extends GetxController {
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  final flipCardController = FlipCardController();
}
