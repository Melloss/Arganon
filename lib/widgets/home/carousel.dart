import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../helper/helper.dart' show ColorPallet;

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> with ColorPallet {
  final carouselController = CarouselController();

  int currentIndex = 0;
  List mezmurTitles = [
    'Simshin Terche',
    'Tekle Haymaot Tsehay',
    'Arsema Ney',
    'Aba Giorgis',
    'Emebetachin Kedej komalech'
  ];

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
            //Navigate To Mezmur Screen
          },
          child: CarouselSlider(
            carouselController: carouselController,
            items: [
              _buildSlider('assets/icons/dingle_maryam_1.jpg'),
              _buildSlider('assets/icons/abune_teklehaymanot.jpg'),
              _buildSlider('assets/icons/kidist_arsema.jpg'),
              _buildSlider('assets/icons/abune_giorgis.jpg'),
              _buildSlider('assets/icons/dingle_maryam_2.jpg'),
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
