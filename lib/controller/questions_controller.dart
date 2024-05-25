import 'package:get/get.dart';

import '../core/services/firebase_service.dart';

class QuestionController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<int>();
  var isCompleted = false.obs;

  var pretest = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();


  // void checkAnswer(int selectedIndex) {
  //   selectedAnswerIndex.value = selectedIndex;
  //   if (selectedIndex == questions[currentQuestionIndex.value].correctAnswerIndex) {
  //     correctAnswersCount++;
  //   } else {
  //     wrongAnswersCount++;
  //   }
  // }

  // void nextQuestion() {
  //   if (currentQuestionIndex < questions.length - 1) {
  //     currentQuestionIndex++;
  //     selectedAnswerIndex.value = null; // Reset the selected answer for the next question
  //   } else {
  //     isCompleted.value = true;
  //   }
  // }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    correctAnswersCount.value = 0;
    wrongAnswersCount.value = 0;
    selectedAnswerIndex.value = null;
    isCompleted.value = false;
  }

  // String getResultMessage() {
  //   double correctPercentage = (correctAnswersCount.value / questions.length) * 100;
  //   return correctPercentage >= 60 ? 'Pass' : 'Fail';
  // }
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
