import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/controller/questions_controller.dart';
import 'package:license_master/controller/translator_controller.dart';
import 'package:license_master/controller/signboard_controller.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/custom_widgets/c_questions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../custom_widgets/c_appbar.dart';
import '../main.dart';

class QuestionsScreen extends StatelessWidget {
  final QuestionController questionController = Get.put(QuestionController());
  final TranslationController translationController = Get.put(TranslationController());
  final HomeController homeController = Get.put(HomeController());
  Future<void> _refreshData() async {
    await questionController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Questions",
        onLanguageSelected: (String value) {
          print('App Language :: $value');
          appStorage.write(AppConstants().appLang, value);
          questionController.onInit();
        },
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: GlobalDecoration.containerDecoration,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (questionController.questions.isEmpty) {
            return Center(child: LoadingAnimationWidget.flickr(
              size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
            ));
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: questionController.questions.length,
              itemBuilder: (context, index) {
                final resultQuestionText = questionController.getLocalizedQuestion(questionController.questions[index]);
                final resultAnswerText = questionController.getLocalizedCorrectAnswer(questionController.questions[index]);
                return CQuestions(
                  name: resultQuestionText,
                  description: resultAnswerText,
                  index: index,
                  color: Colors.white,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
