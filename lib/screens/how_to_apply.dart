import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/howto_apply_controller.dart';
import 'package:license_master/custom_widgets/c_card.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../custom_widgets/c_appbar.dart';
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
      backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: "How to apply",
          onRefresh: (){
            howtoApplyController.fetchData();
            print("Api call success");
          },
          onLanguageSelected: (String value) {
            print('App Language :: $value');
            appStorage.write(AppConstants().appLang, value);
            howtoApplyController.onInit();
          },
        ),
      body:Container(
        height: AppConstants().mediaSize.height,
        // decoration: GlobalDecoration.containerDecoration,
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
