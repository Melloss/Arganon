import 'package:flutter/material.dart';
import './catagory_tile.dart';
import '../../helper/helper.dart' show ColorPallet;

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
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: foregroundColor,
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
