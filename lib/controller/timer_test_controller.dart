import 'dart:async';
import 'package:get/get.dart';

class TimerTestController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var correctAnswersCount = 0.obs;
  var wrongAnswersCount = 0.obs;
  var selectedAnswerIndex = Rxn<int>();
  var isCompleted = false.obs;
  var timeLeft = 5.obs; // Timer for each question

  Timer? _timer;

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

  @override
  void onInit() {
    super.onInit();
    startTimer(); // Start the timer when the controller is initialized
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any previous timer
    timeLeft.value = 5; // Reset the timer to 30 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        _timer?.cancel();
        autoSelectCorrectAnswer();
      }
    });
  }

  void autoSelectCorrectAnswer() {
    final correctIndex = questions[currentQuestionIndex.value].correctAnswerIndex;
    if (selectedAnswerIndex.value == null) {
      selectedAnswerIndex.value = correctIndex;
      wrongAnswersCount++;
    }
  }

  void checkAnswer(int selectedIndex) {
    selectedAnswerIndex.value = selectedIndex;
    if (selectedIndex == questions[currentQuestionIndex.value].correctAnswerIndex) {
      correctAnswersCount++;
    } else {
      wrongAnswersCount++;
    }
    _timer?.cancel(); // Stop the timer when an answer is selected
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex++;
      selectedAnswerIndex.value = null; // Reset the selected answer for the next question
      startTimer(); // Restart the timer for the next question
    } else {
      isCompleted.value = true;
      _timer?.cancel(); // Stop the timer when the quiz is completed
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    correctAnswersCount.value = 0;
    wrongAnswersCount.value = 0;
    selectedAnswerIndex.value = null;
    isCompleted.value = false;
    startTimer(); // Restart the timer for the first question
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
