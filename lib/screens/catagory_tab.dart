import 'package:arganon/helper/helper.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart' show CatagoryExpandable, CatagoryTile;
import '../helper/helper.dart' show Constants;

class CatagoryTab extends StatefulWidget {
  const CatagoryTab({super.key});

  @override
  State<CatagoryTab> createState() => _CatagoryTabState();
}

class _CatagoryTabState extends State<CatagoryTab> with Constants {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 30),
        CatagoryExpandable(
          title: 'Ye zewtir Mezmur',
          children: <CatagoryTile>[
            CatagoryTile(
              path: kidistSilasseImage,
              name: 'Ye Kidist Silasse',
              catagoryName: kidistSilasseCatagory,
            ),
            CatagoryTile(
              path: medhanealemImage,
              name: 'Ye Medhane Alem',
              catagoryName: medhanealemCatagory,
            ),
            CatagoryTile(
              path: nisehaImage2,
              name: 'Ye Niseha',
              alignment: Alignment.center,
              catagoryName: nisehaCatagory,
            ),
            CatagoryTile(
              path: peraklitosImage,
              name: 'Ye pseraklitos',
              catagoryName: pseraklitosCatagory,
            )
          ],
        ),
        CatagoryExpandable(title: 'Yekidusan Mezmur', children: [
          CatagoryTile(
            path: emebetachinImage1,
            name: 'Ye Emebetachin',
            catagoryName: emebetachinCatagory,
          ),
          CatagoryTile(
            path: abuneTeklehaymanotImage,
            name: 'Ye Abune Teklehaymanot ',
            catagoryName: abuneTeklehaymanotCatagory,
          ),
          CatagoryTile(
            path: kidusMikaelImage1,
            name: 'Ye Kidus Mikael',
            catagoryName: kidusMikaelCatagory,
          ),
          CatagoryTile(
            path: kidusGebrielImage,
            name: 'Ye Kidus Gebriel',
            catagoryName: kidusGebrielCatagory,
          ),
          CatagoryTile(
            path: kidistArsemaImage,
            name: 'Ye Kidist Arsema',
            catagoryName: kidistArsemaCatagory,
          ),
          CatagoryTile(
            path: kidusRufaelImage,
            name: 'Ye Kidus Rufael',
            catagoryName: kidusRufaelCatagory,
          ),
          CatagoryTile(
            path: abuneGebremenfeskidusImage,
            name: 'Ye Abune Gebremenfeskidus',
            catagoryName: abuneGebremenfeskidusCatagory,
          ),
          CatagoryTile(
            path: abuneGiorgisImage,
            name: 'Ye Abune Giorgis',
            catagoryName: abuneGiorgisCatagory,
          ),
          CatagoryTile(
            path: kidusUraelImage,
            name: 'Ye Kidus Urael',
            catagoryName: kidusUraelCatagory,
          ),
          CatagoryTile(
            path: kidusGiorgisImage,
            name: 'Ye Kidus Giorgis',
            catagoryName: kidusGiorgisCatagory,
          ),
          CatagoryTile(
            path: kidusYohanisMetmikImage,
            name: 'Ye Kidus Yohannes Metmik',
            catagoryName: kidusYohanisMetimkCatagory,
          ),
          CatagoryTile(
            path: kidusEstifanosImage,
            name: 'Ye Kidus Estifanos',
            catagoryName: kidusEstifanosCatagory,
          ),
          CatagoryTile(
            path: kidusPawlosImage,
            name: 'Ye Kidus Pawlos',
            catagoryName: kidusPawlosCatagory,
          ),
          CatagoryTile(
            path: kidusMerkoryosImage,
            name: 'Ye Kidus Merkoryos',
            catagoryName: kidusMerkoryosCatagory,
          ),
          CatagoryTile(
            path: kidusYaredImage,
            name: 'Ye Kidus Yared',
            catagoryName: kidusYaredCatagory,
          ),
          CatagoryTile(
            path: abuneAregawiImage,
            name: 'Ye Abune Aregawi',
            catagoryName: abuneAregawiCatagory,
            alignment: Alignment.center,
          ),
        ]),
        CatagoryExpandable(title: 'Ye Beal Mezmur', children: [
          CatagoryTile(
            path: sergImage,
            name: 'Ye Serg',
            catagoryName: sergCatagory,
            alignment: Alignment.center,
          ),
          CatagoryTile(
            path: lidetImage,
            name: 'Ye Lidet',
            catagoryName: lidetCatagory,
          ),
          CatagoryTile(
            path: meskelBealImage,
            name: 'Ye Meskel',
            alignment: Alignment.center,
            catagoryName: meskelCatagory,
          ),
          CatagoryTile(
            path: enkutatashImage,
            name: 'Ye Enkutatash',
            catagoryName: enkutatashCatagory,
          ),
          CatagoryTile(
            path: timketImage,
            name: 'Ye Timket',
            catagoryName: timketCatagory,
          ),
          CatagoryTile(
            path: hosaenaImage,
            name: 'Ye hosaena',
            catagoryName: hosaenaCatagory,
          ),
          CatagoryTile(
            path: sikletImage,
            name: 'Ye siklet',
            catagoryName: sikletCatagory,
          ),
          CatagoryTile(
            path: tinsaeImage,
            name: 'Ye Tinsae',
            catagoryName: tinsaeCatagory,
          ),
          CatagoryTile(
            path: ergetImage,
            name: 'Ye erget',
            catagoryName: ergetCatagory,
          ),
          CatagoryTile(
            path: mitseatImage,
            name: 'Ye Mitsat',
            catagoryName: mitseatCatagory,
          ),
          CatagoryTile(
            path: debretaborImage,
            name: 'Ye Debretabor',
            catagoryName: debretaborCatagory,
          ),
        ])
      ],
    );
  }
}
