import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/home_controller.dart';
import '../controller/signboard_controller.dart';
import '../custom_widgets/c_card.dart';
import '../app_constants/app_constants.dart';
import '../main.dart';

class SignBoardScreen extends StatelessWidget {
  final SignboardController signboardController = Get.put(SignboardController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await signboardController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    print("Selected App Language is ::: ${appStorage.read(AppConstants().appLang)}");

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
                signboardController.onInit();
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
          "Sign Board",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(color: Colors.black),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          if (signboardController.signboards.isEmpty) {
            return Center(
              child: LoadingAnimationWidget.flickr(
                size: 50,
                leftDotColor: Colors.blue,
                rightDotColor: Colors.red,
              ),
            );
          }

          return Container(
            height: AppConstants().mediaSize.height - 128,
            width: AppConstants().mediaSize.width,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: signboardController.signboards.length,
                itemBuilder: (context, index) {
                  final signboard = signboardController.signboards[index];
                  String name = _getLocalizedName(signboard);
                  String description = _getLocalizedDescription(signboard);

                  return CCard(
                    imageUrl: signboard['imageUrl']!,
                    name: name,
                    description: description,
                    index: index,
                    color: Colors.white,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  String _getLocalizedName(Map<String, String> signboard) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return signboard['name_ml'] ?? signboard['name'].toString();
      case 'hi':
        return signboard['name_hi'] ?? signboard['name'].toString();
      case 'ta':
        return signboard['name_ta'] ?? signboard['name'].toString();
      default:
        return signboard['name']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> signboard) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return signboard['description_ml'] ?? signboard['description'].toString();
      case 'hi':
        return signboard['description_hi'] ?? signboard['description'].toString();
      case 'ta':
        return signboard['description_ta'] ?? signboard['description'].toString();
      default:
        return signboard['description']!;
    }
  }
}
