import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

import '../controller/questions_controller.dart';

class CQuestions extends StatelessWidget {
  final QuestionController questionController = Get.put(QuestionController());

  final String name;
  final String description;
  final int index;
  final Color color;

   CQuestions({
    Key? key,
    required this.name,
    required this.description,
    required this.index,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final queText = questionController.getLocalizedQuestionText(questionController.questions[index]);
    final ansText = questionController.getLocalizedAnswerText(questionController.questions[index]);

    return Container(
        width: AppConstants().mediaSize.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${index+1}. $queText\n',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  WidgetSpan(child: HGap(width: 20,)),
                  TextSpan(
                    text: name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const VGap(height: 5),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$ansText:\n',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  WidgetSpan(child: HGap(width: 20,)),
                  TextSpan(
                    text: description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        );
  }
}
