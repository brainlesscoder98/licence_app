import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_constants/app_constants.dart';
import '../controller/signboard_controller.dart';
import '../custom_widgets/c_questions.dart';

class QuestionsScreen extends StatelessWidget {
  final SignboardController signboardController = Get.put(SignboardController());

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
        title: Text(
          "Questions",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            iconColor: Colors.white,
            onSelected: (String value) {
              // Handle language selection
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
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
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
          );
        }),
      ),
    );
  }
}
