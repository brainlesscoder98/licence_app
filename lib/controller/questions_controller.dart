import 'package:get/get.dart';

class QuestionController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<int>();
  var isCompleted = false.obs;

  List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      answers: ['Berlin', 'Madrid', 'Paris'],
      correctAnswerIndex: 2,
    ),
    Question(
      questionText: 'What is 2 + 2?',
      answers: ['3', '4', '5'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'Which is the largest ocean?',
      answers: ['Indian Ocean', 'Pacific Ocean', 'Atlantic Ocean'],
      correctAnswerIndex: 1,
    ),
  ];

  void checkAnswer(int selectedIndex) {
    selectedAnswerIndex.value = selectedIndex;
    if (selectedIndex == questions[currentQuestionIndex.value].correctAnswerIndex) {
      correctAnswersCount++;
    } else {
      wrongAnswersCount++;
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
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
    double correctPercentage = (correctAnswersCount.value / questions.length) * 100;
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
