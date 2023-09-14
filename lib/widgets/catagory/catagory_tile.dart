import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/helper.dart' show Constants;

class CatagoryTile extends StatelessWidget with Constants {
  final String name;
  final String path;
  final String catagoryName;
  final Alignment alignment;
  CatagoryTile({
    super.key,
    required this.path,
    required this.name,
    this.alignment = Alignment.topCenter,
    required this.catagoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Get.toNamed(catagoryListDisplayScreen, arguments: catagoryName);
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 130,
              height: 80,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    alignment: alignment,
                    image: AssetImage(path),
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
