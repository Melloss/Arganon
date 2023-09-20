import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/helper.dart'
    show Constants, ColorPallet, screenHeight, screenWidth;
import '../controllers/mezmur_controller.dart';
import '../controllers/database_controller.dart';
import '../controllers/ui_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class MezmurScreen extends StatefulWidget {
  final int index;
  const MezmurScreen({super.key, required this.index});

  @override
  State<MezmurScreen> createState() => _MezmurScreenState();
}

class _MezmurScreenState extends State<MezmurScreen>
    with Constants, ColorPallet {
  MezmurController mezmurController = Get.find();
  UIController uiController = Get.find();
  DatabaseController databaseController = Get.find();
  bool showAudioController = true;
  bool showSliderThumb = false;
  late String urlPath;

  @override
  void initState() {
    urlPath = mezmurController
        .getUrlAddress(mezmurController.mezmurList[widget.index].fileId);

    mezmurController.player.onPositionChanged.listen((Duration position) {
      if (mounted) {
        setState(() {
          mezmurController.mezmurPosition = position;
        });
      }
    });

    mezmurController.player.onDurationChanged.listen((Duration? duration) {
      if (mounted) {
        setState(() {
          mezmurController.mezmurDuration = duration!;
        });
      }
    });
    mezmurController.player.onPlayerComplete.listen((event) async {
      await mezmurController.player.stop();
      if (mounted) {
        setState(() {
          mezmurController.isPlaying.value = false;
          mezmurController.mezmurDuration = const Duration(seconds: 0);
          mezmurController.mezmurPosition = const Duration(seconds: 0);
        });
      }
    });

    print(mezmurController.currentPlayingMezmurIndex);

    super.initState();
  }

  @override
  void dispose() {
    // mezmurController.dispose();
    super.dispose();
  }

  void playButtonHandler() async {
    if (widget.index != mezmurController.currentPlayingMezmurIndex) {
      //await mezmurController.player.stop();
      await mezmurController.player.release();

      print('another mezmur is playing ');
    }
    try {
      mezmurController.currentPlayingMezmurIndex = widget.index;
      if (mezmurController.isPlaying.value) {
        if (mounted) {
          mezmurController.isPlaying.value = false;
        }
        await mezmurController.player.pause();
      } else {
        if (mounted) {
          mezmurController.isPlaying.value = true;
        }
        await mezmurController.player.setSourceUrl(urlPath);
        await mezmurController.player.play(UrlSource(urlPath));
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      Obx(
        () => Hero(
          tag: uiController.currentPage.value == widget.index
              ? 'mezmur${widget.index}'
              : '${widget.index}',
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.topCenter,
              image:
                  AssetImage(mezmurController.mezmurList[widget.index].image),
              fit: BoxFit.cover,
            )),
          ),
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
                      mezmurController.mezmurList[widget.index].lyrics,
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
          if (mounted) {
            setState(() {
              showAudioController = false;
            });
          }
        },
        onDoubleTap: () {
          if (mounted) {
            setState(() {
              showAudioController = false;
            });
          }
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
              SliderTheme(
                data: Theme.of(context).sliderTheme.copyWith(
                    thumbShape: showSliderThumb == true
                        ? null
                        : SliderComponentShape.noThumb),
                child: Slider(
                  onChangeStart: (positon) {
                    if (mounted) {
                      setState(() {
                        showSliderThumb = true;
                      });
                    }
                  },
                  onChangeEnd: (p) {
                    if (mounted) {
                      setState(() {
                        showSliderThumb = false;
                      });
                    }
                  },
                  value:
                      mezmurController.currentPlayingMezmurIndex == widget.index
                          ? mezmurController.mezmurPosition.inSeconds.toDouble()
                          : 0.0,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        Duration newDuration = Duration(seconds: value.toInt());
                        mezmurController.player.seek(newDuration);
                      });
                    }
                  },
                  min: 0.0,
                  max:
                      mezmurController.currentPlayingMezmurIndex == widget.index
                          ? mezmurController.mezmurDuration.inSeconds.toDouble()
                          : 0.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                      mezmurController.currentPlayingMezmurIndex == widget.index
                          ? mezmurController.mezmurPosition
                              .toString()
                              .split(".")[0]
                          : '0:00:00',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 11,
                          )),
                  Text(
                      mezmurController.currentPlayingMezmurIndex == widget.index
                          ? mezmurController.mezmurDuration
                              .toString()
                              .split(".")[0]
                          : '0:00:00',
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
                        onPressed: playButtonHandler,
                        icon: Obx(
                          () => Icon(
                            mezmurController.isPlaying.value &&
                                    widget.index ==
                                        mezmurController
                                            .currentPlayingMezmurIndex
                                ? Icons.pause_circle
                                : Icons.play_circle_fill,
                            size: 45,
                          ),
                        )),
                  ),
                  Positioned(
                      top: 0,
                      right: 30,
                      child: IconButton(
                        onPressed: () async {
                          mezmurController.toggleFavorite(widget.index);
                          await databaseController.updateMezmur(widget.index);
                          if (mounted) {
                            setState(() {
                              mezmurController.favoriteMezmurIndexs =
                                  mezmurController.favoriteMezmurIndexs;
                            });
                          }
                        },
                        icon: Icon(
                          mezmurController
                                  .mezmurList[widget.index].isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_outline,
                        ),
                      )),
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
          if (mounted) {
            setState(() {
              showAudioController = true;
            });
          }
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
