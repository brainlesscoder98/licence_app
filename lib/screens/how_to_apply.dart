import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/howto_apply_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../main.dart';

class HowToApplyScreen extends StatelessWidget {
  final HowtoApplyController howtoApplyController = Get.put(HowtoApplyController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await howtoApplyController.fetchData(); // Example: fetching data again
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        actions: [
          Obx(() {
            if (homeController.languages.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return PopupMenuButton<String>(
              color: Colors.white,
              iconColor: Colors.white,
              onSelected: (String value) {
                // translateStaticData(value);
                print('App Language :: $value');
                appStorage.write(AppConstants().appLang, value);
                howtoApplyController.onInit();
              },
              itemBuilder: (BuildContext context) {
                return homeController.languages.map((language) {
                  return PopupMenuItem(
                    value: language['short_name']!,
                    child: Text(language['title']!),
                  );
                }).toList();
              },
            );
          }),
        ],
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
                  final howtoapply = howtoApplyController.notes[index];
                  String title = _getLocalizedTitle(howtoapply);
                  String subTitle = _getLocalizedDescription(howtoapply);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const VGap(height: 15),
                      Text(title.toString(),style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white,),textAlign: TextAlign.left),
                      const VGap(height: 5),
                      Text(subTitle.toString(),style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.white,),textAlign: TextAlign.left),

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
  String _getLocalizedTitle(Map<String, String> howtoapply) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return howtoapply['title_ml'] ?? howtoapply['title'].toString();
      case 'hi':
        return howtoapply['title_hi'] ?? howtoapply['title'].toString();
      case 'ta':
        return howtoapply['title_ta'] ?? howtoapply['title'].toString();
      default:
        return howtoapply['title']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> howtoapply) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return howtoapply['sub_title_ml'] ?? howtoapply['sub_title'].toString();
      case 'hi':
        return howtoapply['sub_title_hi'] ?? howtoapply['sub_title'].toString();
      case 'ta':
        return howtoapply['sub_title_ta'] ?? howtoapply['sub_title'].toString();
      default:
        return howtoapply['sub_title']!;
    }
  }
}
