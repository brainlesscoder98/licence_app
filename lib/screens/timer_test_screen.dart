import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:license_master/controller/home_controller.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
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
  final TimerTestController timerTestController =
      Get.put(TimerTestController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () {
            homeController.onInit();
            Get.back();

          },
        ),
        flexibleSpace: Container(
          decoration:GlobalDecoration.containerDecoration,
        ),
        elevation: 0,
        actions: [
          Obx(() {
            if (homeController.languages.isEmpty) {
              return SizedBox();
            }
            return PopupMenuButton<String>(
              color: Colors.white,
              iconColor: Colors.white,
              onSelected: (String value) {
                print('App Language :: $value');
                appStorage.write(AppConstants().appLang, value);
                timerTestController.onInit();
              },
              itemBuilder: (BuildContext context) {
                return homeController.languages.map((language) {
                  return PopupMenuItem(
                    value: language['short_name']!,
                    child: Text(language['title']!),
                  );
                }).toList();
              },
            );
          }),
        ],
        title: Obx(() => Text(timerTestController.isCompleted.value == true
            ? 'Timer-Test Completed'
            : "Timer-Test Questions",style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),)),
      ),
      body: Container(
        decoration: GlobalDecoration.containerDecoration,
        child: SafeArea(
          child: Obx(() {
            if (timerTestController.filteredQuestions.isEmpty) {
              return Center(
                  child: LoadingAnimationWidget.flickr(
                size: 50,
                leftDotColor: Colors.blue,
                rightDotColor: Colors.red,
              ));
            }

            final currentQuestionIndex = timerTestController.currentQuestionIndex.value;
            final questionData = timerTestController.filteredQuestions[currentQuestionIndex];
            final questionText = timerTestController.getLocalizedQuestion(questionData);
            final correctAnswerIndex = questionData['correct_answer'].toString();
            print("Correct Ans:::::::::::: index = > ${correctAnswerIndex}");
            final answers = questionData['answers'] ?? [];
            // final answers = timerTestController.getFilteredAnswers(questionData['answers'] ?? []);

            final selectedAnswerIndex = timerTestController.selectedAnswerIndex.value;

            Widget _questions() {
              print("Answers is : $answers");
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

                          final answerText = timerTestController.getLocalizedAnswer(answerData);
                          print("Answer Text is: $answerText");
                          final isSelected = selectedAnswerIndex == answerIndex;

                          Color containerColor = Colors.grey;

                          return GestureDetector(
                            onTap: selectedAnswerIndex != null
                                ? null
                                : () {
                              // Ensure correct_answer is fetched properly as a String
                              timerTestController.checkAnswer(
                                answerIndex.toString(),
                                correctAnswerIndex,
                              );
                              Future.delayed(Duration(seconds: 1), () {
                                timerTestController.nextQuestion();
                              });
                              print("Selected Answer is: $answerText");
                              print("Selected Answer index is: ${correctAnswerIndex}");
                              print("Correct Answer is: $correctAnswerIndex");
                            },

                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: timerTestController.selectedAnswerIndex.value ==
                              answerIndex.toString()
                                  ? Colors.blue
                                  : Colors.grey,
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
                    margin: EdgeInsets.only(top: 20),
                      width: AppConstants().mediaSize.width,
                      // height: AppConstants().mediaSize.height * 0.32,
                      child: Stack(
                        children: [
                          timerTestController.getResultMessage() == "Pass"
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Lottie.asset(
                                      'assets/lottie/started.json',
                                      fit: BoxFit.fill,
                                      repeat: true,
                                      alignment: Alignment.center,
                                      width: AppConstants().mediaSize.width,
                                      height: AppConstants().mediaSize.height *
                                          0.36))
                              : HGap(width: 0),
                          Container(
                            margin: EdgeInsets.only(left: 15, right: 15,bottom: 15),
                            width: AppConstants().mediaSize.width,
                            height: AppConstants().mediaSize.height * 0.35,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          timerTestController
                                              .correctAnswersCount.value
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          timerTestController
                                              .wrongAnswersCount.value
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
                                ),
                                VGap(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        timerTestController.resetQuiz();
                                      },
                                      child: Container(
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          'Practice more',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                VGap(height: 10),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: AppConstants().mediaSize.height * 0.5,
                    child: ListView.builder(
                        shrinkWrap: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: timerTestController.filteredQuestions.length,
                        itemBuilder: (context, answerIndex) {
                          final resultQuestionText =
                              timerTestController.getLocalizedQuestion(
                                  timerTestController.filteredQuestions[answerIndex]);
                          final resultAnswerText =
                              timerTestController.getLocalizedCorrectAnswer(
                                  timerTestController.filteredQuestions[answerIndex]);
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
