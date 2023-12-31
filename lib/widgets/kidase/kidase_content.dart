import 'package:arganon/controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../controllers/mezmur_controller.dart';
import '../../utilities/utilities.dart' show ColorPallet, screenWidth;

class KidaseContent extends StatefulWidget {
  final String content;
  final String meaning;
  final String whoShouldSay;
  final String fileId;

  const KidaseContent({
    super.key,
    required this.content,
    required this.meaning,
    required this.whoShouldSay,
    required this.fileId,
  });

  @override
  State<KidaseContent> createState() => _KidaseContentState();
}

class _KidaseContentState extends State<KidaseContent> with ColorPallet {
  MezmurController mezmurController = Get.find();
  DatabaseController databaseController = Get.find();
  bool isPlaying = false;
  bool showSliderThumb = false;

  playButtonHandler() async {
    if (mezmurController.currentPlayingKidaseFileId.value != widget.fileId) {
      setState(() {
        isPlaying = false;
      });
    }
    mezmurController.currentPlayingKidaseFileId.value = widget.fileId;
    if (databaseController.settings.makeKidaseAudioLoop == true) {
      await mezmurController.player.setReleaseMode(ReleaseMode.loop);
    } else {
      await mezmurController.player.setReleaseMode(ReleaseMode.release);
    }

    if (isPlaying == false) {
      await mezmurController.player.play(
        AssetSource(
          'kidase/${widget.fileId}.mp3',
        ),
      );
      setState(() {
        isPlaying = true;
      });

      mezmurController.isPlaying.value = true;
    } else {
      await mezmurController.player.pause();
      setState(() {
        isPlaying = false;
      });
      mezmurController.isPlaying.value = false;
    }
  }

  @override
  void initState() {
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
      if (mezmurController.player.releaseMode == ReleaseMode.release) {
        await mezmurController.player.stop();
        if (mounted) {
          setState(() {
            mezmurController.mezmurDuration = Duration.zero;
            mezmurController.mezmurPosition = Duration.zero;
            isPlaying = false;
          });
        }
        mezmurController.isPlaying.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 10, bottom: 33, top: 5, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.75,
                child: RichText(
                    text: TextSpan(
                        text: widget.whoShouldSay == ''
                            ? ''
                            : '${widget.whoShouldSay}፦ ',
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 15,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                        children: [
                      TextSpan(
                        text: widget.content,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                      ),
                    ])),
              ),
              Expanded(
                child: Visibility(
                  visible: widget.meaning != '' && widget.fileId.isNotEmpty,
                  child: IconButton(
                    onPressed: playButtonHandler,
                    icon: Obx(
                      () => Icon(
                        mezmurController.currentPlayingKidaseFileId.value ==
                                    widget.fileId &&
                                isPlaying == true
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: mezmurController.currentPlayingKidaseFileId.value ==
                      widget.fileId &&
                  isPlaying == true,
              child: SliderTheme(
                data: Theme.of(context).sliderTheme.copyWith(
                    trackShape: const RoundedRectSliderTrackShape(),
                    trackHeight: 2,
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
                  max: mezmurController.mezmurDuration.inSeconds.toDouble(),
                  value: mezmurController.mezmurPosition.inSeconds.toDouble(),
                  onChanged: (value) async {
                    Duration newDuration = Duration(seconds: value.toInt());
                    await mezmurController.player.seek(newDuration);
                  },
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.meaning.isNotEmpty,
            child: ExpansionTile(
              tilePadding: EdgeInsets.zero,
              collapsedTextColor: Colors.lime,
              textColor: Colors.limeAccent,
              title: const Text('ትርጉም'),
              iconColor: Colors.limeAccent,
              collapsedIconColor: Colors.lime,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: screenWidth(context) * 0.75,
                    child: Text(
                      widget.meaning,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 17,
                            color: Colors.limeAccent,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
