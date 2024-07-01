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

class HomeScreens extends StatelessWidget {
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
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appPrimaryColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.3,
                    height: 90,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: appPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                       ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        child: placeHolder),
                  ),

                ],
              ),
              VGap(height: 10),
              Container(
                width: (containerWidth) ?? Get.width * 0.45,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: appPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                      ],
                    ),
                  ),
                )
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: GlobalDecoration.containerDecoration,
        ),
        elevation: 0,
        leading: Builder(
          builder: (context) => Container(
            width: 60,height: 60,
            margin: EdgeInsets.symmetric(horizontal: 10),
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
        actions: [
          Obx(() {
            if (homeController.languages.isEmpty) {
              return Center(child: SizedBox());
            }
            return Container(
              width: 60,height: 60,
              margin: EdgeInsets.symmetric(horizontal: 10),
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeController.homeItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1.0, // Aspect ratio for the items
                    ),
                    itemBuilder: (context, index) {
                      final item = homeController.homeItems[index];
                      return _itemContainer(
                        onTap: () {
                          _navigateToScreen(index);
                        },
                        bgColor: itemsColor[index],
                        imageUrl: _getImageUrl(item),
                        placeHolder:
                            Image.asset(itemsImages[index], fit: BoxFit.fill),
                        title: _getLocalizedTitle(item),
                      );
                    },
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

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Get.to(
              () => QuestionsScreen(),
          transition: Transition.leftToRightWithFade, // or Transition.leftToRight, Transition.rightToLeft, etc.
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 1:
        Get.to(
              () => SignBoardScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 2:
        Get.to(
              () => HandSignScreen(),
          transition: Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 3:
        Get.to(
              () => RoadSignScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 4:
        Get.to(
              () => PreQuestionScreen(),
          transition: Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 5:
        Get.to(
              () => TimerTestScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 6:
        Get.to(
              () => RtoCodeScreen(),
          transition: Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 7:
        Get.to(
              () => HowToApplyScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      default:
        Get.to(
              () => QuestionsScreen(),
          transition: Transition.leftToRightWithFade,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
    }
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
