import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:licence_app/main.dart';
import 'package:licence_app/screens/hand_sign_screen.dart';
import 'package:licence_app/screens/questions_screen.dart';
import 'package:licence_app/screens/road_sign_screen.dart';
import 'package:licence_app/screens/rto_code_screen.dart';
import 'package:licence_app/screens/sign_board_screen.dart';
import 'package:licence_app/screens/pretest_screen.dart';
import 'package:licence_app/screens/testing_screen.dart';
import 'package:licence_app/screens/timer_test_screen.dart';
import '../app_constants/app_constants.dart';
import '../custom_widgets/c_appbar.dart';
import '../custom_widgets/main_banner.dart';
import '../custom_widgets/c_drawer.dart';
import '../custom_widgets/middle_banner.dart';
import 'how_to_apply.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> items = [
    'Question',
    'Sign Board',
    'Hand Sign',
    'Road sign',
    'Pre-test',
    'Timer-test',
    'RTO-code',
    'How to apply'
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: const SideDrawer(),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,),
          child: ListView(
            children: [
              MainBanner(),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Perform individual routing based on the tapped item
                      switch (index) {
                        case 0:
                          // Navigate to Question screen

                          Get.to(QuestionsScreen());
                          break;
                        case 1:
                          // Navigate to SignBoard screen
                          Get.to(SignBoardScreen());
                          break;
                        case 2:
                          // Navigate to HandSign screen
                          Get.to(HandSignScreen());
                          break;
                        case 3:
                          // Navigate to HandSign screen
                          Get.to(RoadSignScreen());
                          break;
                        case 4:
                          // Navigate to HandSign screen
                          Get.to(PreTestScreen());
                          break;
                        case 5:
                          // Navigate to HandSign screen
                          Get.to(TimerTestScreen());
                          break;
                        case 6:
                          // Navigate to HandSign screen
                          Get.to(RtoCodeScreen());
                          break;
                        case 7:
                          // Navigate to HandSign screen
                          // Get.to(MyAppTest());
                          Get.to(HowToApplyScreen());
                          break;
                        // Add cases for other items as needed
                        default:
                          break;
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                                itemsImages[index]), // Provide your image path
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: Container(
                                  width: AppConstants().mediaSize.width * 0.3,
                                  height: 40,
                                  // margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: itemsColor[index],
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Text(
                                      items[index],
                                      style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color:Colors.white ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
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
              MiddleBanner()
            ],
          ),
        ),
      ),
    );
  }
}
