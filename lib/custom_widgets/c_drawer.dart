import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/screens/auth/login_auth.dart';
import 'package:license_master/screens/home_screen.dart';

import '../app_constants/app_constants.dart';
import '../controller/home_controller.dart';
import '../main.dart';
import '../screens/languages.dart';

class SideDrawer extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    print(appStorage.read(AppConstants().isLoggedIn));
    final List<Map<String, dynamic>> drawerItems = [
      {
        'title': 'Login',
        'action': () => Get.to(() => LoginAuthPage()),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': appStorage.read(AppConstants().isLoggedIn) != "1"
      },
      {
        'title': 'Share',
        'action': () => Get.snackbar('Share', 'Share tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Select Language',
        'action': () => Get.to(() => LanguageScreen()),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Update',
        'action': () => Get.snackbar('Update', 'Update tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Contact',
        'action': () => Get.snackbar('Contact', 'Contact tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Rate Review',
        'action': () => Get.snackbar('Rate Review', 'Rate Review tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'About Us',
        'action': () => Get.snackbar('About Us', 'About Us tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Privacy Policy',
        'action': () => Get.snackbar('Privacy Policy', 'Privacy Policy tapped'),
        'icon': Icons.arrow_circle_right_rounded,
        'condition': true
      },
      {
        'title': 'Logout',
        'action': () {
          appStorage.write(AppConstants().isLoggedIn, '0');
          Get.offAll(() => HomeScreen());
        },
        'icon': Icons.arrow_circle_right_rounded,
        'condition': appStorage.read(AppConstants().isLoggedIn) == "1"
      },
    ];

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: GlobalDecoration.containerDecoration,
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/app_logo.png')),
                    color: Colors.white,
                  ),
                ),
                const HGap(width: 10),
                Text(
                  'License Master',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount:
                  homeController.drawerItems.length, // +1 for DrawerHeader
              itemBuilder: (context, index) {
                final itemTitle = homeController.getLocalizedTitle(homeController.drawerItems[index]);
                final itemIndex = homeController.getItemIndex(homeController.drawerItems[index]);
                if (index == 0 && appStorage.read(AppConstants().isLoggedIn)?.trim() == "1") {
                  return SizedBox(); // Hide the first item if not logged in
                }
                if (index == 8 && appStorage.read(AppConstants().isLoggedIn)?.trim() != "1") {
                  return SizedBox(); // Hide the first item if not logged in
                }
                return ListTile(
                  title: Text(
                    itemTitle,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    switch (itemIndex) {
                      case '1':
                        Get.to(() => LoginAuthPage());
                        break;
                      case '2':
                        Get.snackbar(backgroundColor: Colors.red,colorText: Colors.white,"Alert", "Share Link link will only available once the app is live in Play-store / Appstore !!");                        break;
                      case '3':
                        Get.to(() => LanguageScreen());
                        break;
                      case '4':
                        Get.snackbar(backgroundColor: Colors.red,colorText: Colors.white,"Alert", "The update link will only available once the app is live in Play-store / Appstore !!");
                        break;
                      case '5':

                        break;
                      case '6':
                        Get.snackbar(backgroundColor: Colors.red,colorText: Colors.white,"Alert", "The Rate and Review link will only available once the app is live in Play-store / Appstore !!");
                        break;
                      case '7':
                        break;
                      case '8':
                        break;
                      case '9':
                        // if (appStorage.read(AppConstants().isLoggedIn)?.trim() == "1") {
                        //
                        //   ;
                        // } else {
                        //   return SizedBox();
                        // }
                        appStorage.write(AppConstants().isLoggedIn, "0");
                        Get.offAll(() => HomeScreen());
                        break;
                      default:
                        break;
                    }
                  },
                  trailing: Icon(Icons.arrow_circle_right_rounded),
                );
              }),
        ],
      ),
    );
  }
}
