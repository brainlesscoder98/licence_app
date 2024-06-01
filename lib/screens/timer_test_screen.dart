import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:licence_app/controller/home_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import '../app_constants/app_constants.dart';
import '../controller/timer_test_controller.dart';
import '../custom_widgets/c_appbar.dart';
import '../main.dart';

class TimerTestScreen extends StatefulWidget {
  @override
  State<TimerTestScreen> createState() => _TimerTestScreenState();
}

class _TimerTestScreenState extends State<TimerTestScreen> {
  final TimerTestController timerTestController = Get.put(TimerTestController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: timerTestController.isCompleted.value == true
            ? 'Timer-test Completed'
            : "Timre-Test Questions",
        onLanguageSelected: (String value) {
          print('App Language :: $value');
          appStorage.write(AppConstants().appLang, value);
          timerTestController.onInit();
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 20, 21),
              Color.fromARGB(255, 0, 0, 0), // Black
              // Dark Teal
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (timerTestController.pretest.isEmpty) {
              return Center(child: LoadingAnimationWidget.flickr(
                size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
              ));
            }

            final currentQuestionIndex =
                timerTestController.currentQuestionIndex.value;
            final questionData =
            timerTestController.pretest[currentQuestionIndex];
            final questionText =
            timerTestController.getLocalizedQuestion(questionData);
            final answers = questionData['answers'] ?? [];
            final selectedAnswerIndex =
                timerTestController.selectedAnswerIndex.value;

            Widget _questions() {
              return Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${currentQuestionIndex + 1}. $questionText',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Obx(() {
                              return Text(
                                '${timerTestController.secondsRemaining.value}s',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: answers.length,
                        itemBuilder: (context, answerIndex) {
                          final answerData = answers[answerIndex];
                          final answerText =
                          timerTestController.getLocalizedAnswer(answerData);
                          final isSelected = selectedAnswerIndex == answerIndex;
                          Color containerColor = Colors.grey;
                          if (isSelected && answerData['correct'] == true) {
                            containerColor = Colors.green;
                          } else if (isSelected &&
                              answerData['correct'] == false) {
                            containerColor = Colors.red;
                          }

                          return GestureDetector(
                            onTap: selectedAnswerIndex != null
                                ? null
                                : () {
                              timerTestController.checkAnswer(
                                  answerIndex, answerData['correct']);
                              Future.delayed(Duration(seconds: 1), () {
                                timerTestController.nextQuestion();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: containerColor,
                              ),
                              child: Text(
                                answerText,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      VGap(height: 10),
                    ],
                  ),
                ),
              );
            }

            Widget _result() {
              return Column(
                children: [
                  Container(
                      width: AppConstants().mediaSize.width,
                      height: AppConstants().mediaSize.height * 0.28,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            width: AppConstants().mediaSize.width,
                            height: AppConstants().mediaSize.height * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: timerTestController.getResultMessage() ==
                                  "Pass"
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    timerTestController.getResultMessage(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Correct',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        Text(
                                          timerTestController.correctAnswersCount
                                              .value
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 55,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    HGap(width: 20),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Wrong',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Text(
                                          timerTestController.wrongAnswersCount
                                              .value
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 55,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Elevate your success rate with\nmore practice",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          timerTestController.getResultMessage() == "Pass"
                              ? Align(
                              alignment: Alignment.topCenter,
                              child: Lottie.asset('assets/lottie/started.json',
                                  fit: BoxFit.fill,
                                  repeat: true,
                                  alignment: Alignment.center,
                                  width: AppConstants().mediaSize.width,
                                  height: AppConstants().mediaSize.height *
                                      0.26))
                              : HGap(width: 0),
                        ],
                      )),
                  Container(
                    height: AppConstants().mediaSize.height * 0.56,
                    child: ListView.builder(
                        shrinkWrap: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: timerTestController.pretest.length,
                        itemBuilder: (context, answerIndex) {
                          final resultQuestionText =
                          timerTestController.getLocalizedQuestion(
                              timerTestController.pretest[answerIndex]);
                          final resultAnswerText =
                          timerTestController.getLocalizedCorrectAnswer(
                              timerTestController.pretest[answerIndex]);
                          return Container(
                            width: AppConstants().mediaSize.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${answerIndex + 1}. ${resultQuestionText}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    resultAnswerText,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              );
            }

            return Column(
              children: [
                timerTestController.isCompleted.value == true
                    ? _result()
                    : _questions()
              ],
            );
          }),
        ),
      ),
    );
  }
}
