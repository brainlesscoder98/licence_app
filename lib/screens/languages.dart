import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/controller/home_controller.dart';
import 'package:licence_app/main.dart';

import '../app_constants/app_constants.dart';

class LanguageScreen extends StatefulWidget {

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 0, 20, 21),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 20, 21),
                Color.fromARGB(255, 0, 0, 0), // Black
                // Dark Teal
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Languages",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 20, 21),
              Color.fromARGB(255, 0, 0, 0), // Black
              // Dark Teal
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: ListView.builder(
            itemCount: homeController.languages.length,
            itemBuilder: (BuildContext context, int index) {
              final language = homeController.languages[index];
              return GestureDetector(
                onTap: (){
                  appStorage.write(AppConstants().appLang, language['short_name']!);
                  setState(() {

                  });
                },
                child: Container(
                  width: Get.width,
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 7.5),
                  decoration: BoxDecoration(
                    color:appStorage.read(AppConstants().appLang.toString())==language['short_name'].toString()? Colors.teal:Colors.transparent,
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text(language['title']!,style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),)),
                ),
              );
            },
          ),
        ),
      ),
    );

  }
}
