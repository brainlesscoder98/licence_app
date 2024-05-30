import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:licence_app/controller/pre_questions_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

import '../app_constants/app_constants.dart';
import '../main.dart';

class PreQuestionScreen extends StatelessWidget {
  final PreQuestionsController preQuestionsController = Get.put(PreQuestionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Obx(() {
          if (preQuestionsController.pretest.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final currentQuestionIndex = preQuestionsController.currentQuestionIndex.value;
          final questionData = preQuestionsController.pretest[currentQuestionIndex];
          final questionText = preQuestionsController.getLocalizedQuestion(questionData);
          final answers = questionData['answers'] ?? [];
          final selectedAnswerIndex = preQuestionsController.selectedAnswers[currentQuestionIndex];
          final isAnswered = selectedAnswerIndex != null;
          final isCorrect = isAnswered && preQuestionsController.isCorrectAnswer(currentQuestionIndex);

          return ListView(
            padding: EdgeInsets.all(15.0),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '${currentQuestionIndex + 1}. $questionText',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: answers.length,
                      itemBuilder: (context, answerIndex) {
                        final answerData = answers[answerIndex];
                        final answerText = preQuestionsController.getLocalizedAnswer(answerData);
                        final isSelected = selectedAnswerIndex == answerIndex;

                        // Determine the color based on selection and correctness
                        Color containerColor = Colors.grey;
                        if (isAnswered && isSelected) {
                          containerColor = isCorrect ? Colors.green : Colors.red;
                        } else if (isSelected) {
                          containerColor = Colors.blue; // Color for selected but not answered
                        }

                        return GestureDetector(
                          onTap: isAnswered ? null : () =>preQuestionsController.onAnswerSelected(currentQuestionIndex, answerIndex),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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

                    VGap(height: 10)
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isAnswered ? () => preQuestionsController.moveToNextQuestion() : null,
                child: Text('Next'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
