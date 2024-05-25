import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/pretest_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

import '../controller/questions_controller.dart';

class PreTestScreen extends StatelessWidget {
  final PreTestController preTestController = Get.put(PreTestController());
  Future<void> _refreshData() async {
    await preTestController.fetchData();
  }
    void showValidationMessage() {
    Get.snackbar(
      "Validation",
      "Select answer to continue",
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            // preTestController.resetQuiz();
            Get.back();
          },
        ),
        actions: [
          Obx(() {
            return (preTestController.isCompleted.value)?const HGap(width: 0):Row(
              children: [
                Container(
                  width:60,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      '${preTestController.correctAnswersCount}',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 60,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      '${preTestController.wrongAnswersCount}',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
        title: Obx(() {
          return Text(
            preTestController.isCompleted.value
                ? "Pre-Test Completed"
                : "Pre-Test Screen",
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),textAlign: TextAlign.left,
          );
        }),
      ),
      body: Obx(() {
        if (preTestController.isCompleted.value) {
          return Stack(
            children: [
              preTestController.getResultMessage() == 'Pass'
                  ? Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/success.gif",
                  width: AppConstants().mediaSize.width,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              )
                  : const HGap(width: 0),
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    preTestController.getResultMessage(),
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: preTestController.getResultMessage() == 'Pass'
                            ? Colors.green
                            : Colors.red),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: AppConstants().mediaSize.width * 0.3,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Correct: ${preTestController.correctAnswersCount}',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: AppConstants().mediaSize.width * 0.3,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Wrong: ${preTestController.wrongAnswersCount}',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: preTestController.pretest.length,
                      itemBuilder: (context, index) {
                        final question = preTestController.pretest[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}: ${question['question']}',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                ),
                                child: Text(question['answer'].toString(),
                                  // preTestController.question.correctAnswerIndex,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      preTestController.resetQuiz();
                    },
                    child: Container(
                      width: AppConstants().mediaSize.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Center(
                        child: Text(
                          'Restart Quiz',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${preTestController.currentQuestionIndex.value + 1}: ${preTestController.pretest[preTestController.currentQuestionIndex.value]['question']}',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              ///Option1
              GestureDetector(
                onTap: (){
                  preTestController.checkAnswer(preTestController.pretest[preTestController.currentQuestionIndex.value]['option_one'].toString(), preTestController.currentQuestionIndex.value, preTestController.pretest[preTestController.currentQuestionIndex.value]['answer'].toString());
                },
                child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: buttonColor
                          color: Colors.grey
                      ),
                      child: Text(
                        preTestController.pretest[preTestController.currentQuestionIndex.value]['option_one'].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
              ),
              SizedBox(height: 20),
              ///Option 2
              GestureDetector(
                onTap: (){
                  preTestController.checkAnswer(preTestController.pretest[preTestController.currentQuestionIndex.value]['option_two'].toString(), preTestController.currentQuestionIndex.value, preTestController.pretest[preTestController.currentQuestionIndex.value]['answer'].toString());
                },
                child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: buttonColor
                          color: Colors.grey
                      ),
                      child: Text(
                        preTestController.pretest[preTestController.currentQuestionIndex.value]['option_two'].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
              ),
              SizedBox(height: 20),
              ///Option three
              GestureDetector(
                onTap: (){
                  preTestController.checkAnswer(preTestController.pretest[preTestController.currentQuestionIndex.value]['option_three'].toString(), preTestController.currentQuestionIndex.value, preTestController.pretest[preTestController.currentQuestionIndex.value]['answer'].toString());
                },
                child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: buttonColor
                          color: Colors.grey
                      ),
                      child: Text(
                        preTestController.pretest[preTestController.currentQuestionIndex.value]['option_three'].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      preTestController.resetQuiz();
                      Get.back();
                    },
                    child: Container(
                      width: AppConstants().mediaSize.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Exit',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const HGap(width: 15),
                  GestureDetector(
                    onTap: () {
                      if (preTestController.selectedAnswerIndex.value ==
                          null) {
                        showValidationMessage();
                      } else {
                        preTestController.nextQuestion();
                      }
                    },
                    child: Container(
                      width: AppConstants().mediaSize.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
