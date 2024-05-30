import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class PreTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<String>();
  var isCompleted = false.obs;
  var pretest = <Map<String, dynamic>>[].obs;
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

  void checkAnswer(String selectedAnswer, String correctAnswer) {
    selectedAnswerIndex.value = selectedAnswer;
    if (selectedAnswer == correctAnswer) {
      correctAnswersCount++;
      print("Selected answer is correct");
    } else {
      wrongAnswersCount++;
      print("Selected answer is wrong");
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
