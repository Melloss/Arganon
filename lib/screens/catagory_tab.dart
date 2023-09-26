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
          title: 'የዘውትር መዝሙር',
          children: <CatagoryTile>[
            CatagoryTile(
              path: kidistSilasseImage,
              name: 'የቅድስት ሥላሴ',
              catagoryName: kidistSilasseCatagory,
            ),
            CatagoryTile(
              path: medhanealemImage,
              name: 'የመድሀኔአለም',
              catagoryName: medhanealemCatagory,
            ),
            CatagoryTile(
              path: nisehaImage2,
              name: 'የንሰሀ',
              alignment: Alignment.center,
              catagoryName: nisehaCatagory,
            ),
            CatagoryTile(
              path: peraklitosImage,
              name: 'የጰራቅሊጦስ',
              catagoryName: pseraklitosCatagory,
            ),
            CatagoryTile(
              path: betekristianImage1,
              name: 'አዳዲስ መዝሙሮች',
              catagoryName: adadisMezmursCatagory,
            )
          ],
        ),
        CatagoryExpandable(title: 'የቅዱሳን መዝሙር', children: [
          CatagoryTile(
            path: emebetachinImage1,
            name: 'የእመቤታችን',
            catagoryName: emebetachinCatagory,
          ),
          CatagoryTile(
            path: abuneTeklehaymanotImage,
            name: 'የአቡነ ተክለሀይማኖት',
            catagoryName: abuneTeklehaymanotCatagory,
          ),
          CatagoryTile(
            path: kidusMikaelImage1,
            name: 'የቅዱስ ሚካኤል',
            catagoryName: kidusMikaelCatagory,
          ),
          CatagoryTile(
            path: kidusGebrielImage,
            name: 'የቅዱስ ገብርኤል',
            catagoryName: kidusGebrielCatagory,
          ),
          CatagoryTile(
            path: kidistArsemaImage,
            name: 'የቅድስት አርሴማ',
            catagoryName: kidistArsemaCatagory,
          ),
          CatagoryTile(
            path: kidusRufaelImage,
            name: 'የቅዱስ ሩፋኤል',
            catagoryName: kidusRufaelCatagory,
          ),
          CatagoryTile(
            path: abuneGebremenfeskidusImage,
            name: 'የአቡነ ገብረመንፈስቅዱስ',
            catagoryName: abuneGebremenfeskidusCatagory,
          ),
          CatagoryTile(
            path: abuneGiorgisImage,
            name: 'የአባ ጊዮርጊስ ዘጋስጫ',
            catagoryName: abuneGiorgisCatagory,
          ),
          CatagoryTile(
            path: kidusUraelImage,
            name: 'የቅዱስ ዑራኤል',
            catagoryName: kidusUraelCatagory,
            alignment: const Alignment(0, -0.7),
          ),
          CatagoryTile(
            path: kidusGiorgisImage,
            name: 'የቅዱስ ጊዮርጊስ',
            catagoryName: kidusGiorgisCatagory,
            alignment: const Alignment(0, -0.5),
          ),
          CatagoryTile(
            path: kidusYohanisMetmikImage,
            name: 'የቅዱስ ዮሀንስ መጥምቅ',
            catagoryName: kidusYohanisMetimkCatagory,
          ),
          CatagoryTile(
            path: kidusEstifanosImage,
            name: 'የቅዱስ እስጢፋኖስ',
            catagoryName: kidusEstifanosCatagory,
          ),
          CatagoryTile(
            path: kidusPawlosImage,
            name: 'የቅዱስ ጳውሎስ',
            catagoryName: kidusPawlosCatagory,
          ),
          CatagoryTile(
            path: kidusMerkoryosImage,
            name: 'የቅዱስ መርቆርዮስ',
            catagoryName: kidusMerkoryosCatagory,
          ),
          CatagoryTile(
            path: kidusYaredImage,
            name: 'የቅዱስ ያሬድ',
            catagoryName: kidusYaredCatagory,
          ),
          CatagoryTile(
            path: abuneAregawiImage,
            name: 'የአቡነ አረጋዊ',
            catagoryName: abuneAregawiCatagory,
            alignment: Alignment.center,
          ),
        ]),
        CatagoryExpandable(title: 'የበዓል መዝሙር', children: [
          CatagoryTile(
            path: sergImage,
            name: 'የሰርግ',
            catagoryName: sergCatagory,
            alignment: Alignment.center,
          ),
          CatagoryTile(
            path: lidetImage,
            name: 'የልደት',
            catagoryName: lidetCatagory,
          ),
          CatagoryTile(
            path: meskelBealImage,
            name: 'የመስቀል',
            alignment: Alignment.center,
            catagoryName: meskelCatagory,
          ),
          CatagoryTile(
            path: enkutatashImage,
            name: 'የአዲስ አመት',
            catagoryName: enkutatashCatagory,
          ),
          CatagoryTile(
            path: timketImage,
            name: 'የጥምቀት',
            catagoryName: timketCatagory,
          ),
          CatagoryTile(
            path: hosaenaImage,
            name: 'የሆሳዕና',
            catagoryName: hosaenaCatagory,
          ),
          CatagoryTile(
            path: sikletImage,
            name: 'የስቅለት',
            catagoryName: sikletCatagory,
          ),
          CatagoryTile(
            path: tinsaeImage,
            name: 'የትንሳኤ',
            catagoryName: tinsaeCatagory,
          ),
          CatagoryTile(
            path: ergetImage,
            name: 'የዕርገት',
            catagoryName: ergetCatagory,
          ),
          CatagoryTile(
            path: mitseatImage,
            name: 'የምጻት',
            catagoryName: mitseatCatagory,
          ),
          CatagoryTile(
            path: debretaborImage,
            name: 'የደብረ ታቦር',
            catagoryName: debretaborCatagory,
          ),
        ])
      ],
    );
  }
}
