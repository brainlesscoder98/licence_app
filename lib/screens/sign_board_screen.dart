import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

import '../controller/signboard_controller.dart';

class SignBoardScreen extends StatelessWidget {
  final SignboardController signboardController = Get.put(SignboardController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Sign Board",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(

        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (signboardController.signboards.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: [
              Container(
                height: AppConstants().mediaSize.height-128,
                width: AppConstants().mediaSize.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: signboardController.signboards.length,
                  itemBuilder: (context, index) {
                    final signboard = signboardController.signboards[index];
                    return CCard(
                      imageUrl: signboard['imageUrl']!,
                      name: signboard['name']!,
                      description: signboard['description']!,
                      index: index,
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ],
          );
        })
      ),
    );
  }
}
