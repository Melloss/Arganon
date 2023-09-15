import 'package:get/get.dart';
import '../models/mezmurs.dart' show mezmurs;
import 'dart:math' show Random;
import '../helper/helper.dart' show Constants;

class MezmurController extends GetxController with Constants {
  RxList<RxMap<String, dynamic>> mezmurList = mezmurs;
  List favoriteMezmurIndexs = [];
  Set randomMezmurs = {};
  List searchedMezmurs = [];

  List<int> kidistSilasseMezmurs = [];
  List<int> medhanealemMezmurs = [];
  List<int> nisehaMezmurs = [];
  List<int> pseraklitosMezmur = [];
  List<int> emebetachinMezmur = [];
  List<int> abuneTeklehaymanotMezmurs = [];
  List<int> kidusMikaelMezmurs = [];
  List<int> kidusGebrielMezmurs = [];
  List<int> kidistArsemaMezmurs = [];
  List<int> kidusRufaelMezmurs = [];
  List<int> abuneGebremenfeskidusMezmurs = [];
  List<int> abuneGiorgisMezmurs = [];
  List<int> sergMezmurs = [];
  List<int> lidetMezmurs = [];
  List<int> meskelMezmurs = [];
  List<int> enkuatatashMezmurs = [];
  List<int> timketMezmurs = [];
  List<int> hosaenaMezmurs = [];
  List<int> sikletMezmurs = [];
  List<int> tinsaeMezmurs = [];
  List<int> ergetMezmurs = [];
  List<int> mitsatMezmurs = [];
  List<int> debretaborMezmurs = [];
  List<int> kidusUraelMezmurs = [];
  List<int> kidusGiorgisMezmurs = [];
  List<int> kidusYohanisMetmikMezmurs = [];
  List<int> kidusEstifanosMezmurs = [];
  List<int> kidusPawlosMezmurs = [];
  List<int> kidusMerkoryosMezmurs = [];
  List<int> kidusYaredMezmurs = [];
  List<int> abuneAregawiMezmurs = [];

  void generateRandomMezmurs() {
    Set<int> randomNumbers = {};
    for (int i = 0; randomNumbers.length < 5; i++) {
      randomNumbers.add(Random().nextInt(mezmurList.length));
    }
    randomMezmurs = randomNumbers;
  }

  search(String text) {
    searchedMezmurs.clear();
    for (int i = 0; i < mezmurList.length; i++) {
      if (mezmurList[i]['title'].contains(text)) {
        searchedMezmurs.add(i);
      }
    }
    for (int i = 0; i < mezmurList.length; i++) {
      if (mezmurList[i]['lyrics'].contains(text)) {
        if (searchedMezmurs.contains(i) == false) {
          searchedMezmurs.add(i);
        }
      }
    }

    print(searchedMezmurs);
  }

  String getSubtitle(int index) {
    String lyrics = mezmurList[index]['lyrics'];
    String subtitle = lyrics.split('\n')[0];
    if (subtitle.length > 23) {
      return '${subtitle.substring(0, 23)}...';
    }
    return subtitle;
  }

  createCatagories() {
    for (int i = 0; i < mezmurList.length; i++) {
      List catagories = mezmurList[i]['catagory'];
      if (catagories.contains(kidistSilasseCatagory)) {
        kidistSilasseMezmurs.add(i);
      }
      if (catagories.contains(medhanealemCatagory)) {
        medhanealemMezmurs.add(i);
      }
      if (catagories.contains(nisehaCatagory)) {
        nisehaMezmurs.add(i);
      }
      if (catagories.contains(pseraklitosCatagory)) {
        pseraklitosMezmur.add(i);
      }
      if (catagories.contains(emebetachinCatagory)) {
        emebetachinMezmur.add(i);
      }
      if (catagories.contains(abuneTeklehaymanotCatagory)) {
        abuneTeklehaymanotMezmurs.add(i);
      }
      if (catagories.contains(kidusMikaelCatagory)) {
        kidusMikaelMezmurs.add(i);
      }
      if (catagories.contains(kidusGebrielCatagory)) {
        kidusGebrielMezmurs.add(i);
      }
      if (catagories.contains(kidistArsemaCatagory)) {
        kidistArsemaMezmurs.add(i);
      }
      if (catagories.contains(kidusRufaelCatagory)) {
        kidusRufaelMezmurs.add(i);
      }
      if (catagories.contains(abuneGebremenfeskidusCatagory)) {
        abuneGebremenfeskidusMezmurs.add(i);
      }
      if (catagories.contains(abuneGiorgisCatagory)) {
        abuneGiorgisMezmurs.add(i);
      }
      if (catagories.contains(kidusUraelCatagory)) {
        kidusUraelMezmurs.add(i);
      }
      if (catagories.contains(kidusGiorgisCatagory)) {
        kidusGiorgisMezmurs.add(i);
      }
      if (catagories.contains(kidusYohanisMetimkCatagory)) {
        kidusYohanisMetmikMezmurs.add(i);
      }
      if (catagories.contains(kidusEstifanosCatagory)) {
        kidusEstifanosMezmurs.add(i);
      }
      if (catagories.contains(kidusPawlosCatagory)) {
        kidusPawlosMezmurs.add(i);
      }
      if (catagories.contains(kidusMerkoryosCatagory)) {
        kidusMerkoryosMezmurs.add(i);
      }
      if (catagories.contains(kidusYaredCatagory)) {
        kidusYaredMezmurs.add(i);
      }
      if (catagories.contains(sergCatagory)) {
        sergMezmurs.add(i);
      }
      if (catagories.contains(lidetCatagory)) {
        lidetMezmurs.add(i);
      }
      if (catagories.contains(meskelCatagory)) {
        meskelMezmurs.add(i);
      }
      if (catagories.contains(enkutatashCatagory)) {
        enkuatatashMezmurs.add(i);
      }
      if (catagories.contains(timketCatagory)) {
        timketMezmurs.add(i);
      }
      if (catagories.contains(hosaenaCatagory)) {
        hosaenaMezmurs.add(i);
      }
      if (catagories.contains(sikletCatagory)) {
        sikletMezmurs.add(i);
      }
      if (catagories.contains(tinsaeCatagory)) {
        tinsaeMezmurs.add(i);
      }
      if (catagories.contains(ergetCatagory)) {
        ergetMezmurs.add(i);
      }
      if (catagories.contains(mitseatCatagory)) {
        mitsatMezmurs.add(i);
      }
      if (catagories.contains(debretaborCatagory)) {
        debretaborMezmurs.add(i);
      }
      if (catagories.contains(abuneAregawiCatagory)) {
        abuneAregawiMezmurs.add(i);
      }

      catagories.clear();
    }
  }

