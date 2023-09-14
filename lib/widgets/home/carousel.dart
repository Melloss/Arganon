import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../helper/helper.dart' show ColorPallet;
import '../../controllers/mezmur_controller.dart';
import '../../screens/mezmur_screen.dart';

class Carousel extends StatefulWidget {
  final Set mezmurs;
  const Carousel({super.key, required this.mezmurs});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with ColorPallet {
  final carouselController = CarouselController();
  MezmurController mezmurController = Get.find();
  int currentIndex = 0;
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';

  List mezmurTitles = [];
  @override
  void initState() {
    image1 = mezmurController.mezmurList[widget.mezmurs.elementAt(0)]['image'];
    image2 = mezmurController.mezmurList[widget.mezmurs.elementAt(1)]['image'];
    image3 = mezmurController.mezmurList[widget.mezmurs.elementAt(2)]['image'];
    image4 = mezmurController.mezmurList[widget.mezmurs.elementAt(3)]['image'];
    image5 = mezmurController.mezmurList[widget.mezmurs.elementAt(4)]['image'];
    mezmurTitles = [
      mezmurController.mezmurList[widget.mezmurs.elementAt(0)]['title'],
      mezmurController.mezmurList[widget.mezmurs.elementAt(1)]['title'],
      mezmurController.mezmurList[widget.mezmurs.elementAt(2)]['title'],
      mezmurController.mezmurList[widget.mezmurs.elementAt(3)]['title'],
      mezmurController.mezmurList[widget.mezmurs.elementAt(4)]['title'],
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => const MezmurScreen(),
              arguments: [widget.mezmurs.elementAt(currentIndex)],
              transition: Transition.topLevel,
              duration: const Duration(milliseconds: 500),
              opaque: true,
            );
          },
          child: CarouselSlider(
            carouselController: carouselController,
            items: [
              _buildSlider(image1),
              _buildSlider(image2),
              _buildSlider(image3),
              _buildSlider(image4),
              _buildSlider(image5),
            ],
            options: CarouselOptions(
                viewportFraction: 0.7,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
          ),
        ),
        _buildSliderBullets(),
      ],
    );
  }

  _buildSlider(String path) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              path,
              width: 300,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          mezmurTitles[currentIndex],
          style: TextStyle(
            color: blurWhite,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  _buildSliderBullets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBullet(0),
        _buildBullet(1),
        _buildBullet(2),
        _buildBullet(3),
        _buildBullet(4),
      ],
    );
  }

  _buildBullet(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color:
            index == currentIndex ? blurWhite.withOpacity(0.7) : Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}