import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/controller/translator_controller.dart';
import 'package:licence_app/controller/signboard_controller.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_questions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuestionsScreen extends StatelessWidget {
  final SignboardController signboardController = Get.put(SignboardController());
  final TranslationController translationController = Get.put(TranslationController());

  Future<void> _refreshData() async {
    await signboardController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () { Get.back(); },
        ),
        title: Obx(() {
          return Text(
            translationController.getTranslated('Questions'),
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          );
        }),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            iconColor: Colors.white,
            onSelected: (String value) {

            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: 'en', child: Text('English')),
                PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
                PopupMenuItem(value: 'ml', child: Text('മലയാളം')),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (signboardController.signboards.isEmpty) {
            return Center(child: LoadingAnimationWidget.flickr(
              size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
            ));
          }
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: signboardController.signboards.length,
              itemBuilder: (context, index) {
                final signboard = signboardController.signboards[index];
                return CQuestions(
                  name: signboard['name']!,
                  description: signboard['description']!,
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
