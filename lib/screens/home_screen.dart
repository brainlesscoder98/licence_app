import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
import '../main.dart';
import 'how_to_apply.dart';
import 'road_sign_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TranslationController translationController =
      Get.put(TranslationController());
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
        width: containerWidth ?? Get.width * 0.45,
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:appPrimaryColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: appPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,2), // changes position of shadow
                      ),
                    ],
                    shape: BoxShape.circle),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: placeHolder),

              ),
              VGap(height: 10),
              Container(
                width: (containerWidth) ?? Get.width * 0.45,
                child: Text(
                  title,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.white),
      //   backgroundColor: Colors.black,
      //   automaticallyImplyLeading: false,
      //   flexibleSpace: Container(
      //     decoration: GlobalDecoration.containerDecoration,
      //   ),
      //   elevation: 0,
      //   leading: Builder(
      //     builder: (context) => Container(
      //       width: 60,height: 60,
      //       margin: EdgeInsets.symmetric(horizontal: 10),
      //       decoration: BoxDecoration(
      //           color: appPrimaryColor,
      //           shape: BoxShape.circle),
      //       child: IconButton(
      //
      //         icon: Icon(Icons.menu, color: Colors.white), // Your custom icon
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer(); // Open the drawer
      //         },
      //       ),
      //     ),
      //   ),
      //   actions: [
      //     Obx(() {
      //       if (homeController.languages.isEmpty) {
      //         return Center(child: SizedBox());
      //       }
      //       return Container(
      //         width: 60,height: 60,
      //         margin: EdgeInsets.symmetric(horizontal: 10),
      //         decoration: BoxDecoration(
      //             color: appPrimaryColor,
      //             shape: BoxShape.circle),
      //         child: PopupMenuButton<String>(
      //           color: Colors.teal,
      //           iconColor: Colors.white,
      //           onSelected: (String value) {
      //             print('App Language :: $value');
      //             appStorage.write(AppConstants().appLang, value);
      //             homeController.onInit();
      //           },
      //           itemBuilder: (BuildContext context) {
      //             return homeController.languages.map((language) {
      //               return PopupMenuItem(
      //                 value: language['short_name']!,
      //                 enabled: true,
      //                 child: Text(
      //                   language['title']!,
      //                   style: GoogleFonts.poppins(
      //                     fontSize: 14,
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               );
      //             }).toList();
      //           },
      //         ),
      //       );
      //     }),
      //   ],
      // ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            width: Get.width,
            height: 80,
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(
                  builder: (context) => Container(
                    width: 60,height: 60,
                    decoration: BoxDecoration(
                        color: appPrimaryColor,
                        shape: BoxShape.circle),
                    child: IconButton(

                      icon: Icon(Icons.menu, color: Colors.white), // Your custom icon
                      onPressed: () {
                        Scaffold.of(context).openDrawer(); // Open the drawer
                      },
                    ),
                  ),
                ),
                Obx(() {
                  if (homeController.languages.isEmpty) {
                    return Center(child: SizedBox());
                  }
                  return Container(
                    width: 60,height: 60,
                    decoration: BoxDecoration(
                        color: appPrimaryColor,
                        shape: BoxShape.circle),
                    child: PopupMenuButton<String>(
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
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
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
            color: Colors.black,
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
                        imageUrl: _getImageUrl(homeController.homeItems[0]),
                        placeHolder: Image.asset(itemsImages[0], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[0]),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => SignBoardScreen());
                        },
                        bgColor: itemsColor[1],
                        imageUrl: _getImageUrl(homeController.homeItems[1]),
                        placeHolder: Image.asset(itemsImages[1], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[1]),
                      ),
                    ],
                  ),
                  VGap(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _itemContainer(
                          onTap: () {
                            Get.to(() => HandSignScreen());
                          },
                          bgColor: itemsColor[2],
                          imageUrl: _getImageUrl(homeController.homeItems[2]),
                          placeHolder: Image.asset(itemsImages[2], fit: BoxFit.cover),
                          title: _getLocalizedTitle(homeController.homeItems[2]),
                        ),
                        _itemContainer(
                          onTap: () {
                            Get.to(() => RoadSignScreen());
                          },
                          bgColor: itemsColor[3],
                          imageUrl: _getImageUrl(homeController.homeItems[3]),
                          placeHolder: Image.asset(itemsImages[3], fit: BoxFit.cover),
                          title: _getLocalizedTitle(homeController.homeItems[3]),
                        ),
                        ]
                  ),
                  VGap(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _itemContainer(
                        onTap: () {
                          Get.to(() => RtoCodeScreen());
                        },
                        bgColor: itemsColor[6],
                        imageUrl: _getImageUrl(homeController.homeItems[6]),
                        placeHolder:Image.asset(itemsImages[6], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[6]),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => HowToApplyScreen());
                        },
                        bgColor: itemsColor[7],
                        imageUrl: _getImageUrl(homeController.homeItems[7]),
                        placeHolder: Image.asset(itemsImages[7], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[7]),
                      ),

                    ],
                  ),
                  VGap(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      _itemContainer(
                        onTap: () {
                          Get.to(() => PreQuestionScreen());
                        },
                        bgColor: itemsColor[4],
                        imageUrl: _getImageUrl(homeController.homeItems[4]),
                        placeHolder:Image.asset(itemsImages[4], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[4]),
                      ),
                      _itemContainer(
                        onTap: () {
                          Get.to(() => TimerTestScreen());
                        },
                        bgColor: itemsColor[5],
                        imageUrl: _getImageUrl(homeController.homeItems[5]),
                        placeHolder: Image.asset(itemsImages[5], fit: BoxFit.cover),
                        title: _getLocalizedTitle(homeController.homeItems[5]),
                      ),
                    ],
                  ),
                  VGap(height: 20),
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
