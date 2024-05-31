import 'package:get/get.dart';

import '../app_constants/app_constants.dart';
import '../core/services/firebase_service.dart';
import '../main.dart';

class QuestionController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  var questions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchPreTestQuestions();
    questions.value = data;
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
  String getLocalizedQuestionText(Map<String, dynamic> questionData) {
    String question = questionData['question_text']?.toString() ?? 'No question';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return questionData['question_text_ml']?.toString() ?? question;
      case 'hi':
        return questionData['question_text_hi']?.toString() ?? question;
      case 'ta':
        return questionData['question_text_ta']?.toString() ?? question;
      default:
        return question;
    }
  }
  String getLocalizedAnswerText(Map<String, dynamic> questionData) {
    String question = questionData['answer_text']?.toString() ?? 'No question';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return questionData['answer_text_ml']?.toString() ?? question;
      case 'hi':
        return questionData['answer_text_hi']?.toString() ?? question;
      case 'ta':
        return questionData['answer_text_ta']?.toString() ?? question;
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

