import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/roadsign_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../main.dart';

class RoadSignScreen extends StatelessWidget {
  final RoadSignController roadSignController = Get.put(RoadSignController());
  Future<void> _refreshData() async {
    await roadSignController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Road Sign",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body:Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (roadSignController.roadSigns.isEmpty) {
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
                itemCount: roadSignController.roadSigns.length,
                itemBuilder: (context, index) {
                  final roadSign = roadSignController.roadSigns[index];
                  String title = _getLocalizedTitle(roadSign);
                  String description = _getLocalizedDescription(roadSign);

                  return CCard(
                    imageUrl: roadSign['imageUrl']!,
                    name: title,
                    description: description,
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
  String _getLocalizedTitle(Map<String, String> roadsign) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return roadsign['title_ml'] ?? roadsign['title'].toString();
      case 'hi':
        return roadsign['title_hi'] ?? roadsign['title'].toString();
      case 'ta':
        return roadsign['title_ta'] ?? roadsign['title'].toString();
      default:
        return roadsign['title']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> roadsign) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return roadsign['description_ml'] ?? roadsign['description'].toString();
      case 'hi':
        return roadsign['description_hi'] ?? roadsign['description'].toString();
      case 'ta':
        return roadsign['description_ta'] ?? roadsign['description'].toString();
      default:
        return roadsign['description']!;
    }
  }
}
