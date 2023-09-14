import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/helper.dart'
    show Constants, ColorPallet, screenHeight, screenWidth;
import '../models/mezmurs.dart';
import '../controllers/mezmur_controller.dart';

class MezmurScreen extends StatefulWidget {
  const MezmurScreen({super.key});

  @override
  State<MezmurScreen> createState() => _MezmurScreenState();
}

class _MezmurScreenState extends State<MezmurScreen>
    with Constants, ColorPallet {
  MezmurController mezmurController = Get.find();
  bool showAudioController = true;
  bool isPlaying = false;
  late int index;

  @override
  void initState() {
    index = Get.arguments[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      Hero(
        tag: 'mezmur$index',
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(mezmurs[index]['image']),
            fit: BoxFit.cover,
          )),
        ),
      ),
      _buildBackgroundOverlay(),
      _buildMezmurLyrics(),
    ]));
  }

  _buildMuzmurAudioController() {
    return AnimatedSwitcher(
      switchInCurve: Curves.bounceOut,
      switchOutCurve: Curves.linear,
      transitionBuilder: (child, animation) {
        return SizeTransition(sizeFactor: animation, child: child);
      },
      duration: const Duration(milliseconds: 700),
      child: showAudioController
          ? _buildAllControllers()
          : _buildShowControllers(),
    );
  }

  _buildBackgroundOverlay() {
    return Container(
        height: screenHeight(context),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              mezmurScreenColor.withOpacity(0),
              mezmurScreenColor.withOpacity(0.1),
              mezmurScreenColor.withOpacity(0.2),
              mezmurScreenColor.withOpacity(0.3),
              mezmurScreenColor.withOpacity(0.6),
              mezmurScreenColor.withOpacity(0.7),
              mezmurScreenColor.withOpacity(0.8),
              mezmurScreenColor.withOpacity(0.85),
              mezmurScreenColor.withOpacity(0.93),
              mezmurScreenColor.withOpacity(0.95),
              mezmurScreenColor.withOpacity(0.95),
              mezmurScreenColor.withOpacity(0.95),
              mezmurScreenColor.withOpacity(0.98),
              mezmurScreenColor.withOpacity(1),
              mezmurScreenColor.withOpacity(1),
              mezmurScreenColor.withOpacity(1),
            ])));
  }

  _buildMezmurLyrics() {
    return Positioned(
        bottom: 0,
        child: SizedBox(
          width: screenWidth(context),
          height: screenHeight(context) * 0.7,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      mezmurs[index]['lyrics'],
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ]),
              ),
              Expanded(
                  flex: showAudioController ? 2 : 0,
                  child: _buildMuzmurAudioController())
            ],
          ),
        ));
  }

  _buildAllControllers() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onDoubleTap: () {
          setState(() {
            showAudioController = false;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: screenWidth(context) * 0.9,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: mezmurScreenColor.withOpacity(0.5),
              )
            ],
            color: backgroudColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Slider(
                value: 0.5,
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('00:00', style: Theme.of(context).textTheme.titleSmall),
                  Text('05:00', style: Theme.of(context).textTheme.titleSmall),
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_previous)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isPlaying = !isPlaying;
                              });
                            },
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 35,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.skip_next)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 30,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.download)),
                  ),
                  Positioned(
                    top: 10,
                    right: 30,
                    child: Obx(
                      () => IconButton(
                          onPressed: () {
                            mezmurController.toggleFavorite(index);
                            setState(() {
                              mezmurController.favoriteMezmurIndexs =
                                  mezmurController.favoriteMezmurIndexs;
                            });
                          },
                          icon: Icon(
                            mezmurs[index]['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_outline,
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildShowControllers() {
    return Center(
      child: InkWell(
        onTap: () {
          setState(() {
            showAudioController = true;
          });
        },
        child: Container(
          width: 70,
          height: 25,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroudColor,
            boxShadow: [
              BoxShadow(
                  blurStyle: BlurStyle.outer,
                  blurRadius: 3,
                  spreadRadius: 1,
                  color: backgroudColor.withOpacity(0.3))
            ],
          ),
          child: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: blurWhite,
          ),
        ),
      ),
    );
  }
}
