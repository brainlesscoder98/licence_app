import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

import '../custom_widgets/c_questions.dart';

class QuestionsScreen extends StatelessWidget {
  QuestionsScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> signboards = [
    {
      'name': 'Signboard 1',
      'description': 'Description for Signboard 1'
    },
    {
      'name': 'Signboard 2',
      'description': 'Description for Signboard 2'
    },
    {
      'name': 'Signboard 3',
      'description': 'Description for Signboard 3'
    },{
      'name': 'Signboard 4',
      'description': 'Description for Signboard 4'
    },{
      'name': 'Signboard 5',
      'description': 'Description for Signboard 5'
    },{
      'name': 'Signboard 6',
      'description': 'Description for Signboard 6'
    },{
      'name': 'Signboard 7',
      'description': 'Description for Signboard 7'
    },{
      'name': 'Signboard 8',
      'description': 'Description for Signboard 8'
    },{
      'name': 'Signboard 9',
      'description': 'Description for Signboard 9'
    },
    // Add more signboard data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Questions",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(

        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: ListView(
          children: [
            Container(
              height: AppConstants().mediaSize.height-128,
              width: AppConstants().mediaSize.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: signboards.length,
                itemBuilder: (context, index) {
                  final signboard = signboards[index];
                  return CQuestions(
                    name: signboard['name']!,
                    description: signboard['description']!,
                    index: index,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
