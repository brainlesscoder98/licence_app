import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/rtocodes_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RtoCodeScreen extends StatelessWidget {
  final RTOCodesController rtoCodesController = Get.put(RTOCodesController());
  Future<void> _refreshData() async {
    await rtoCodesController.fetchData(); // Example: fetching data again
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "RTO CODE",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (rtoCodesController.rtoCodes.isEmpty) {
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
                itemCount: rtoCodesController.rtoCodes.length,
                itemBuilder: (context, index) {
                  final roadSign = rtoCodesController.rtoCodes[index];
                  return CCard(
                    imageUrl: roadSign['imageUrl']!,
                    name: roadSign['title']!,
                    description: roadSign['description']!,
                    index: index,
                    color: Colors.white,
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
