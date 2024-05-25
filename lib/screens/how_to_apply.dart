import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/howto_apply_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HowToApplyScreen extends StatelessWidget {
  final HowtoApplyController howtoApplyController = Get.put(HowtoApplyController());
  Future<void> _refreshData() async {
    await howtoApplyController.fetchData(); // Example: fetching data again
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "How to apply",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body:Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (howtoApplyController.notes.isEmpty) {
            return Center(child: LoadingAnimationWidget.flickr(
              size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
            ));
          }
          return Container(
            height: AppConstants().mediaSize.height-128,
            width: AppConstants().mediaSize.width,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: howtoApplyController.notes.length,
                itemBuilder: (context, index) {
                  final notes = howtoApplyController.notes[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const VGap(height: 15),
                      Text( notes['title'].toString(),style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white,),textAlign: TextAlign.left),
                      const VGap(height: 5),
                      Text( notes['sub_title'].toString(),style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white,),textAlign: TextAlign.left),

                    ],
                  );
                },
              ),
            ),
          );
        }),
      )
    );
  }
}
