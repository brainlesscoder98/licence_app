import 'package:get/get.dart';
import 'package:license_master/main.dart';
import '../app_constants/app_constants.dart';
import '../core/services/firebase_service.dart';
import 'dart:async';

class TimerTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<int>();
  var isCompleted = false.obs;
  var pretest = <Map<String, dynamic>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();
  Timer? timer;
  var secondsRemaining = 5.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchPreTestQuestions();
    pretest.value = data;
    startTimer();
  }

  void startTimer() {
    secondsRemaining.value = 5;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        checkAnswer(null, false); // No answer selected, count as wrong
        nextQuestion();
      }
    });
  }

  void checkAnswer(int? selectedAnswerIndex, bool correctAnswer) {
    this.selectedAnswerIndex.value = selectedAnswerIndex;
    if (selectedAnswerIndex != null) {
      if (correctAnswer) {
        correctAnswersCount++;
        print("Selected answer is correct");
      } else {
        wrongAnswersCount++;
        print("Selected answer is wrong");
      }
    } else {
      wrongAnswersCount++;
      print("No answer selected, count as wrong");
    }
    timer?.cancel();
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < pretest.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex.value = null; // Reset the selected answer for the next question
      startTimer(); // Start timer for the next question
    } else {
      isCompleted.value = true;
      timer?.cancel();
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    correctAnswersCount.value = 0;
    wrongAnswersCount.value = 0;
    selectedAnswerIndex.value = null;
    isCompleted.value = false;
    startTimer();
  }

  String getResultMessage() {
    double correctPercentage = (correctAnswersCount.value / pretest.length) * 100;
    return correctPercentage >= 60 ? 'Pass' : 'Fail';

  }

  String getLocalizedQuestion(Map<String, dynamic> questionData) {
    String question = questionData['question']?.toString() ?? 'No question';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return questionData['question_ml']?.toString() ?? question;
      case 'hi':
        return questionData['question_hi']?.toString() ?? question;
      case 'ta':
        return questionData['question_ta']?.toString() ?? question;
      default:
        return question;
    }
  }

  String getLocalizedAnswer(Map<String, dynamic> answerData) {
    String answerOne = answerData['answer_one']?.toString() ?? 'No option';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return answerData['answer_one_ml']?.toString() ?? answerOne;
      case 'hi':
        return answerData['answer_one_hi']?.toString() ?? answerOne;
      case 'ta':
        return answerData['answer_one_ta']?.toString() ?? answerOne;
      default:
        return answerOne;
    }
  }

  String getLocalizedCorrectAnswer(Map<String, dynamic> answerData) {
    String answerOne = answerData['answer']?.toString() ?? 'No option';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return answerData['answer_ml']?.toString() ?? answerOne;
      case 'hi':
        return answerData['answer_hi']?.toString() ?? answerOne;
      case 'ta':
        return answerData['answer_ta']?.toString() ?? answerOne;
      default:
        return answerOne;
    }
  }
}
