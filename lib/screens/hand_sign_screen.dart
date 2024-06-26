import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/handsign_controller.dart';
import 'package:license_master/custom_widgets/c_card.dart';
import 'package:license_master/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../custom_widgets/c_appbar.dart';

class HandSignScreen extends StatelessWidget {
  final HandSignController handSignController = Get.put(HandSignController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await handSignController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Hand Sign",
        onRefresh: (){
          handSignController.fetchData();
          print("Api call success");
        },
        onLanguageSelected: (String value) {
          print('App Language :: $value');
          appStorage.write(AppConstants().appLang, value);
          handSignController.onInit();
        },
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: GlobalDecoration.containerDecoration,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
              () {
            if (handSignController.handSigns.isEmpty) {
              return Center(
                child: LoadingAnimationWidget.flickr(
                  size: 50,
                  leftDotColor: Colors.blue,
                  rightDotColor: Colors.red,
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: handSignController.handSigns.length,
                itemBuilder: (context, index) {
                  final handSign = handSignController.handSigns[index];
                  String title = _getLocalizedTitle(handSign);
                  String description = _getLocalizedDescription(handSign);

                  return CCard(
                    imageUrl: handSign['imageUrl']!,
                    name: title,
                    description: description,
                    index: index,
                    color: Colors.blue.withOpacity(0.5),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
  String _getLocalizedTitle(Map<String, String> handsign) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return handsign['title_ml'] ?? handsign['title'].toString();
      case 'hi':
        return handsign['title_hi'] ?? handsign['title'].toString();
      case 'ta':
        return handsign['title_ta'] ?? handsign['title'].toString();
      default:
        return handsign['title']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> handsign) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return handsign['description_ml'] ?? handsign['description'].toString();
      case 'hi':
        return handsign['description_hi'] ?? handsign['description'].toString();
      case 'ta':
        return handsign['description_ta'] ?? handsign['description'].toString();
      default:
        return handsign['description']!;
    }
  }
}
