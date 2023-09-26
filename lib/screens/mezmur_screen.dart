import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../helper/helper.dart'
    show Constants, ColorPallet, screenHeight, screenWidth;
import '../controllers/mezmur_controller.dart';
import '../controllers/database_controller.dart';
import '../controllers/ui_controller.dart';

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
  bool isDownloading = false;
  bool fromFile = false;
  late String urlPath;
  double downloadProgress = 0.0;

  void setupSeenProperty() {
    if (mezmurController.mezmurList[widget.index].isSeen.value == false) {
      mezmurController.mezmurList[widget.index].isSeen.value = true;
      databaseController.updateMezmur(widget.index);
    }
  }

  @override
  void initState() {
    //check whether this mezmur exist or not
    checkMezmurExist();
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
          mezmurController.mezmurDuration = const Duration(seconds: 0);
          mezmurController.mezmurPosition = const Duration(seconds: 0);
        });
      }
      mezmurController.isPlaying.value = false;
      mezmurController.showPlayerController.value = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    // mezmurController.dispose();
    super.dispose();
  }

  checkMezmurExist() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String path = '${appDocumentsDir.path}/${widget.index}.mp3';
    if (await File(path).exists()) {
      setState(() {
        fromFile = true;
      });
    } else {
      setState(() {
        fromFile = false;
      });
    }
  }

  removeNewMezmurCatagory() {
    if (mezmurController.mezmurList[widget.index].catagory
            .contains(adadisMezmursCatagory) &&
        mezmurController.mezmurList[widget.index].isSeen.value == true) {
      List temp = [];
      for (int i = 0;
          i < mezmurController.mezmurList[widget.index].catagory.length;
          i++) {
        if (mezmurController.mezmurList[widget.index].catagory[i] !=
            adadisMezmursCatagory) {
          temp.add(mezmurController.mezmurList[widget.index].catagory[i]);
        }
      }
      mezmurController.mezmurList[widget.index].catagory = temp;
      databaseController.updateMezmur(widget.index);
    }
  }

  Future<void> downloadMezmur() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.ethernet) {
        setState(() {
          isDownloading = true;
        });
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();

        String path = '${appDocumentsDir.path}/${widget.index}.mp3';

        final dio = Dio();
        await dio.download(
          urlPath,
          path,
          onReceiveProgress: (receivedBytes, totalBytes) {
            final progress = (receivedBytes / totalBytes) * 100;
            if (mounted) {
              setState(() {
                downloadProgress = progress;
              });
            }
          },
          deleteOnError: true,
        );
        setState(() {
          isDownloading = false;
          fromFile = true;
        });
      } else {
        Get.snackbar(
          'No Internet',
          'በመጀመሪያ ኢንተርኔት ያብሩ',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: blurWhite,
          colorText: backgroudColor,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        );
      }
    } catch (error) {
      print('from dowload $error');
    }
  }

  void playButtonHandler() async {
    try {
      removeNewMezmurCatagory();
      if (widget.index != mezmurController.currentPlayingMezmurIndex) {
        //await mezmurController.player.stop();
        await mezmurController.player.release();
      }
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
        if (fromFile == true) {
          final Directory appDocumentsDir =
              await getApplicationDocumentsDirectory();

          String path = '${appDocumentsDir.path}/${widget.index}.mp3';

          await mezmurController.player.play(DeviceFileSource(path));
        } else {
          final connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.mobile ||
              connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.ethernet) {
            await mezmurController.player.play(UrlSource(urlPath));
            await mezmurController.player.setSourceUrl(urlPath);
          } else {
            Get.snackbar(
              'No Internet',
              'በመጀመሪያ ኢንተርኔት ያብሩ',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: blurWhite,
              colorText: backgroudColor,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            );
          }
        }
        mezmurController.showPlayerController.value = true;
      }
    } catch (error) {
      print(error);
      await mezmurController.player.stop();
      if (mounted) {
        setState(() {
          mezmurController.mezmurDuration = const Duration(seconds: 0);
          mezmurController.mezmurPosition = const Duration(seconds: 0);
        });
      }
      mezmurController.isPlaying.value = false;
      mezmurController.showPlayerController.value = false;
    }
    setupSeenProperty();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        if (isDownloading == true) {
          Get.dialog(AlertDialog(
            content: Text(
              'መዝሙሩ እየወረደ ነው እንዲቋረጥ ይፈልጋሉ?',
              style: TextStyle(
                color: backgroudColor,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final Directory appDocumentsDir =
                        await getApplicationDocumentsDirectory();

                    String path = '${appDocumentsDir.path}/${widget.index}.mp3';
                    File file = File(path);

                    if (file.existsSync()) {
                      file.deleteSync();
                      print('deleted');
                    }
                    await Get.offAllNamed(homeScreen);
                  },
                  child: const Text(
                    'አዎ',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'አይ ይውረድ',
                    style: TextStyle(
                      color: backgroudColor,
                    ),
                  ))
            ],
          ));
        }
        return true;
      }),
      child: Scaffold(
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
          top: 40,
          left: 0,
          child: IconButton(
            onPressed: () {
              if (isDownloading == true) {
                Get.dialog(AlertDialog(
                  title: Text(
                    'መዝሙር እየወረደ ነው',
                    style: TextStyle(
                      color: backgroudColor,
                    ),
                  ),
                  content: Text(
                    'እንዲቋረጥ ይፈልጋሉ?',
                    style: TextStyle(
                      color: backgroudColor,
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          final Directory appDocumentsDir =
                              await getApplicationDocumentsDirectory();

                          String path =
                              '${appDocumentsDir.path}/${widget.index}.mp3';

                          if (await File(path).exists()) {
                            await File(path).delete();
                          }
                          Get.offAllNamed(homeScreen);
                        },
                        child: const Text('አዎ')),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('አይ ይውረድ'))
                  ],
                ));
              } else {
                Get.back();
              }
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
          ),
        ),
      ])),
    );
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
                      '${mezmurController.mezmurList[widget.index].lyrics}\n',
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
                  value: mezmurController.mezmurPosition.inSeconds.toDouble() ==
                          0.0
                      ? 0.0
                      : mezmurController.currentPlayingMezmurIndex ==
                              widget.index
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isDownloading
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SpinKitWave(
                                color: blurWhite,
                                size: 20,
                                duration: const Duration(seconds: 1),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${downloadProgress.toPrecision(0).toInt()}%',
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        )
                      : fromFile == true
                          ? const Icon(Icons.file_download_done_outlined)
                          : IconButton(
                              onPressed: downloadMezmur,
                              icon: const Icon(
                                Icons.download,
                                size: 30,
                              )),
                  IconButton(
                      onPressed: playButtonHandler,
                      icon: Obx(
                        () => Icon(
                          mezmurController.isPlaying.value &&
                                  widget.index ==
                                      mezmurController.currentPlayingMezmurIndex
                              ? Icons.pause_circle
                              : Icons.play_circle_fill,
                          size: 45,
                        ),
                      )),
                  IconButton(
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
                      mezmurController.mezmurList[widget.index].isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 30,
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
