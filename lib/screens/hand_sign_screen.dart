import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/handsign_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

class HandSignScreen extends StatelessWidget {
  final HandSignController handSignController = Get.put(HandSignController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Hand Sign",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(

        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child:  Obx((){
          if (handSignController.handSigns.isEmpty) {
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
                  itemCount: handSignController.handSigns.length,
                  itemBuilder: (context, index) {
                    final handSign = handSignController.handSigns[index];
                    return CCard(
                      imageUrl: handSign['imageUrl']!,
                      name: handSign['title']!,
                      description: handSign['description']!,
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
