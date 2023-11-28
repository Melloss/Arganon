import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './kidase_screen.dart';
import '../utilities/utilities.dart' show ColorPallet, screenWidth;
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
  int selectedKidaseTile = -1;
  @override
  Widget build(BuildContext context) {
    return Stepper(
        physics: const BouncingScrollPhysics(),
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
                    id: 0, title: 'እምነ በሐ ጀምሮ', kidaseList: eminebehaKidase),
                _buildKidaseTile(
                    id: 1,
                    title: 'ጸልዩ አበውየ ጀምሮ',
                    kidaseList: tseliyuAbewuyeKidase),
                _buildKidaseTile(
                    id: 2,
                    title: 'ከቅዱስ ባስልዮስን የምስጋና ጸሎት ጀምሮ',
                    kidaseList: kidusBasliyosMisganaTselotKidase),
                _buildKidaseTile(
                    id: 3,
                    title: 'ከኅብስት ጸሎት ጀምሮ',
                    kidaseList: hibstTselotKidase),
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
                      id: 4,
                      title: 'ከሐዋርያው ጳውሎስ መልአክት ጀምሮ',
                      kidaseList: kehawaryawPawlosMelikt),
                  _buildKidaseTile(
                      id: 5,
                      title: 'ከዝውእቱ ጊዜ ባርኮት ጀምሮ',
                      kidaseList: ziwituGizeBarkotKidase),
                  _buildKidaseTile(
                      id: 6,
                      title: 'ከኪዳን ጸሎት ጀምሮ',
                      kidaseList: kidanTselotKidase),
                  _buildKidaseTile(
                      id: 7,
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
                      id: 8,
                      title: 'ወንጌል ቅዱስ ዘዜነወ ጀምሮ',
                      kidaseList: wengelKidusKidase),
                  _buildKidaseTile(
                      id: 9,
                      title: 'ጸልዩ በእንተ ሰላመ ቤተ ክርስቲያን ጀምሮ',
                      kidaseList: tseliyuBenteBetekristianKidase),
                  _buildKidaseTile(
                      id: 10,
                      title: 'ከሐዋርያትን አመንክዩ ጀምሮ',
                      kidaseList: yehawaryatAmenkiyuKidase),
                  _buildKidaseTile(
                      id: 11,
                      title: 'ከባስልዮስ የአምኃ ጸሎት ጀምሮ',
                      kidaseList: basliyosAmhaTselotKidase),
                ],
              )),
        ]);
  }

  _buildKidaseTile(
      {required int id,
      required String title,
      required List<Map<String, dynamic>> kidaseList}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: screenWidth(context) * 0.8,
      child: Stack(
        children: [
          MaterialButton(
            minWidth: screenWidth(context),
            padding: const EdgeInsets.all(20),
            color: dbController.settings.foregroundColor!.value,
            onPressed: () {
              setState(() {
                selectedKidaseTile = id;
              });
              Get.to(() => KidaseScreen(kidaseList: kidaseList));
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Visibility(
            visible: selectedKidaseTile == id,
            child: Positioned(
              top: 0,
              bottom: 0,
              left: 10,
              child: Center(
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
