import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
        onPressed: () {
          homeController.onInit();
          Get.back();

        },
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 20, 21),
              Color.fromARGB(255, 0, 0, 0), // Black
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      elevation: 0,
      actions: [
        Obx(() {
          if (homeController.languages.isEmpty) {
            return SizedBox();
          }
          return PopupMenuButton<String>(
            color: Colors.white,
            iconColor: Colors.white,
            onSelected: onLanguageSelected,
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
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
