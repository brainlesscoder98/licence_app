import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/rtocodes_controller.dart';
import 'package:license_master/custom_widgets/c_card.dart';
import 'package:license_master/custom_widgets/c_table.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../custom_widgets/c_appbar.dart';
import '../main.dart';

class RtoCodeScreen extends StatelessWidget {
  final RTOCodesController rtoCodesController = Get.put(RTOCodesController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await rtoCodesController.fetchData(); // Example: fetching data again
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: "RTO Code",
          onRefresh: (){
            rtoCodesController.fetchData();
            print("Api call success");
          },
          onLanguageSelected: (String value) {
            print('App Language :: $value');
            appStorage.write(AppConstants().appLang, value);
            rtoCodesController.onInit();
          },
        ),
      body: Container(
        height: AppConstants().mediaSize.height,
        // decoration: GlobalDecoration.containerDecoration,
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (rtoCodesController.rtoCodes.isEmpty) {
            return Center(child: LoadingAnimationWidget.flickr(
              size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
            ));
          }
          return Container(
            height: AppConstants().mediaSize.height,
            width: AppConstants().mediaSize.width,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: rtoCodesController.rtoCodes.length,
                itemBuilder: (context, index) {
                  final rtocodes = rtoCodesController.rtoCodes[index];
                  String title = _getLocalizedTitle(rtocodes);
                  String description = _getLocalizedDescription(rtocodes);

                  return CTable(
                    name: title,
                    code: description,
                    index: index,
                    color: Colors.blue.withOpacity(0.5),
                  );
                },
              ),
            ),
          );
        }),
      )
    );
  }
  String _getLocalizedTitle(Map<String, String> rtocode) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return rtocode['title_ml'] ?? rtocode['title'].toString();
      case 'hi':
        return rtocode['title_hi'] ?? rtocode['title'].toString();
      case 'ta':
        return rtocode['title_ta'] ?? rtocode['title'].toString();
      default:
        return rtocode['title']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> rtocode) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return rtocode['description_ml'] ?? rtocode['description'].toString();
      case 'hi':
        return rtocode['description_hi'] ?? rtocode['description'].toString();
      case 'ta':
        return rtocode['description_ta'] ?? rtocode['description'].toString();
      default:
        return rtocode['description']!;
    }
  }
}
