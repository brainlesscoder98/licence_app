// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/main.dart';
import 'package:license_master/screens/pre_questions.dart';
import 'package:license_master/screens/timer_test_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../controller/home_controller.dart';
import '../controller/translator_controller.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/screens/hand_sign_screen.dart';
import 'package:license_master/screens/questions_screen.dart';
import 'package:license_master/screens/road_sign_screen.dart';
import 'package:license_master/screens/rto_code_screen.dart';
import 'package:license_master/screens/sign_board_screen.dart';
import '../app_constants/app_constants.dart';
import '../custom_widgets/main_banner.dart';
import '../custom_widgets/c_drawer.dart';
import '../custom_widgets/middle_banner.dart';
import 'how_to_apply.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final TranslationController translationController =
      Get.put(TranslationController());

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

  void translateStaticData(String targetLanguage) {
    var texts = {
      'Question': 'Question',
      'Sign Board': 'Sign Board',
      'Hand Sign': 'Hand Sign',
      'Road sign': 'Road sign',
      'Pre-test': 'Pre-test',
      'Timer-test': 'Timer-test',
      'RTO-code': 'RTO-code',
      'How to apply': 'How to apply'
    };
    translationController.translateTexts(texts, targetLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          flexibleSpace: Container(
            decoration: GlobalDecoration.containerDecoration,
          ),
          elevation: 0,
          actions: [
            Obx(() {
              if (homeController.languages.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return PopupMenuButton<String>(
                color: Colors.teal,

                iconColor: Colors.white,
                onSelected: (String value) {
                  translateStaticData(value);
                  print('App Language :: $value');
                  appStorage.write(AppConstants().appLang, value);
                  homeController.onInit();
                },
                itemBuilder: (BuildContext context) {
                  return homeController.languages.map((language) {
                    return PopupMenuItem(
                      value: language['short_name']!,
                      enabled: true,
                      child: Text(language['title']!,style: GoogleFonts.poppins(fontSize:14,color:Colors.white),),
                    );
                  }).toList();
                },
              );
            }),
          ],
        ),
        drawer:  SideDrawer(),
        backgroundColor: Colors.black,
        body: Obx(() {
          if (homeController.homeItems.isEmpty) {
            return Center(
                child: LoadingAnimationWidget.flickr(
              size: 50,
              leftDotColor: Colors.blue,
              rightDotColor: Colors.red,
            ));
          }
          return Center(
            child: Container(
              decoration:GlobalDecoration.containerDecoration,
              child: ListView(
                children: [
                  MainBanner(),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      crossAxisSpacing: 8.0, // Spacing between columns
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homeController.homeItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final homeitems = homeController.homeItems[index];
                      String imageUrl = _getImageUrl(homeitems);
                      String title = _getLocalizedTitle(homeitems);
                      return GestureDetector(
                        onTap: () {
                          // Perform individual routing based on the tapped item
                          switch (index) {
                            case 0:
                              Get.to(QuestionsScreen());
                              break;
                            case 1:
                              Get.to(SignBoardScreen());
                              break;
                            case 2:
                              Get.to(HandSignScreen());
                              break;
                            case 3:
                              Get.to(RoadSignScreen());
                              break;
                            case 4:
                              Get.to(PreQuestionScreen());
                              break;
                            case 5:
                              Get.to(TimerTestScreen());
                              break;
                            case 6:
                              Get.to(RtoCodeScreen());
                              break;
                            case 7:
                              Get.to(HowToApplyScreen());
                              break;
                            default:
                              break;
                          }
                        },
                        child: Card(
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              image: DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit
                                    .cover, // Adjust the image fit as per your requirement
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const VGap(height: 40),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Card(
                                    elevation: 5,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: Container(
                                      width:
                                          AppConstants().mediaSize.width * 0.3,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: itemsColor[index],
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Center(
                                          child: Text(
                                        title.toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // MiddleBanner()
                ],
              ),
            ),
          );
        }));
  }
  String _getImageUrl(Map<String, String> homeitems) {
    return homeitems['imageUrl'].toString();
  }
  String _getLocalizedTitle(Map<String, String> homeitems) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return homeitems['title_ml'] ?? homeitems['title'].toString();
      case 'hi':
        return homeitems['title_hi'] ?? homeitems['title'].toString();
      case 'ta':
        return homeitems['title_ta'] ?? homeitems['title'].toString();
      default:
        return homeitems['title']!;
    }
  }
}
