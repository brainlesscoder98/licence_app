import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/timer_test_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

class TimerTestScreen extends StatelessWidget {
  final TimerTestController timerTestController = Get.put(TimerTestController());

  Future<void> _refreshData() async {
    await timerTestController.fetchData();
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
            timerTestController.resetQuiz();
            Get.back();
          },
        ),
        actions: [
          Obx(() {
            return (timerTestController.isCompleted.value)
                ? const HGap(width: 0)
                : _buildScoreCounters();
          }),
        ],
        title: Obx(() {
          return Text(
            timerTestController.isCompleted.value
                ? "Timer Test Completed"
                : "Timer Test Screen",
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textAlign: TextAlign.left,
          );
        }),
      ),
      body: Obx(() {
        return timerTestController.isCompleted.value
            ? _buildCompletionScreen(context)
            : _buildQuestionScreen(context);
      }),
    );
  }

  Widget _buildScoreCounters() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          _buildScoreCounter(
            type: '',
            score: timerTestController.correctAnswersCount.value,
            color: Colors.green,
          ),
          SizedBox(width: 10),
          _buildScoreCounter(
            type: '',
            score: timerTestController.wrongAnswersCount.value,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCounter({required int score, required String type, required Color color}) {
    return Container(
      width: type == '' ? 60 : AppConstants().mediaSize.width * 0.3,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$type $score',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen(BuildContext context) {
    return Stack(
      children: [
        if (timerTestController.getResultMessage() == 'Pass')
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
              timerTestController.getResultMessage(),
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: timerTestController.getResultMessage() == 'Pass'
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScoreCounter(
                  type: 'Correct:',
                  score: timerTestController.correctAnswersCount.value,
                  color: Colors.green,
                ),
                _buildScoreCounter(
                  type: 'Wrong:',
                  score: timerTestController.wrongAnswersCount.value,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: timerTestController.pretest.length,
                itemBuilder: (context, index) {
                  final question = timerTestController.pretest[index];
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

  Widget _buildQuestionResult(Map<String, String> question, int index) {
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
            '${index + 1}: ${question['question']}',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white,fontWeight:FontWeight.w500),
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
              question['answer'].toString(),
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
        timerTestController.resetQuiz();
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
    return Column(
      children: [
        SizedBox(height: 20),
        Obx(() => Text(
          timerTestController.isTimeUp.value ? "Time ends" : 'Time Remaining: ${timerTestController.remainingTime.value}s',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        )),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            children: [
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${timerTestController.currentQuestionIndex.value + 1}: ${timerTestController.pretest[timerTestController.currentQuestionIndex.value]['question']}',
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 20),
              _buildOption(context,
                  timerTestController.pretest[timerTestController.currentQuestionIndex.value]['option_one'].toString()),
              SizedBox(height: 20),
              _buildOption(context,
                  timerTestController.pretest[timerTestController.currentQuestionIndex.value]['option_two'].toString()),
              SizedBox(height: 20),
              _buildOption(context,
                  timerTestController.pretest[timerTestController.currentQuestionIndex.value]['option_three'].toString()),
              SizedBox(height: 40),
              _buildNavigationButtons(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String option) {
    bool isSelected = timerTestController.selectedAnswerIndex.value == option;
    bool isCorrect = option == timerTestController.pretest[timerTestController.currentQuestionIndex.value]['answer'];
    bool showCorrect = timerTestController.showCorrectAnswer.value;
    Color optionColor;

    if (showCorrect && isCorrect) {
      optionColor = Colors.green;
    } else if (isSelected) {
      optionColor = isCorrect ? Colors.green : Colors.red;
    } else {
      optionColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        timerTestController.checkAnswer(
            option,
            timerTestController.currentQuestionIndex.value,
            timerTestController.pretest[timerTestController.currentQuestionIndex.value]['answer'].toString());
        if (timerTestController.autoNext.value) {
          Future.delayed(Duration(seconds: 2), timerTestController.nextQuestion);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,

        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: optionColor,
        ),
        child: Text(
          option,
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
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
            timerTestController.resetQuiz();
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
            if (timerTestController.autoNext.value) {
              timerTestController.nextQuestion();
            } else if (timerTestController.selectedAnswerIndex.value == null) {
              showValidationMessage();
            } else {
              timerTestController.nextQuestion();
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
}
