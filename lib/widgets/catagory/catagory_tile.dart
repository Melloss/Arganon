import 'package:flutter/material.dart';

class CatagoryTile extends StatelessWidget {
  final String name;
  final String path;
  const CatagoryTile({super.key, required this.path, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 130,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage(path),
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
