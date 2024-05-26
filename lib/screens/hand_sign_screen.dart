import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/controller/handsign_controller.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HandSignScreen extends StatelessWidget {
  final HandSignController handSignController = Get.put(HandSignController());

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
                  String name = '';
                  String description = '';
                  switch (appStorage.read(AppConstants().appLang.toString())){
                    case 'ml':
                      name = handSign['title_ml'] ?? handSign['title'].toString();
                      description = handSign['description_ml'] ??  handSign['description'].toString();
                      break;
                    default:
                      name = handSign['title']!;
                      description = handSign['description']!;
                  }
                  return CCard(
                    imageUrl: handSign['imageUrl']!,
                    name: name,
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
}
