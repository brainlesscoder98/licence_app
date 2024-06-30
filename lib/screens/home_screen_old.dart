import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/main.dart';
import 'package:license_master/screens/hand_sign_screen.dart';
import 'package:license_master/screens/pre_questions.dart';
import 'package:license_master/screens/questions_screen.dart';
import 'package:license_master/screens/rto_code_screen.dart';
import 'package:license_master/screens/sign_board_screen.dart';
import 'package:license_master/screens/timer_test_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../app_constants/app_constants.dart';
import '../controller/home_controller.dart';
import '../controller/translator_controller.dart';
import '../custom_widgets/c_drawer.dart';
import '../custom_widgets/c_gap.dart';
import '../custom_widgets/main_banner.dart';
import 'how_to_apply.dart';
import 'road_sign_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TranslationController translationController =
  Get.put(TranslationController());

  HomeScreen() {
    _precacheImages();
  }

  Future<void> _precacheImages() async {
    for (String image in itemsImages) {
      await precacheImage(AssetImage(image), Get.context!);
    }
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  List<Color> itemsColor = [
    Colors.amber,
    Colors.black,
    Colors.green.withOpacity(0.9),
    Colors.grey,
    Colors.brown,
    Colors.orange,
    const Color(0xffd268cc),
    Colors.blueGrey,
  ];

  final List<String> itemsImages = [
    'assets/images/questions.jpg',
    'assets/images/sign_board.jpg',
    'assets/images/hand_gesture.jpg',
    'assets/images/road.jpg',
    'assets/images/pre_test.jpg',
    'assets/images/timer.jpg',
    'assets/images/rto_code.jpg',
    'assets/images/apply.jpg',
  ];

  Future<void> _refreshData() async {
    homeController.onInit(); // Example: fetching data again
  }

  Widget _itemContainer({
    required String title,
    required String imageUrl,
    required Widget placeHolder,
    required Color bgColor,
    required VoidCallback onTap,
    double? containerWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerWidth ?? Get.width * 0.28,
        height: Get.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.5), // Shadow color with opacity
              spreadRadius: 2, // Spread radius
              blurRadius: 8, // Blur radius
              offset: Offset(1, 1), // Changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: containerWidth ?? Get.width * 0.28,
                height: Get.width * 0.3,
                child: placeHolder,
              ),
            ),
            Container(
              width: containerWidth ?? Get.width * 0.28,
              height: Get.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4), // Adjust the opacity as needed
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: containerWidth ?? Get.width * 0.28,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemMainContainer({
    required String title,
    required String imageUrl,
    required Color bgColor,
    required VoidCallback onTap,
    double? containerWidth,
    required Widget placeHolder,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: containerWidth ?? Get.width * 0.45,
        height: Get.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withOpacity(0.6),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.5), // Shadow color with opacity
              spreadRadius: 2, // Spread radius
              blurRadius: 8, // Blur radius
              offset: Offset(1, 1), // Changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: containerWidth ?? Get.width * 0.45,
                height: Get.width * 0.3,
                child: placeHolder,
              ),
            ),
            Container(
              width: containerWidth ?? Get.width * 0.45,
              height: Get.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4), // Adjust the opacity as needed
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: (containerWidth) ?? Get.width * 0.45,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: GlobalDecoration.containerDecoration,
        ),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // Your custom icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        actions: [
          Obx(() {
            if (homeController.languages.isEmpty) {
              return Center(child: SizedBox());
            }
            return PopupMenuButton<String>(
              color: Colors.teal,
              iconColor: Colors.white,
              onSelected: (String value) {
                print('App Language :: $value');
                appStorage.write(AppConstants().appLang, value);
                homeController.onInit();
              },
              itemBuilder: (BuildContext context) {
                return homeController.languages.map((language) {
                  return PopupMenuItem(
                    value: language['short_name']!,
                    enabled: true,
                    child: Text(
                      language['title']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList();
              },
            );
          }),
        ],
      ),
      drawer: SideDrawer(),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (homeController.homeItems.isEmpty) {
          return Center(
            child: LoadingAnimationWidget.flickr(
              size: 50,
              leftDotColor: Colors.blue,
              rightDotColor: Colors.red,
            ),
          );
        }
        return Center(
          child: Container(
            decoration: GlobalDecoration.containerDecoration,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  Text(
                    getGreeting(),
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  VGap(height: 20),
                  MainBanner(),
                  VGap(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _itemContainer(
                        onTap: () {
                          Get.to(() => QuestionsScreen());
                        },
                        bgColor: itemsColor[0],
                        title: _getLocalizedTitle(homeController.homeItems[0]),
                        imageUrl: itemsImages[0],
                        placeHolder: Image.asset(itemsImages[0], fit: BoxFit.cover, key: Key('image_0')),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => SignBoardScreen());
                        },
                        bgColor: itemsColor[1],
                        title: _getLocalizedTitle(homeController.homeItems[1]),
                        imageUrl: itemsImages[1],
                        placeHolder: Image.asset(itemsImages[1], fit: BoxFit.cover, key: Key('image_1')),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => HandSignScreen());
                        },
                        bgColor: itemsColor[2],
                        title: _getLocalizedTitle(homeController.homeItems[2]),
                        imageUrl: itemsImages[2],
                        placeHolder: Image.asset(itemsImages[2], fit: BoxFit.cover, key: Key('image_2')),
                      ),
                    ],
                  ),
                  VGap(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _itemContainer(
                        onTap: () {
                          Get.to(() => RoadSignScreen());
                        },
                        bgColor: itemsColor[3],
                        title: _getLocalizedTitle(homeController.homeItems[3]),
                        imageUrl: itemsImages[3],
                        placeHolder: Image.asset(itemsImages[3], fit: BoxFit.cover, key: Key('image_3')),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => RtoCodeScreen());
                        },
                        bgColor: itemsColor[6],
                        title: _getLocalizedTitle(homeController.homeItems[6]),
                        imageUrl: itemsImages[6],
                        placeHolder: Image.asset(itemsImages[6], fit: BoxFit.cover, key: Key('image_6')),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => HowToApplyScreen());
                        },
                        bgColor: itemsColor[7],
                        title:_getLocalizedTitle(homeController.homeItems[7]),
                        imageUrl: itemsImages[7],
                        placeHolder: Image.asset(itemsImages[7], fit: BoxFit.cover, key: Key('image_7')),
                      ),
                    ],
                  ),
                  VGap(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _itemMainContainer(
                        onTap: () {
                          Get.to(() => PreQuestionScreen());
                        },
                        bgColor: itemsColor[4],
                        title: _getLocalizedTitle(homeController.homeItems[4]),
                        imageUrl: itemsImages[4],
                        placeHolder: Image.asset(itemsImages[4], fit: BoxFit.cover, key: Key('image_4')),
                      ),
                      _itemMainContainer(
                        onTap: () {
                          Get.to(() => TimerTestScreen());
                        },
                        bgColor: itemsColor[5],
                        title: _getLocalizedTitle(homeController.homeItems[5]),
                        imageUrl: itemsImages[5],
                        placeHolder: Image.asset(itemsImages[5], fit: BoxFit.cover, key: Key('image_5')),
                      ),

                    ],
                  ),
                  VGap(height: 15),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  String _getImageUrl(Map<String, String> homeitems) {
    return homeitems['imageUrl']!;
  }

  String _getLocalizedTitle(Map<String, String> homeitems) {
    switch (appStorage.read(AppConstants().appLang)) {
      case 'ml':
        return homeitems['title_ml'] ?? homeitems['title']!;
      case 'hi':
        return homeitems['title_hi'] ?? homeitems['title']!;
      case 'ta':
        return homeitems['title_ta'] ?? homeitems['title']!;
      default:
        return homeitems['title']!;
    }
  }
}
