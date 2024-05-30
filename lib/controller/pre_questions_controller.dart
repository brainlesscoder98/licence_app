import 'package:get/get.dart';
import '../app_constants/app_constants.dart';
import '../core/services/firebase_service.dart';
import '../main.dart';

class PreQuestionsController extends GetxController {
  var pretest = <Map<String, dynamic>>[].obs;
  var selectedAnswers = <int, int>{}.obs;
  var currentQuestionIndex = 0.obs;
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

  void selectAnswer(int questionIndex, int answerIndex) {
    selectedAnswers[questionIndex] = answerIndex;
    update();
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < pretest.length - 1) {
      currentQuestionIndex++;
      // Reset selected answer for the next question
      selectedAnswers.remove(currentQuestionIndex);
      update();
    }
  }

  bool isCorrectAnswer(int questionIndex) {
    return selectedAnswers[questionIndex] == pretest[questionIndex]['correct_answer'];
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
}
