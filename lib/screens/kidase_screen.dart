import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart' show KidaseTitle, KidaseContent;
import '../helper/helper.dart' show ColorPallet, Constants, screenHeight;
import '../controllers/database_controller.dart';

class KidaseScreen extends StatefulWidget {
  final List<Map<String, dynamic>> kidaseList;
  const KidaseScreen({super.key, required this.kidaseList});

  @override
  State<KidaseScreen> createState() => _KidaseScreenState();
}

class _KidaseScreenState extends State<KidaseScreen>
    with ColorPallet, Constants {
  DatabaseController databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage(kidaseImage),
              fit: BoxFit.cover,
            )),
          ),
          _buildBackgroundOverlay(),
          _buildKidase(),
          Positioned(
              top: 40,
              left: 0,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              )),
        ],
      ),
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
            databaseController.settings.mezmurColor!.value.withOpacity(0),
            databaseController.settings.mezmurColor!.value.withOpacity(0.1),
            databaseController.settings.mezmurColor!.value.withOpacity(0.2),
            databaseController.settings.mezmurColor!.value.withOpacity(0.3),
            databaseController.settings.mezmurColor!.value.withOpacity(0.6),
            databaseController.settings.mezmurColor!.value.withOpacity(0.7),
            databaseController.settings.mezmurColor!.value.withOpacity(0.8),
            databaseController.settings.mezmurColor!.value.withOpacity(0.85),
            databaseController.settings.mezmurColor!.value.withOpacity(0.93),
            databaseController.settings.mezmurColor!.value.withOpacity(0.95),
            databaseController.settings.mezmurColor!.value.withOpacity(0.95),
            databaseController.settings.mezmurColor!.value.withOpacity(0.95),
            databaseController.settings.mezmurColor!.value.withOpacity(0.98),
            databaseController.settings.mezmurColor!.value.withOpacity(1),
            databaseController.settings.mezmurColor!.value.withOpacity(1),
            databaseController.settings.mezmurColor!.value.withOpacity(1),
          ])),
    );
  }

  _buildKidase() {
    return SizedBox(
      height: screenHeight(context) * 0.7,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          itemCount: widget.kidaseList.length,
          itemBuilder: (context, index) {
            if (widget.kidaseList[index].containsKey('title')) {
              return KidaseTitle(title: widget.kidaseList[index]['title']);
            } else {
              return KidaseContent(
                content: widget.kidaseList[index]['content'],
                fileId: widget.kidaseList[index]['fileId'],
                whoShouldSay: widget.kidaseList[index]['whoShouldSay'],
                meaning: widget.kidaseList[index]['meaning'],
                isAmharic:
                    widget.kidaseList[index].containsKey('isAmharic') == true
                        ? true
                        : false,
              );
            }
          }),
    );
  }
}
