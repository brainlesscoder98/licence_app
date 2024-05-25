import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/firebase_service.dart';

class PreTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<String>();
  var isCompleted = false.obs;
  Color? buttonColor ;
  var pretest = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchPreTestQuestions();
    pretest.value = data;
  }
  void checkAnswer(String selectedAnswer,int index,String correctAnswer) {
    selectedAnswerIndex.value = selectedAnswer;
    if (selectedAnswer == correctAnswer ) {
      correctAnswersCount++;
      print("selected answer is correct");
    } else {
      wrongAnswersCount++;
      print("selected answer is wrong");
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < pretest.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex.value = null; // Reset the selected answer for the next question
    } else {
      isCompleted.value = true;
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    correctAnswersCount.value = 0;
    wrongAnswersCount.value = 0;
    selectedAnswerIndex.value = null;
    isCompleted.value = false;
  }

  String getResultMessage() {
    double correctPercentage = (correctAnswersCount.value / pretest.length) * 100;
    return correctPercentage >= 60 ? 'Pass' : 'Fail';
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}
