import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../core/services/firebase_service.dart';

class TimerTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<String>();
  var isCompleted = false.obs;
  var isAnswerCorrect = false.obs;
  var showCorrectAnswer = false.obs;
  var remainingTime = 5.obs;
  var isTimeUp = false.obs;
  var autoNext = false.obs; // Add this to control auto navigation
  var pretest = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();
  Timer? _timer;
  final int questionDuration = 5; // in seconds

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchPreTestQuestions();
    pretest.value = data;
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    remainingTime.value = questionDuration;
    isTimeUp.value = false;
    autoNext.value = false; // Reset autoNext for each question
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        _timer?.cancel();
        isTimeUp.value = true;
        showCorrectAnswer.value = true;
        autoNext.value = true; // Set autoNext to true
        markAnswerAsWrong(); // Mark the answer as wrong
        update(); // Notify the UI
        Future.delayed(Duration(seconds: 2), nextQuestion); // Move to next question after showing the correct answer for 2 seconds
      }
    });
  }

  void checkAnswer(String selectedAnswer, int index, String correctAnswer) {
    if (!isTimeUp.value) {
      selectedAnswerIndex.value = selectedAnswer;
      if (selectedAnswer == correctAnswer) {
        correctAnswersCount++;
        isAnswerCorrect.value = true;
        print("Selected answer is correct");
      } else {
        wrongAnswersCount++;
        isAnswerCorrect.value = false;
        showCorrectAnswer.value = true;
        print("Selected answer is wrong");
      }
      _timer?.cancel();
      update(); // Notify the UI
    }
  }

  void markAnswerAsWrong() {
    wrongAnswersCount++;
    isAnswerCorrect.value = false;
    showCorrectAnswer.value = true;
    print("Time's up, marking answer as wrong");
    update(); // Notify the UI
  }

  void nextQuestion() {
    if (currentQuestionIndex < pretest.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex.value = null; // Reset the selected answer for the next question
      showCorrectAnswer.value = false;
      startTimer(); // Restart the timer for the next question
    } else {
      isCompleted.value = true;
      _timer?.cancel();
    }
    update(); // Notify the UI
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    correctAnswersCount.value = 0;
    wrongAnswersCount.value = 0;
    selectedAnswerIndex.value = null;
    isCompleted.value = false;
    showCorrectAnswer.value = false;
    startTimer(); // Restart the timer for the new quiz
    update(); // Notify the UI
  }

  String getResultMessage() {
    double correctPercentage = (correctAnswersCount.value / pretest.length) * 100;
    return correctPercentage >= 60 ? 'Pass' : 'Fail';
  }
}
