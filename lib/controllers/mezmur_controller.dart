import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:math' show Random;
import 'dart:convert' show json;
import '../utilities/utilities.dart' show ColorPallet;
import '../models/mezmurs.dart';
import '../models/mezmurs_file_id.dart';
import 'package:audioplayers/audioplayers.dart';

class MezmurController extends GetxController with ColorPallet {
  List<Mezmur> mezmurList = [];
  List favoriteMezmurIndexs = [];
  List searchedMezmurs = [];

  Set randomMezmurs = {};
  String mezmursUrl =
      'https://arganon-53673-default-rtdb.firebaseio.com/mezmurs.json';
  RxString currentPlayingKidaseFileId = ''.obs;

  AudioPlayer player = AudioPlayer();

  int currentPlayingMezmurIndex = -1;

  Duration mezmurDuration = const Duration(seconds: 0);
  Duration mezmurPosition = const Duration(seconds: 0);

  RxBool fromFile = false.obs;
  RxBool isPlaying = false.obs;
  RxBool showPlayerController = false.obs;

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
  List<int> adadisMezmurs = [];

  generateRandomMezmurs() {
    Set<int> randomNumbers = {};
    for (int i = 0; randomNumbers.length < 7; i++) {
      randomNumbers.add(Random().nextInt(mezmurList.length));
    }
    randomMezmurs = randomNumbers;
  }
  /*

          'id': 64,
          'fileId': '1X3p6UemykNuTqThkxoBV_u76lgGDdMGo',
          'title': 'እመቤቴ የአምላክ እናት',
          'lyrics': '''እመቤቴ የአምላክ እናት
ላመስግንሽ ቀን ከሌሊት
ለልጅሽም ክብር ውዳሴ
ታቀርባለች ዘውትር ነፍሴ /2/
    ልቤ ተነሣሣ ተቀኘ ለክብርሽ
    በፍፁም ትህትና ሊያመሰግንሽ
    ጽዮን መጠጊያ ነሽ የአብርሃም ድንኳን
    የታጠረች ተክል እመብርሃን
የለመለመች መስክ አምላክ የመረጣት
የጽላቱ ኪዳን ታቦቱ ድንግል ናት
የሰማይ የምድር ንግስት ናትና
ክብር ይገባታል ዘውትር ጠዋት ማታ
    አደራሽን ማርያም የሁሉ እናት
    በምልጃሽ አስቢኝ ኃላ ስራቆት
    ያንን የእሳት ባህር አሻግሪኝ ድንግል ሆይ
    እንዳልወድቅ እንዳሞት ከቶ እንዳላይ ስቃይ''',
          'image': emebetachinImage1,
          'catagory': [
            emebetachinCatagory,
            adadisMezmursCatagory,
          ]
        }

  */

//https://arganon-53673-default-rtdb.firebaseio.com/
  postAllMezmursToFirebase() async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

      await databaseReference.child('mezmurs/63').set({
        'id': 63,
        'fileId': '1X3p6UemykNuTqThkxoBV_u76lgGDdMGo',
        'title': 'እመቤቴ የአምላክ እናት',
        'lyrics': '''እመቤቴ የአምላክ እናት
ላመስግንሽ ቀን ከሌሊት
ለልጅሽም ክብር ውዳሴ
ታቀርባለች ዘውትር ነፍሴ /2/
    ልቤ ተነሣሣ ተቀኘ ለክብርሽ
    በፍፁም ትህትና ሊያመሰግንሽ
    ጽዮን መጠጊያ ነሽ የአብርሃም ድንኳን
    የታጠረች ተክል እመብርሃን
የለመለመች መስክ አምላክ የመረጣት
የጽላቱ ኪዳን ታቦቱ ድንግል ናት
የሰማይ የምድር ንግስት ናትና
ክብር ይገባታል ዘውትር ጠዋት ማታ
    አደራሽን ማርያም የሁሉ እናት
    በምልጃሽ አስቢኝ ኃላ ስራቆት
    ያንን የእሳት ባህር አሻግሪኝ ድንግል ሆይ
    እንዳልወድቅ እንዳሞት ከቶ እንዳላይ ስቃይ''',
        'image': emebetachinImage1,
        'catagory': [
          emebetachinCatagory,
          adadisMezmursCatagory,
        ]
      });
    } catch (error) {
      print(error);
    }
  }

  search(String text) {
    searchedMezmurs.clear();
    for (int i = 0; i < mezmurList.length; i++) {
      if (mezmurList[i].title.contains(text)) {
        searchedMezmurs.add(mezmurList[i].id);
      }
    }
    for (int i = 0; i < mezmurList.length; i++) {
      if (mezmurList[i].lyrics.contains(text)) {
        if (searchedMezmurs.contains(i) == false) {
          searchedMezmurs.add(mezmurList[i].id);
        }
      }
    }
  }

  void toggleFavorite(int index) async {
    if (mezmurList[index].isFavorite.value == true) {
      mezmurList[index].isFavorite.value = false;
      favoriteMezmurIndexs.remove(index);
    } else {
      mezmurList[index].isFavorite.value = true;
      if (favoriteMezmurIndexs.contains(index) == false) {
        favoriteMezmurIndexs.add(index);
      }
    }
    postAllMezmursToFirebase();
  }

  String getSubtitle(int index) {
    String lyrics = mezmurList[index].lyrics;
    String subtitle = lyrics.split('\n')[0];
    if (subtitle.length > 23) {
      return '${subtitle.substring(0, 23)}...';
    }
    return subtitle;
  }

  createCatagories() {
    kidistSilasseMezmurs = [];
    medhanealemMezmurs = [];
    nisehaMezmurs = [];
    pseraklitosMezmur = [];
    emebetachinMezmur = [];
    abuneTeklehaymanotMezmurs = [];
    kidusMikaelMezmurs = [];
    kidusGebrielMezmurs = [];
    kidistArsemaMezmurs = [];
    kidusRufaelMezmurs = [];
    abuneGebremenfeskidusMezmurs = [];
    abuneGiorgisMezmurs = [];
    sergMezmurs = [];
    lidetMezmurs = [];
    meskelMezmurs = [];
    enkuatatashMezmurs = [];
    timketMezmurs = [];
    hosaenaMezmurs = [];
    sikletMezmurs = [];
    tinsaeMezmurs = [];
    ergetMezmurs = [];
    mitsatMezmurs = [];
    debretaborMezmurs = [];
    kidusUraelMezmurs = [];
    kidusGiorgisMezmurs = [];
    kidusYohanisMetmikMezmurs = [];
    kidusEstifanosMezmurs = [];
    kidusPawlosMezmurs = [];
    kidusMerkoryosMezmurs = [];
    kidusYaredMezmurs = [];
    abuneAregawiMezmurs = [];
    adadisMezmurs = [];

    for (int i = 0; i < mezmurList.length; i++) {
      List catagories = [...mezmurList[i].catagory];

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
      if (catagories.contains(adadisMezmursCatagory)) {
        adadisMezmurs.add(i);
      }

      catagories.clear();
    }
  }

  String getUrlAddress(String fileID) {
    return 'https://www.googleapis.com/drive/v3/files/$fileID?alt=media&key=AIzaSyCAtbRmPnOklzrDRYZe4LBemLzNTjx80pI&v=.mp3';
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
    } else if (catagory == adadisMezmursCatagory) {
      return adadisMezmurs;
    }
    return [];
  }
}
