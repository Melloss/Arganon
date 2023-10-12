import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './kidase_screen.dart';
import '../helper/helper.dart' show ColorPallet, screenWidth;
import '../models/kidase.dart';
import '../controllers/database_controller.dart';

class KidaseTab extends StatefulWidget {
  const KidaseTab({super.key});

  @override
  State<KidaseTab> createState() => _KidaseTabState();
}

class _KidaseTabState extends State<KidaseTab> with ColorPallet {
  int currentStep = 0;
  DatabaseController dbController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stepper(
        controlsBuilder: (context, details) {
          return const SizedBox.shrink();
        },
        currentStep: currentStep,
        connectorColor: MaterialStatePropertyAll(
            dbController.settings.foregroundColor!.value),
        type: StepperType.vertical,
        onStepTapped: ((value) {
          setState(() {
            currentStep = value;
          });
        }),
        steps: [
          Step(
            subtitle: Text('ከእምነ በሐ - የሐዋርያው ጳውሎስ መልአክት',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 12,
                    )),
            title: Text('ክፍል ፩', style: Theme.of(context).textTheme.titleLarge),
            content: Column(
              children: [
                _buildKidaseTile(
                    title: 'እምነ በሐ ጀምሮ', kidaseList: eminebehaKidase),
                _buildKidaseTile(
                    title: 'ጸልዩ አበውየ ጀምሮ', kidaseList: tseliyuAbewuyeKidase),
                _buildKidaseTile(
                    title: 'ከቅዱስ ባስልዮስን የምስጋና ጸሎት ጀምሮ',
                    kidaseList: kidusBasliyosMisganaTselotKidase),
                _buildKidaseTile(
                    title: 'ከኅብስት ጸሎት ጀምሮ', kidaseList: hibstTselotKidase),
              ],
            ),
          ),
          Step(
              subtitle: Text('ከሐዋርያው ጳውሎስ መልአክት - ወንጌል ቅዱስ',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                      )),
              title:
                  Text('ክፍል ፪', style: Theme.of(context).textTheme.titleLarge),
              content: Column(
                children: [
                  _buildKidaseTile(
                      title: 'ከሐዋርያው ጳውሎስ መልአክት ጀምሮ',
                      kidaseList: kehawaryawPawlosMelikt),
                  _buildKidaseTile(
                      title: 'ከዝውእቱ ጊዜ ባርኮት ጀምሮ',
                      kidaseList: ziwituGizeBarkotKidase),
                  _buildKidaseTile(
                      title: 'ከኪዳን ጸሎት ጀምሮ', kidaseList: kidanTselotKidase),
                  _buildKidaseTile(
                      title: 'ከ ኦ ሥሉስ ቅዱስ መሐረነ ጀምሮ',
                      kidaseList: oSilusKidusKidase),
                ],
              )),
          Step(
              subtitle: Text('ከወንጌል ቅዱስ - ቅዳሴ ሐዋርያት',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                      )),
              title:
                  Text('ክፍል ፫', style: Theme.of(context).textTheme.titleLarge),
              content: Column(
                children: [
                  _buildKidaseTile(
                      title: 'ወንጌል ቅዱስ ዘዜነወ ጀምሮ',
                      kidaseList: wengelKidusKidase),
                  _buildKidaseTile(
                      title: 'ጸልዩ በእንተ ሰላመ ቤተ ክርስቲያን ጀምሮ',
                      kidaseList: tseliyuBenteBetekristianKidase),
                  _buildKidaseTile(
                      title: 'ከሐዋርያትን አመንክዩ ጀምሮ',
                      kidaseList: yehawaryatAmenkiyuKidase),
                  _buildKidaseTile(
                      title: 'ከባስልዮስ የአምኃ ጸሎት ጀምሮ',
                      kidaseList: basliyosAmhaTselotKidase),
                ],
              )),
        ]);
  }

  _buildKidaseTile(
      {required String title, required List<Map<String, dynamic>> kidaseList}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: screenWidth(context) * 0.8,
      height: 50,
      child: MaterialButton(
        color: dbController.settings.foregroundColor!.value,
        onPressed: () {
          Get.to(() => KidaseScreen(kidaseList: kidaseList));
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
