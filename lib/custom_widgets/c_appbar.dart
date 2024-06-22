import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/main.dart';

import '../app_constants/app_constants.dart';
import '../controller/home_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(String) onLanguageSelected;

  CustomAppBar({
    required this.title,
    required this.onLanguageSelected,
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: SafeArea(
        child: Container(
          width: Get.width,
          height: 80,
          color: Colors.transparent,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 60,height: 60,
                  decoration: BoxDecoration(
                      color: appPrimaryColor,
                      shape: BoxShape.circle),
                  child: IconButton(

                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white), // Your custom icon
                    onPressed: () {
                      homeController.onInit();Get.back();
                    },
                  ),
                ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Obx(() {
                if (homeController.languages.isEmpty) {
                  return Center(child: SizedBox());
                }
                return Container(
                  width: 60,height: 60,
                  decoration: BoxDecoration(
                      color: appPrimaryColor,
                      shape: BoxShape.circle),
                  child: PopupMenuButton<String>(
                    color: Colors.teal,
                    iconColor: Colors.white,
                    onSelected: (String value) {
                      print('App Language :: $value');
                      appStorage.write(AppConstants().appLang, value);
                      homeController.onInit();
                    },
                    itemBuilder: (BuildContext context) {
                      return homeController.languages.map((language) {
                        return PopupMenuItem(
                          value: language['short_name']!,
                          enabled: true,
                          child: Text(
                            language['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
