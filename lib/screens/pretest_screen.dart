
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/pretest_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

import '../main.dart';

class PreTestScreen extends StatelessWidget {
  final PreTestController preTestController = Get.put(PreTestController());


  void showValidationMessage() {
    Get.snackbar(
      "Validation",
      "Select an answer to continue",
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
            preTestController.resetQuiz();
            Get.back();
          },
        ),
        actions: [
          // Obx(() {
          //   return (preTestController.isCompleted.value)
          //       ? const HGap(width: 0)
          //       : _buildScoreCounters();
          // }),
        ],
        title: Obx(() {
          return Text(
            preTestController.isCompleted.value
                ? "Pre-Test Completed"
                : "Pre-Test Screen",
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            textAlign: TextAlign.left,
          );
        }),
      ),
      body: Obx(() {
        return preTestController.isCompleted.value
            ? _buildCompletionScreen(context)
            : _buildQuestionScreen(context);
      }),
    );
  }
  Widget _buildCompletionScreen(BuildContext context) {
    return Stack(
      children: [
        if (preTestController.getResultMessage() == 'Pass')
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/images/success.gif",
              width: AppConstants().mediaSize.width,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
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
                    : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     _buildScoreCounter(
            //       type: 'Correct:',
            //       score: preTestController.correctAnswersCount.value,
            //       color: Colors.green,
            //     ),
            //     _buildScoreCounter(
            //       type: 'Wrong:',
            //       score: preTestController.wrongAnswersCount.value,
            //       color: Colors.red,
            //     ),
            //   ],
            // ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: preTestController.pretest.length,
                itemBuilder: (context, index) {
                  final question = preTestController.pretest[index];
                  return _buildQuestionResult(question, index);
                },
              ),
            ),
            _buildRestartButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionResult(Map<String, dynamic> question, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${index + 1}: ${_getLocalizedQuestion(question)}',
            style: GoogleFonts.poppins(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _getLocalizedAnswer(question, 'answer'),
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        preTestController.resetQuiz();
      },
      child: Container(
        width: AppConstants().mediaSize.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Text(
            'Restart Quiz',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionScreen(BuildContext context) {
    final pretest = preTestController.pretest;
    if (pretest.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 15),
      children: [
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${preTestController.currentQuestionIndex.value + 1}: ${_getLocalizedQuestion(pretest[preTestController.currentQuestionIndex.value])}',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: preTestController.pretest.length,
            itemBuilder: (context, index) {
              final question = preTestController.pretest[index]['answers'];
              return _buildOption(context, question[index]['answer_one']);
            },
          ),
        ),
        SizedBox(height: 40),
        _buildNavigationButtons(context),
      ],
    );
  }

  List<Widget> _buildOptions(BuildContext context) {
    final pretest = preTestController.pretest;
    final currentQuestion = pretest[preTestController.currentQuestionIndex.value];
    final options = [
      _getLocalizedAnswer(currentQuestion, 'answer_one'),
      _getLocalizedAnswer(currentQuestion, 'answer_two'),
      _getLocalizedAnswer(currentQuestion, 'answer_three'),
    ];

    return options.map((option) {
      return Column(
        children: [
          _buildOption(context, option),
          SizedBox(height: 20),
        ],
      );
    }).toList();
  }

  Widget _buildOption(BuildContext context, String option) {
    // bool isSelected = preTestController.selectedAnswerIndex.value == option;
    // bool isCorrect = option ==
    //     preTestController.pretest[preTestController.currentQuestionIndex.value]
    //     ['correct_answer'];
    // Color optionColor;
    //
    // if (isSelected) {
    //   optionColor = isCorrect ? Colors.green : Colors.red;
    // } else {
    //   optionColor = Colors.grey;
    // }

    return GestureDetector(
      onTap: () {
        // preTestController.checkAnswer(
        //   option,
        //   preTestController
        //       .pretest[preTestController.currentQuestionIndex.value]['correct_answer']
        //       .toString(),
        // );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: optionColor,
        ),
        child: Text(
          option,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
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
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Center(
              child: Text(
                'Exit',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.red),
              ),
            ),
          ),
        ),
        const HGap(width: 15),
        GestureDetector(
          onTap: () {
            if (preTestController.selectedAnswerIndex.value == null) {
              showValidationMessage();
            } else {
              preTestController.nextQuestion();
            }
          },
          child: Container(
            width: AppConstants().mediaSize.width * 0.3,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Center(
              child: Text(
                'Next',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500, color: Colors.purple),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedAnswer(Map<String, dynamic> question, String key) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return question['${key}_ml'] ?? question[key].toString();
      case 'hi':
        return question['${key}_hi'] ?? question[key].toString();
      case 'ta':
        return question['${key}_ta'] ?? question[key].toString();
      default:
        return question[key] ?? '';
    }
  }

  String _getLocalizedQuestion(Map<String, dynamic> question) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return question['question_ml'] ?? question['question'].toString();
      case 'hi':
        return question['question_hi'] ?? question['question'].toString();
      case 'ta':
        return question['question_ta'] ?? question['question'].toString();
      default:
        return question['question']!;
    }
  }
}
