import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/handsign_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';

class HandSignScreen extends StatelessWidget {
  final HandSignController handSignController = Get.put(HandSignController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await handSignController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
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
                handSignController.onInit();
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
        title: Text(
          "Hand Sign",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
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
                    color: Colors.white,
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