  String getUrlAddress(String fileID) {
    return 'https://www.googleapis.com/drive/v3/files/$fileID?alt=media&key=AIzaSyCAtbRmPnOklzrDRYZe4LBemLzNTjx80pI&v=.mp3';
  }

  void toggleFavorite(int index) {
    if (mezmurList[index]['isFavorite'] == true) {
      mezmurList[index]['isFavorite'] = false;
      favoriteMezmurIndexs.remove(index);
    } else {
      mezmurList[index]['isFavorite'] = true;
      if (favoriteMezmurIndexs.contains(index) == false) {
        favoriteMezmurIndexs.add(index);
      }
    }
  }

  List getMezmur(String catagory) {
    if (catagory == kidistSilasseCatagory) {
      return kidistSilasseMezmurs;
    } else if (catagory == medhanealemCatagory) {
      return medhanealemMezmurs;
    } else if (catagory == nisehaCatagory) {
      return nisehaMezmurs;
    } else if (catagory == pseraklitosCatagory) {
      return pseraklitosMezmur;
    } else if (catagory == emebetachinCatagory) {
      return emebetachinMezmur;
    } else if (catagory == abuneTeklehaymanotCatagory) {
      return abuneTeklehaymanotMezmurs;
    } else if (catagory == kidusMikaelCatagory) {
      return kidusMikaelMezmurs;
    } else if (catagory == kidusGebrielCatagory) {
      return kidusGebrielMezmurs;
    } else if (catagory == kidistArsemaCatagory) {
      return kidistArsemaMezmurs;
    } else if (catagory == kidusRufaelCatagory) {
      return kidusRufaelMezmurs;
    } else if (catagory == abuneGebremenfeskidusCatagory) {
      return abuneGebremenfeskidusMezmurs;
    } else if (catagory == abuneGiorgisCatagory) {
      return abuneGiorgisMezmurs;
    } else if (catagory == kidusUraelCatagory) {
      return kidusUraelMezmurs;
    } else if (catagory == kidusGiorgisCatagory) {
      return kidusGiorgisMezmurs;
    } else if (catagory == kidusYohanisMetimkCatagory) {
      return kidusYohanisMetmikMezmurs;
    } else if (catagory == kidusEstifanosCatagory) {
      return kidusEstifanosMezmurs;
    } else if (catagory == kidusPawlosCatagory) {
      return kidusPawlosMezmurs;
    } else if (catagory == kidusMerkoryosCatagory) {
      return kidusMerkoryosMezmurs;
    } else if (catagory == kidusYaredCatagory) {
      return kidusYaredMezmurs;
    } else if (catagory == abuneAregawiCatagory) {
      return abuneAregawiMezmurs;
    } else if (catagory == sergCatagory) {
      return sergMezmurs;
    } else if (catagory == lidetCatagory) {
      return lidetMezmurs;
    } else if (catagory == meskelCatagory) {
      return meskelMezmurs;
    } else if (catagory == enkutatashCatagory) {
      return enkuatatashMezmurs;
    } else if (catagory == timketCatagory) {
      return timketMezmurs;
    } else if (catagory == hosaenaCatagory) {
      return hosaenaMezmurs;
    } else if (catagory == sikletCatagory) {
      return sikletMezmurs;
    } else if (catagory == tinsaeCatagory) {
      return tinsaeMezmurs;
    } else if (catagory == ergetCatagory) {
      return ergetMezmurs;
    } else if (catagory == mitseatCatagory) {
      return mitsatMezmurs;
    } else if (catagory == debretaborCatagory) {
      return debretaborMezmurs;
    }
    return [];
  }
}
