import 'package:flutter/material.dart';
import '../widgets/widgets.dart' show CatagoryExpandable, CatagoryTile;

class CatagoryTab extends StatefulWidget {
  const CatagoryTab({super.key});

  @override
  State<CatagoryTab> createState() => _CatagoryTabState();
}

class _CatagoryTabState extends State<CatagoryTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CatagoryExpandable(
          title: 'Yekidusan Mezmur',
          children: <CatagoryTile>[
            CatagoryTile(
              path: 'assets/icons/kidist_arsema.jpg',
              name: 'Ye Kidist Arsema',
            ),
            CatagoryTile(
              path: 'assets/icons/dingle_maryam_2.jpg',
              name: 'Ye Dingle Maryam',
            ),
            CatagoryTile(
              path: 'assets/icons/abune_teklehaymanot.jpg',
              name: 'Ye Abune Teklehaymanot ',
            ),
          ],
        ),
        CatagoryExpandable(title: 'Yetinsae Mezmur', children: [
          CatagoryTile(
            path: 'assets/icons/abune_teklehaymanot.jpg',
            name: 'Ye Abune Teklehaymanot ',
          ),
        ]),
      ],
    );
  }
}
