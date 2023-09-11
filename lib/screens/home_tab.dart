import 'package:flutter/material.dart';
import '../helper/helper.dart' show screenWidth, ColorPallet;
import '../widgets/widgets.dart' show Carousel, MezmurTile;
import 'catagory_tab.dart';

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
  List<bool> isTabClicked = [true, false, false, false, false];
  List icons = [
    [Icons.home_outlined, Icons.home],
    [Icons.folder_outlined, Icons.folder],
    [Icons.favorite_outline, Icons.favorite],
    [Icons.church_outlined, Icons.church],
    [Icons.settings_outlined, Icons.settings],
  ];

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);

    scrollController.addListener(() {
      if (scrollController.offset == 0.0) {
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

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  searchOnChangeHandler(value) {
    if (value.isEmpty) {
      setState(() {
        showCloseButton = false;
        showCarousel = true;
      });
    } else {
      setState(() {
        showCloseButton = true;
        showCarousel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          _buildHomeTab(),
          const CatagoryTab(),
          Container(),
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
        height: 40,
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
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: child,
            );
          },
          child:
              showCarousel == true ? const Carousel() : const SizedBox.shrink(),
        ),
        showCarousel ? const SizedBox.shrink() : const SizedBox(height: 20),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              print("Refreshing....");
            },
            color: Colors.red,
            backgroundColor: Colors.white,
            child: AnimatedList(
              shrinkWrap: true,
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              initialItemCount: 20,
              itemBuilder: (context, index, animation) {
                return MezmurTile(
                  image: 'assets/icons/dingle_maryam_1.jpg',
                  index: index,
                  isFavorite: false,
                  title: 'እኔስ በምግባሬ',
                  subtitle: 'እኔስ በምግባሬ ደካማ ሆኛለሁ',
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
      decoration: BoxDecoration(color: foregroundColor, boxShadow: [
        BoxShadow(
          blurRadius: 3,
          spreadRadius: 2,
          color: Colors.black.withOpacity(0.2),
        )
      ]),
      child: TabBar(
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
          fontSize: 10,
        ),
        controller: tabController,
        tabs: [
          _buildTab(0, 'Home'),
          _buildTab(1, 'Catagories'),
          _buildTab(2, 'Favorite'),
          _buildTab(3, 'Kidase'),
          _buildTab(4, 'Settings'),
        ],
      ),
    );
  }
}
