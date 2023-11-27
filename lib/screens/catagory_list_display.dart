import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/utilities.dart' show ColorPallet, Constants;
import '../controllers/mezmur_controller.dart';
import '../widgets/widgets.dart' show MezmurTile;
import '../controllers/database_controller.dart';

class CatagoryListDisplay extends StatefulWidget {
  const CatagoryListDisplay({super.key});

  @override
  State<CatagoryListDisplay> createState() => _CatagoryListDisplayState();
}

class _CatagoryListDisplayState extends State<CatagoryListDisplay>
    with ColorPallet, Constants {
  MezmurController mezmurControllers = Get.find();
  DatabaseController databaseController = Get.find();
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
      backgroundColor: databaseController.settings.backgroundColor!.value,
      appBar: AppBar(
        backgroundColor: databaseController.settings.backgroundColor!.value,
      ),
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
          mezmurs.isEmpty
              ? Center(
                  child: Text(
                    'ለጊዜው በዚህ ምድብ ውስጥ መዝሙር የለም',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
              : _buildCatagoryList(),
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
