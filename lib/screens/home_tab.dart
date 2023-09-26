import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../screens/favorite_tab.dart';
import '../helper/helper.dart' show screenWidth, ColorPallet;
import '../widgets/widgets.dart' show Carousel, MezmurTile;
import './catagory_tab.dart';
import '../controllers/mezmur_controller.dart';
import '../controllers/database_controller.dart';
import '../screens/mezmur_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin, ColorPallet {
  final searchController = TextEditingController();
  final scrollController = ScrollController();
  late TabController tabController;
  bool showCloseButton = false;
  bool showCarousel = true;
  bool isSearching = false;
  List<bool> isTabClicked = [true, false, false, false, false];
  List icons = [
    [Icons.home_outlined, Icons.home],
    [Icons.folder_outlined, Icons.folder],
    [Icons.favorite_outline, Icons.favorite],
    [Icons.church_outlined, Icons.church],
    [Icons.settings_outlined, Icons.settings],
  ];
  MezmurController mezmurController = Get.find();
  DatabaseController databaseController = Get.find();

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);

    scrollController.addListener(() {
      if (scrollController.offset == scrollController.initialScrollOffset) {
        setState(() {
          showCarousel = true;
        });
      } else {
        setState(() {
          showCarousel = false;
        });
      }
    });
    super.initState();
  }

  Future refreshHandler() async {
    await databaseController.fetchMezmurs();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  searchOnChangeHandler(String value) {
    mezmurController.search(value);
    if (value.isEmpty) {
      setState(() {
        showCloseButton = false;
        showCarousel = true;
        isSearching = false;
      });
    } else {
      setState(() {
        showCloseButton = true;
        showCarousel = false;
        isSearching = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          _buildHomeTab(),
          const CatagoryTab(),
          const FavoriteTab(),
          Container(),
          Container(),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  _buildSearchInbox() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: screenWidth(context) * 0.9,
        height: 50,
        child: TextField(
          controller: searchController,
          onChanged: searchOnChangeHandler,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Search Mezmur',
              hintStyle: const TextStyle(
                fontSize: 15,
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                  onPressed: () {
                    searchController.text = '';
                    setState(() {
                      showCloseButton = false;
                      isSearching = false;
                      showCarousel = true;
                    });
                  },
                  icon: Visibility(
                    visible: showCloseButton,
                    maintainAnimation: true,
                    maintainState: true,
                    child: const Icon(Icons.close_outlined, size: 18),
                  ))),
        ),
      ),
    );
  }

  _buildHomeTab() {
    return Column(
      children: [
        _buildSearchInbox(),
        AnimatedSwitcher(
          switchInCurve: Curves.bounceOut,
          switchOutCurve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 1500),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: child,
            );
          },
          child: showCarousel == true
              ? Carousel(
                  mezmurs: mezmurController.randomMezmurs,
                )
              : const SizedBox.shrink(),
        ),
        showCarousel ? const SizedBox.shrink() : const SizedBox(height: 20),
        Expanded(
          child: isSearching
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    itemCount: mezmurController.searchedMezmurs.length,
                    itemBuilder: (context, index) {
                      return Obx(
                        () => MezmurTile(
                          image: mezmurController
                              .mezmurList[
                                  mezmurController.searchedMezmurs[index]]
                              .image,
                          isFavorite: mezmurController
                              .mezmurList[
                                  mezmurController.searchedMezmurs[index]]
                              .isFavorite
                              .value,
                          title: mezmurController
                              .mezmurList[
                                  mezmurController.searchedMezmurs[index]]
                              .title,
                          subtitle: mezmurController.getSubtitle(
                              mezmurController.searchedMezmurs[index]),
                          index: mezmurController.searchedMezmurs[index],
                        ),
                      );
                    },
                  ),
                )
              : RefreshIndicator(
                  onRefresh: refreshHandler,
                  backgroundColor: blurWhite,
                  color: foregroundColor,
                  strokeWidth: 2,
                  child: ListView.builder(
                    controller: scrollController,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    itemCount: mezmurController.mezmurList.length,
                    itemBuilder: (context, index) {
                      return MezmurTile(
                        image: mezmurController.mezmurList[index].image,
                        index: mezmurController.mezmurList[index].id,
                        isFavorite:
                            mezmurController.mezmurList[index].isFavorite.value,
                        title: mezmurController.mezmurList[index].title,
                        subtitle: mezmurController.getSubtitle(index),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  _buildTab(int index, String text) {
    return Tab(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 2.0),
        child: Icon(
            isTabClicked[index] == true ? icons[index][1] : icons[index][0],
            size: 25),
      ),
      text: text,
      height: 50,
      iconMargin: EdgeInsets.zero,
    );
  }

  _buildNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              mezmurScreenColor.withOpacity(0.8),
              navigationBarColor.withOpacity(0.3),
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.2),
            )
          ]),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Obx(() => Visibility(
              visible: mezmurController.showPlayerController.value,
              child: Container(
                width: screenWidth(context),
                height: 40,
                decoration: BoxDecoration(
                  color: blurWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: mezmurController.currentPlayingMezmurIndex != -1,
                      child: Container(
                          width: 45,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                alignment: Alignment.topCenter,
                                image: AssetImage(mezmurController
                                            .currentPlayingMezmurIndex ==
                                        -1
                                    ? ''
                                    : mezmurController
                                        .mezmurList[mezmurController
                                            .currentPlayingMezmurIndex]
                                        .image),
                                fit: BoxFit.cover,
                              ))),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => MezmurScreen(
                            index: mezmurController.currentPlayingMezmurIndex));
                      },
                      child: Text(
                        mezmurController.currentPlayingMezmurIndex == -1
                            ? ''
                            : mezmurController
                                .mezmurList[
                                    mezmurController.currentPlayingMezmurIndex]
                                .title,
                        style: TextStyle(
                          color: backgroudColor,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: playPauseHandler,
                      icon: mezmurController.isPlaying.value
                          ? Icon(
                              Icons.pause_circle,
                              color: foregroundColor,
                              size: 25,
                            )
                          : Icon(
                              Icons.play_circle,
                              color: foregroundColor,
                              size: 25,
                            ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await mezmurController.player.stop();
                          mezmurController.currentPlayingMezmurIndex = -1;
                          mezmurController.isPlaying.value = false;
                          mezmurController.showPlayerController.value = false;
                        },
                        icon: Icon(
                          Icons.close,
                          color: foregroundColor,
                        )),
                  ],
                ),
              ),
            )),
        TabBar(
          onTap: (index) {
            isTabClicked = isTabClicked.map((value) => false).toList();
            setState(() {
              isTabClicked[index] = true;
            });
          },
          indicator: const BoxDecoration(),
          labelColor: blurWhite,
          labelPadding: EdgeInsets.zero,
          labelStyle: const TextStyle(
            fontSize: 11,
          ),
          controller: tabController,
          tabs: [
            _buildTab(0, 'ቤት'),
            _buildTab(1, 'ምድቦች'),
            _buildTab(2, 'የተወደዱ'),
            _buildTab(3, 'ቅዳሴ'),
            _buildTab(4, 'ማስተካከያ'),
          ],
        ),
      ]),
    );
  }

  void playPauseHandler() async {
    String urlPath = mezmurController.getUrlAddress(mezmurController
        .mezmurList[mezmurController.currentPlayingMezmurIndex].fileId);
    if (mezmurController.isPlaying.value) {
      await mezmurController.player.pause();
      mezmurController.isPlaying.value = false;
    } else {
      final Directory appDocumentsDir =
          await getApplicationDocumentsDirectory();

      String path =
          '${appDocumentsDir.path}/${mezmurController.currentPlayingMezmurIndex}.mp3';
      if (await File(path).exists()) {
        await mezmurController.player.play(DeviceFileSource(path));
      } else {
        final connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.ethernet) {
          await mezmurController.player.play(UrlSource(urlPath));
        } else {
          Get.snackbar(
            'No Internet',
            'በመጀመሪያ ኢንተርኔት ያብሩ',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: blurWhite,
            colorText: backgroudColor,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          );
        }
      }
      mezmurController.isPlaying.value = true;
    }
  }
}
