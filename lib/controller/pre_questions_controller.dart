import 'package:get/get.dart';
import 'package:license_master/main.dart';
import '../app_constants/app_constants.dart';
import '../core/services/firebase_service.dart';

class PreQuestionController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<String>();
  var isCompleted = false.obs;
  var pretest = <Map<String, dynamic>>[].obs;
  var filteredQuestions = <Map<String, dynamic>>[].obs;
  var filteredQuestionsCount = 0.obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchPreTestQuestions();
    pretest.value = data;
    filteredQuestions.value = data.where((q) => q['question_type'] == "1").toList();
    filteredQuestionsCount.value = filteredQuestions.length;
  }

  void checkAnswer(String? selectedAnswerIndex, String? correctAnswerIndex) {
    this.selectedAnswerIndex.value = selectedAnswerIndex;

    // Check if both selectedAnswerIndex and correctAnswerIndex are not null
    if (selectedAnswerIndex != null && correctAnswerIndex != null) {
      if (selectedAnswerIndex == correctAnswerIndex) {
        correctAnswersCount++;
        print("Selected answer is correct");
      } else {
        wrongAnswersCount++;
        print("Selected answer is wrong");
      }
    } else {
      wrongAnswersCount++;
      print("No answer selected or correct answer not provided, count as wrong");
    }
  }


  void nextQuestion() {
    if (currentQuestionIndex.value < filteredQuestions.length - 1) {
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
    double correctPercentage = (correctAnswersCount.value / filteredQuestions.length) * 100;
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
