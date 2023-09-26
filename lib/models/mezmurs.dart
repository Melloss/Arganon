import 'package:get/get.dart';
import './mezmurs_file_id.dart';

//Images
const kidistArsemaImage = 'assets/icons/kidist_arsema.jpg';
const emebetachinImage1 = 'assets/icons/dingle_maryam_1.jpg';
const emebetachinImage2 = 'assets/icons/dingle_maryam_2.jpg';
const abuneTeklehaymanotImage = 'assets/icons/abune_teklehaymanot.jpg';
const abuneGiorgisImage = 'assets/icons/abune_giorgis.jpg';
const kidistSilasseImage = 'assets/icons/kidist_silasse.jpg';
const medhanealemImage = 'assets/icons/Medhane-Alem_1.jpg';
const abuneGebremenfeskidusImage = 'assets/icons/abune_gebremenfeskidus.jpg';
const kidusGebrielImage = 'assets/icons/kidus_gebreil_1.jpg';
const kidusMikaelImage1 = 'assets/icons/kidus_mikael_1.jpg';
const kidusRufaelImage = 'assets/icons/kidus_rufael.jpg';
const lidetImage = 'assets/icons/lidet_1.jpg';
const tseloteHamusImage = 'assets/icons/tselote_hamus.jpg';
const meskelBealImage = 'assets/meskel_beal_2.jpg';
const nisehaImage1 = 'assets/niseha_1.jpg';
const nisehaImage2 = 'assets/niseha_2.jpg';
const enkutatashImage = 'assets/enkutatash.jpg';
const betekristianImage1 = 'assets/betekristian_1.jpg';
const abuneAregawiImage = 'assets/icons/abune_aregawi.jpg';
const peraklitosImage = 'assets/icons/pseraklitos.jpg';
const kidusUraelImage = 'assets/icons/kidus_urael.jpeg';
const kidusGiorgisImage = 'assets/icons/kidus_giyorgis.jpeg';
const kidusYohanisMetmikImage = 'assets/icons/kidus_yohanis_metimk.jpeg';
const kidusEstifanosImage = 'assets/icons/kidus_estifanos.jpeg';
const kidusPawlosImage = 'assets/icons/kidus_pawlos.jpeg';
const kidusMerkoryosImage = 'assets/icons/kidus_merkoryos.jpg';
const kidusYaredImage = 'assets/icons/kidus_yared.jpeg';
const timketImage = 'assets/icons/timket.jpeg';
const hosaenaImage = 'assets/icons/hosaena.jpeg';
const sikletImage = 'assets/icons/meskel.jpeg';
const tinsaeImage = 'assets/icons/tinsae.jpg';
const ergetImage = 'assets/icons/erget.jpg';
const mitseatImage = 'assets/icons/mitseat.jpg';
const debretaborImage = 'assets/icons/debre_tabor.jpeg';
const sergImage = 'assets/icons/serg.jpeg';

//catagories
const medhanealemCatagory = 'medhanealem';
const emebetachinCatagory = 'emebetachin';
const enkutatashCatagory = 'enkutatash';
const nisehaCatagory = 'niseha';
const lidetCatagory = 'lidet';
const meskelCatagory = 'meskel';
const timketCatagory = 'timket';
const hosaenaCatagory = 'hosaena';
const sikletCatagory = 'siklet';
const tinsaeCatagory = 'tinsae';
const ergetCatagory = 'erget';
const mitseatCatagory = 'mitseat';
const kidusYohanisMetimkCatagory = 'kidus_yohnis_metmik';
const kidistSilasseCatagory = 'kidist_silasse';
const pseraklitosCatagory = 'pseraklitos';
const abuneTeklehaymanotCatagory = 'abune_teklehaymanot';
const kidusMikaelCatagory = 'kidus_mikael';
const kidusGebrielCatagory = 'kidus_gebriel';
const kidistArsemaCatagory = 'kidist_arsema';
const kidusRufaelCatagory = 'kidus_rufael';
const abuneGebremenfeskidusCatagory = 'abune_gebremenfeskidus';
const abuneGiorgisCatagory = 'abune_giorgis';
const abuneAregawiCatagory = 'abune_aregawi';
const kidusUraelCatagory = 'kidus_urael';
const kidusGiorgisCatagory = 'kidus_giorgis';
const kidusEstifanosCatagory = 'kidus_estifanos';
const kidusPawlosCatagory = 'kidus_pawlos';
const kidusMerkoryosCatagory = 'kidus_merkoryos';
const kidusYaredCatagory = 'kidus_yared';
const sergCatagory = 'serg';
const debretaborCatagory = 'debretabor';
const adadisMezmursCatagory = 'adadisMezmurCatagory';

