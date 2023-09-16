import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/helper.dart' show ColorPallet, Constants;
import '../controllers/mezmur_controller.dart';
import '../widgets/widgets.dart' show MezmurTile;

class CatagoryListDisplay extends StatefulWidget {
  const CatagoryListDisplay({super.key});

  @override
  State<CatagoryListDisplay> createState() => _CatagoryListDisplayState();
}

class _CatagoryListDisplayState extends State<CatagoryListDisplay>
    with ColorPallet, Constants {
  MezmurController mezmurControllers = Get.find();
  late List mezmurs;
  late String catagory;
  @override
  void initState() {
    catagory = Get.arguments;
    mezmurs = mezmurControllers.getMezmur(catagory);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: blurWhite,
            ),
          ),
          const SizedBox(height: 20),
          _buildCatagoryList(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  _buildCatagoryList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: mezmurs.length,
          itemBuilder: ((context, index) {
            return Obx(
              () => MezmurTile(
                image: mezmurControllers.mezmurList[mezmurs[index]].image,
                title: mezmurControllers.mezmurList[mezmurs[index]].title,
                subtitle: mezmurControllers.getSubtitle(mezmurs[index]),
                isFavorite: mezmurControllers
                    .mezmurList[mezmurs[index]].isFavorite.value,
                index: mezmurs[index],
                from: fromCatagory,
                catagory: catagory,
              ),
            );
          }),
        ),
      ),
    );
  }
}
