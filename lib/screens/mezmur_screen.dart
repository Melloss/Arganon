import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/helper.dart'
    show Constants, ColorPallet, screenHeight, screenWidth;
import '../models/mezmurs.dart';
import '../controllers/mezmur_controller.dart';

class MezmurScreen extends StatefulWidget {
  final int index;
  const MezmurScreen({super.key, required this.index});

  @override
  State<MezmurScreen> createState() => _MezmurScreenState();
}

class _MezmurScreenState extends State<MezmurScreen>
    with Constants, ColorPallet {
  MezmurController mezmurController = Get.find();
  bool showAudioController = true;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      Hero(
        tag: 'mezmur${widget.index}',
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage(mezmurs[widget.index]['image']),
            fit: BoxFit.cover,
          )),
        ),
      ),
      _buildBackgroundOverlay(),
      _buildMezmurLyrics(),
      Positioned(
        top: 30,
        left: 0,
        child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
      ),
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
          ])),
    );
  }

  _buildMezmurLyrics() {
    return Positioned(
        bottom: 0,
        child: SizedBox(
          width: screenWidth(context) * 0.9,
          height: screenHeight(context) * 0.7,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      mezmurs[widget.index]['lyrics'],
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ]),
              ),
              Expanded(
                  flex: showAudioController ? 3 : 0,
                  child: _buildMuzmurAudioController())
            ],
          ),
        ));
  }

  _buildAllControllers() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onVerticalDragStart: (detail) {
          setState(() {
            showAudioController = false;
          });
        },
        onDoubleTap: () {
          setState(() {
            showAudioController = false;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
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
                value: 0.1,
                onChanged: (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('00:00',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 11,
                          )),
                  Text('05:00',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 11,
                          )),
                ],
              ),
              Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 30,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.download)),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle
                              : Icons.play_circle_fill,
                          size: 45,
                        )),
                  ),
                  Positioned(
                    top: 0,
                    right: 30,
                    child: Obx(
                      () => IconButton(
                          onPressed: () {
                            mezmurController.toggleFavorite(widget.index);
                            setState(() {
                              mezmurController.favoriteMezmurIndexs =
                                  mezmurController.favoriteMezmurIndexs;
                            });
                          },
                          icon: Icon(
                            mezmurs[widget.index]['isFavorite']
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