class Mezmur {
  int id;
  String title;
  String lyrics;
  String image;
  RxBool isFavorite;
  List catagory;
  String fileId;
  RxBool isSeen;
  Mezmur({
    required this.id,
    required this.title,
    required this.catagory,
    required this.image,
    required this.isFavorite,
    required this.lyrics,
    required this.fileId,
    required this.isSeen,
  });
  toMap() {
    return {
      'id': id,
      'title': title,
      'lyrics': lyrics,
      'image': image,
      'catagory': catagory,
      'fileId': fileId,
      'isSeen': isSeen,
    };
  }
}

List<Mezmur> initMezmurs() {
  List<Mezmur> mezmursList = [];
  for (int i = 0; i < mezmurs.length; i++) {
    bool isFavorite = mezmurs[i]['isFavorite'];
    final m = Mezmur(
      id: i,
      title: mezmurs[i]['title'],
      lyrics: mezmurs[i]['lyrics'],
      image: mezmurs[i]['image'],
      isFavorite: isFavorite.obs,
      fileId: fileUniqueAddress[i],
      catagory: mezmurs[i]['catagory'],
      isSeen: false.obs,
    );
    mezmursList.add(m);
  }
  return mezmursList;
}

List<Map<String, dynamic>> mezmurs = [
  {
    'title': 'እኔስ በምግባሬ',
    'lyrics': '''እኔስ በምግባሬ ደካማ ሆኛለሁ /2/
እዘኝልኝ ድንግል እለምንሻለሁ /2/

    ያንን የእሳት ባህር እንዳላይ አደራ
    ድረሽልኝ ድንግል ስምሽን ስጠራ /2/

የዳዊት መሰንቆ የእስራኤል መና
የናሆም መድሃኒት ንኢ በደመና /2/

    አንቺ ነሽ ጉልበቴ በደከመኝ ጊዜ
    የልቤ መጽናኛ እረዳት ምርኩዜ /2/

አፈሳለሁ እንባ በጣም ተጨንቄ
እማጸንሻለሁ በደሌን አውቄ /2/
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
      nisehaCatagory,
    ]
  },
  {
    'title': 'ቋንቋዬ ነሽ',
    'lyrics': '''ቋንቋዬ ነሽ ድንግል መግባቢያዬ
መልስ የማገኝብሽ ከጌታዬ /2/
ባንቺ ቀርቤአለሁ ከአምላኬ ፊት
ቤቴ ሞልቶልኛል በበረከት /2/
    በምን ስራዬ ነው በፊቱ የቆምኩት
    መቼ በቅቼ ነው ስሙን የጠራሁት
    አስታራቂ እናት አንቺን ስለሰጠኝ
    ስለ ቃል ኪዳንሽ አቤት ልጄ በይኝ /2/
ቅድስና ሕይወት ከኔ ተሰውሮ
በውሸት በሃሜት አንደበቴ ታስሮ
በእመ አምላክ ፍቅር አዲስ ሰው ሆኛለሁ
እንደ መላእክቱ ይኸው እዘምራለሁ /2/
    ስለ እማምላክ ብሎ ያፈረ የለም
    ባንቺ ያልከበረ ሰው አይገኝም
    እንደ ባለማዕረግ እኔም ሰው መባሌ
    አንቺን አግኝቼ ነው ድንግል መሰላሌ /2/''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
  {
    'title': 'ስለማይነገር ስጦታው',
    'lyrics': '''ስለማይነገር ስጦታው እግዚአብሔር ይመስገን
ቸል ያላለን አምላክ ስንጓዝ ማዕበሉን አቋርጠን
ስለማይነገር ስጦታው እግዚአብሔር ይመስገን
    የሕይወት እስትንፋስ ዘራብን ህያው እንድንሆን
    ይህን ያደረገ አምላካችን እግዚአብሔር ይመስገን
    ስለማይነገር ስጦታው እግዚአብሔር ይመስገን
ንፋስን ገልጾ ማዕበል አቁሞ የሚያሻግር
የዓለም ፈተና ቢበዛ እርሱ መጠጊያችን
ስለማይነገር ስጦታው እግዚአብሔር ይመስገን
    ዳግም እንዳንሞት በሞቱ ሞትን የረታልን
    የምንመካበት ትንሳኤን ሰላምን የሰጠን
    ስለማይነገር ስጦታው እግዚአብሔር ይመስገን
ከሲኦል እስራት ተፈተን ነፃ የወጣንበት
መስቀሉን ለሰጠን ለአምላካችን እንዘምር በእውነት
ስለማይነገር ስጦታው እግዚአብሔር ይመስገን''',
    'image': medhanealemImage,
    'isFavorite': false,
    'catagory': [
      medhanealemCatagory,
    ]
  },
  {
    'title': 'የአዋጅ ነጋሪት ቃል',
    'lyrics': '''የአዋጅ ነጋሪት ቃል በበረሃ እያለ
የእግዚአብሔር መንገድ አስተካክሉ እያለ
ምስክርነቱን ዮሐንስ አስረዳ
ልባችን ለጌታ መልካም መንገድ ይሁን
  የደናግል መመኪያ የነብያት ገዳም
  አውደ ዓመቱን ባርኪልኝ ድንግል ማርያም /2/

ተራራው ዝቅ ይበል ጠማማውም ይቅና
ካልተስተካከለ መንገድ የለምና
የእግዚአብሔርን መንገድ እንመስርት ሁላችን
ማረፊያ እንዲሆነን ለመጪው ሐብታችን
    ክፋትና ተንኮል ከልባችን ይጥፋ
    ጽድቅና ርህራሄ በእኛ ላይ ይስፋፋ
    ስጋና ደምህን በክብር አግኝተናል
    ሕይወት እንደሆነን አምላክ ተማጽነናል
ሁለት ልብሶች ያሉት ከማብዛት ልብሱን
ለሌለው ያድለው ሁለተኛውን
ከበደላችንም አንጻን አደራህን
በክፉ እንዳንጠፋ እኛ ልጆችህ''',
    'image': enkutatashImage,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
      enkutatashCatagory,
    ]
  },
  {
    'title': 'ውዳሴ ማርያም',
    'lyrics': '''ውዳሴ ማርያም እጮሃለሁ
ድንግል እናቴን እጣራለሁ
እንደ አባ ኤፍሬም ነይ ባርኪኝ
ወድሰኒ ልጄ በይኝ

    ውዳሴ ማርያም በሰርክ ጸሎት ላይ 
        ››    ዜማ ስናደርስ
        ››    ድንግል ትመጣለች
        ››    በቤተ መቅደስ
        ››    የብርሃን ምንጣፍ
        ››    ከፊቷ ተነጥፏል
        ››    ቅዱስ ኤፍሬም ታጥቆ
        ››    ያመሰግናታል

ውዳሴ ማርያም አባ ህርያቆስ 
    ››    ምስጋና ያደርሳል
    ››    የቅዳሴው ዜማ
    ››    ልብን ይመስጣል
    ››    በጎ ነገር ልቤ
    ››    አወጣ አያለ
    ››    ዳዊት በገናውን
    ››    እየደረደረ

    ውዳሴ ማርያም የንጽህናችን
        ››    መሰረት ነሽና
        ››    አንቺን ለማመስገን
        ››    ልቦናዬ ይጽና
        ››    ተፈስሒ ድንግል
        ››    ኦ ቤተልሔም
        ››    ካንቺ ተወለደ
        ››    መድሃኒዓለም

ውዳሴ ማርያም ቅድሳት ሁሉ 
    ››    ዙሪያሽን ከበዋል
    ››    አባ ጊዮርጊስም
    ››    ንኢ ድንግል ይላል
    ››    በወርቅ ዙፋን ላይ
    ››    ተቀምጠሽ ሳይሽ
    ››    ልቤ ተሰወረ
    ››    ድንግል በግርማሽ
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
  {
    'title': 'የብርሃን ጎርፍ ናት',
    'lyrics': '''የብርሃን ጎርፍ ናት ድንግል እናታችን
ከሰማይ እያበራች ደስ አለው ልባችን
ፍቅርሽን ሰላምሽን ድህነት ይሁነን
ፍጥረት በሙሉ/2/ ፊትሽ ይወድቃሉ
ጸጋሽ ይድረሰን/2/ ይስጠን እያሉ
    የኔ ልብ ምን ፅድቅ አለው አንቺን ለማስተናገድ
    የሃጢያት ጎተራ ነው የተሞላ በስስት
    ኧረ እንዴት/2/ ድንግል ትኑርበት
    አትፀየፍም የኔን ልብ ታሰናዳዋለች
    ስለሃጢያቴ የኔ እናት ምልጃ ታቀርባለች
ልባቸውን የዘጉ ድንግልን ለማስገባት
ህሊናቸው ይመለስ እንጸልይ ለዚህ ጥፋት
አምላክን ይዛ ነው የምትመጣው
እርሷን ስንመልስ ጌታን ነው የምናስቀይመው
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
  {
    'title': 'ከጌታዬ ፍቅር የሚለየኝ ማነው',
    'lyrics': '''ከጌታዬ ፍቅር የሚለየኝ ማነው/2/
መከር ችግር ስቃይ ወይስ መራቆት ነው/2/

    አንፈራም አንሰጋም አንጠራጠርም/2/
    እግዚአብሔር ከኛ ጋራ ይኖራል ለዘለዓለም/2/

የሰማይ ቤታችን አማኑኤል የሰራው/2/
ግንቡ ንጹህ ውሃ መሰረቱ ደም ነው/2/

    ሳይነጋ ተራምደን እንጓዝ በጠዋት/2/
    በደሙ መስርቶ ከሰራልን ቤት/2/

የውሃ ግድግዳ የደም መሰረት/2/
ይኸው ከዚህ አለ የአማኑኤል ቤት/2/
    ''',
    'image': medhanealemImage,
    'isFavorite': false,
    'catagory': [
      medhanealemCatagory,
    ]
  },
  {
    'title': 'ምን ሰማህ ዮሐንስ',
    'lyrics': '''ምን ሰማህ ዮሐንስ በማህፀን ሳለህ/2/
ህጻን ሆነህ ነብይ ለክብር የተጠራህ/2/
እንደ አንበሳ ጥጃ ያዘለለ ደስታ/2/
ምን ዓይነት ድምጽ ነው ምን አይነት ሰላምታ/2/
    ከተፈጥሮ በላይ ያሰገደህ ክብር
    እንዴት ቢገባህ ነው የአምላክ እናት ፍቅር/2/
    ሌላ ድምጽ አልሰማም ከእንግዲህ በኋላ
    ለውጦኛል እና የሰላምታ ቃሏ/2/
በረሃ ያስገባህ ለብዙ ዘመናት
ምን ያለ ራዕይ እንዴት ያለ ብስራት/2/
እንደ አዲስ ምስጋና ስልቱ የተዋበ
ተደምጦ የማያውቅ ጭራሽ ያልታሰበ/2/
    ከሴት የተገኘ ከደቂቀ አዳም
    ድንግል ስለሆነ በሕይወቱ ፍፁም/2/
    ከማህፀን ሳለ ተመርጦ በጌታ
    ለማዳመጥ በቃ የኪዳን ሰላምታ/2/
    ''',
    'image': kidusYohanisMetmikImage,
    'isFavorite': false,
    'catagory': [
      kidusYohanisMetimkCatagory,
    ]
  },
  {
    'title': 'አንደበትን ስጠኝ ጌታዬ',
    'lyrics': '''አዳኙ ስምህን ዘወትር ልጠራበት
ቅዱስ ኃያል ህያው ክብር የምልበት
ከሃጢያት የራቀ ሐኬት የሌለበት
ምስጋናህን ብቻ የምናገርበት/2/
አንደበትን ስጠኝ ጌታዬ/4/
    ሕይወት የሆነውን ቃልህን ሰባኪ
    ገናናነትህን ክብርህን ተራኪ
    ለንስሃ ህይወት በጎችህን ጠሪ
    እንደ ሐዋሪያት ፍቅርህን መስካሪ/2/
ከከሃድያን ጋር የማይተባበር
ፆምና ጸሎትን የሚያዘወትር
ከጽድቅ ስራ ጋር መልካም ህብረት ያለው
በምድራዊ ምኞት የማይታለለው/2/
    ፈተና ሲገጥመኝ በመከራ ጊዜ
    የሀዘን ጥላ ጋርዶን ሲከበን ትካዜ
    ተመስገን የሚል በችግር በደስታ
    ርቱዕ አንደበትን ፍጠርልን ጌታ/2/
    ''',
    'image': medhanealemImage,
    'isFavorite': false,
    'catagory': [
      medhanealemCatagory,
    ]
  },
  {
    'title': 'የጽድቅ በር ነሽ',
    'lyrics': '''የጽድቅ በር ነሽ የሙሴ ጽላት
አክሊለ ሰማዕታት ምዕራገ ጸሎት
የጌታዬ እናት ንጹህ አክሊላችን
ሐመልማለ ሲና እመቤታችን/2/

እመቤታችን የእኛ ምርኩዝ ነሽ
    ››ከለላም ሆንሽን
    ››የእሳት ሙዳይ
    ››እሳት ታቀፍሽ
    ››በብርሃን ተከበሽ
    ››ወርቅ ለብሰሽ
    ››ከሴቶች ሁሉ
    ››አብ መረጠሽ

እመቤታችን ድንግል ሆይ ልጆችሽ 
    ››ዘውትር ይጠሩሻል
    ››ስምሽን ለልጅ ልጅ
    ››ያሳስቡልሻል
    ››በተሰጠሽ ጸጋ
    ››ባማላጅነትሽ
    ››ምህረትን አሰጪን
    ››ከመሃሪው ልጅሽ

እመቤታችን ያልታረሰች እርሻ 
    ››ዘር ያልተዘራባት
    ››የህይወትን ፍሬ
    ››ሰጠችን የእኛ እናት
    ››የታረደው መሲ
    ››እናቱን ወደዳት
    ››በቀኙ ቆማለች
    ›› ድንግል እመቤት ናት

እመቤታችን የእውነት ደመና 
    ››ዝናብ የታየባት
    ››ወዳናለች ድንግል
    ››የታተመች ገነት
    ››ክብር ለሆነችው
    ››ኑ እንዘምርላት
    ››ደስ ይበልሽ እንበል
    ››የብርሃን እናት
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
  {
    'title': 'ኑ በእግዚአብሔር',
    'lyrics': '''ኑ በእግዚአብሔር ደስ ይበለን/2/
ለታላቁ ክብር ለዚህ ላበቃን
ከሞት ወደ ሕይወት ላሸጋገረን
ኑ በእግዚአብሔር ኑ በድንግል ደስ ይበለን/2/
    የሰማዩን መንግስት እርስቱን ለሰጠን
    ከጨለማ አውጥቶ ብርሃንን ላሳየን
    ለዚህ ድንቅ ውለታው ምስጋና ያንሰዋል
    በእርሱ ደስ ይበለን ክብር ይገባዋል
ከአለት ላይ የፈለቀ ውሃ ጠጥተናል
ሰማያዊ መና አምላክ መግቦናል
ፍቅርህ የበዛልህ ምን ልክፈልህ ጌታ
ስምህን ላመስግነው ከጠዋት እስከማታ
    በቃዴስ በረሃ ምንም በሌለበት
    በኤርትራ ባህር ወጀብ በበዛጀት
    ለእርሱ መንገድ አለው ከቶ ምን ተስኖት
    ልባችሁ አይፍራ በፍጹም እመኑት
በባርነት ሳለን በድቅድቅ ዓለም
ብርሃንን አገኘን በድንግል ማርያም
ያጣነውን ሰላም ዛሬ አገኘን
እጅግ ደስ ይበለን በእመቤታችን
የሐና የእያቄም የእምነታቸው ፍሬ
    ''',
    'image': medhanealemImage,
    'isFavorite': false,
    'catagory': [
      medhanealemCatagory,
    ]
  },
  {
    'title': 'ሰላም ለኪ',
    'lyrics': '''ሰላም ለኪ ለኖህ ሐመሩ ሰላም ለኪ የአሮን በትሩ
የቅዱስ ዳዊት መሰንቆ መዝሙሩ ሰላም ለኪ የጌዴዎን ጾምሩ
የሰለሞን መንበረ ክብሩ ሰላም ለኪ ፍሬ ስብሐት መዝሙሩ/2/
እመ እግዚአብሔር ጸባኦት ሰላም ለኪ/2/

ሰላም ለኪ ሰረገላው ለአሚናዳብ ሰላም ለኪ
መና ያለብሽ ንጹህ መሶብ ሰላም ለኪ
ያዕቆብ ያየሽ በሎዛ ሰላም ለኪ
የይስሐቅ መዓዛ/2/

እንዘ ንሴብሖ ለበረከትኪ ዘምስለ አምሃ እሰግድ ለኪ/2/
ሰላም ለኪ ህብስተ መና ዘ እስራኤል ሰላም ለኪ
የሰማዕታት ንጹህ አክሊል ሰላም ለኪ
እጸ እጳጦስ ዘሲና ሰላም ለኪ
የኤልያስ መና/2/

እንዘ ንሴብሖ ለበረከትኪ ዘምስለ አምሃ እሰግድ ለኪ/2/
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
  {
    'title': 'ባክኛለሁና',
    'lyrics': '''ባክኛለሁና በስጋ ፈተና
የዚህ ዓለም ሀዘን ጫፍ የለውምና
ፈጥነሽ ወደእኔ ነይ ከትንሿ ቤቴ
አጽናኚኝ እመአምላክ ድንግል እመቤቴ
    ባህሩ ትልቅ ነው  [ድንግል እመቤቴ]
    ትንሽ ናት መርከቤ   >>
    የመንገዴ መሪ      >>
    አንቺ ነሽ ወደቤ    >>  /2/
በመንገዴ ስዝል   [ድንግል እመቤቴ]
ዓለም ትስቃለች    >>
መመኪያ እመቤቱ   >>
ወዴት ነች እያለች  >>  /2/
    በቀቢጸ ተስፋ  [ድንግል እመቤቴ]
    እንዳልወድቅብሽ   >>
    በቀንም በሌሊት   >>
    ተስፋዬ አንቺ ነሽ  >>  /2/
የለም ያተረፍኩት    [ድንግል እመቤቴ]
ወጥቼ ወርጄ          >>
ትርፌ አንቺ ብቻ ነሽ    >>
ጽዮን አማላጄ         >>   /2/
    ''',
    'image': emebetachinImage1,
    'isFavorite': false,
    'catagory': [
      emebetachinCatagory,
    ]
  },
];
/* 
{
    'title': '',
    'lyrics': '''
    ''',
    'image': ,
    'isFavorite': false,
    'catagory': [
      
    ]
  },

*/