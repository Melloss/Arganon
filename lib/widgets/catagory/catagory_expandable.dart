import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './catagory_tile.dart';
import '../../helper/helper.dart' show ColorPallet;
import '../../controllers/database_controller.dart';

class CatagoryExpandable extends StatefulWidget {
  final String title;
  final List<CatagoryTile> children;
  const CatagoryExpandable(
      {super.key, required this.title, required this.children});

  @override
  State<CatagoryExpandable> createState() => _CatagoryExpandableState();
}

class _CatagoryExpandableState extends State<CatagoryExpandable>
    with ColorPallet {
  DatabaseController databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          databaseController.settings.foregroundColor!.value.withOpacity(0.8),
          databaseController.settings.foregroundColor!.value.withOpacity(0.6),
        ]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ExpansionTile(
          expandedCrossAxisAlignment: CrossAxisAlignment.center,
          controlAffinity: ListTileControlAffinity.platform,
          title: Text(widget.title,
              style: const TextStyle(
                fontSize: 15,
              )),
          children: [
            GridView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: widget.children,
            )
          ]),
    );
  }
}
