import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/screens/about_us.dart';
import 'package:license_master/screens/auth/login_auth.dart';
import 'package:license_master/screens/bulk_upload/questions_upload.dart';
import 'package:license_master/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_constants/app_constants.dart';
import '../controller/home_controller.dart';
import '../main.dart';
import '../screens/languages.dart';

class SideDrawer extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  Future<void> _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(appStorage.read(AppConstants().isLoggedIn));
    return Drawer(backgroundColor: Colors.black,
      child: Column(
        children: [
          // DrawerHeader(
          //   // decoration: GlobalDecoration.containerDecoration,
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         onTap:(){
          //           Get.to(() => QuestionsBulkUploadPage());
          //         },
          //         child: Container(
          //           width: 90,
          //           height: 90,
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //                 image: AssetImage('assets/images/app_logo.png')),
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //       const HGap(width: 10),
          //       Text(
          //         'License Master',
          //         style: GoogleFonts.poppins(
          //           color: Colors.white,
          //           fontSize: 20,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 40,left: 20,right: 20),
            height: 90,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            decoration: BoxDecoration(
              color: appPrimaryColor,
              borderRadius: BorderRadius.circular(15)
            ),
           child: Row(
             children: [
               GestureDetector(
                 onTap:(){
                   Get.to(() => QuestionsBulkUploadPage());
                 },
                 child: Container(
                   width: 70,
                   height: 70,
                   decoration: const BoxDecoration(
                     shape: BoxShape.circle,
                     image: DecorationImage(
                         image: AssetImage('assets/images/app_logo.png')),
                     color: Colors.white,
                   ),
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
          Container(
            margin: EdgeInsets.only(top: 20,left: 20,right: 20),
            decoration: BoxDecoration(
                color: appPrimaryColor,
                borderRadius: BorderRadius.circular(15)
            ),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount:
                    homeController.drawerItems.length, // +1 for DrawerHeader
                itemBuilder: (context, index) {
                  final itemTitle = homeController
                      .getLocalizedTitle(homeController.drawerItems[index]);
                  final itemLink = homeController
                      .getRedirectionLink(homeController.drawerItems[index]);
                  print("Item Link::: ${itemLink.toString()}");
                  final itemIndex = homeController
                      .getItemIndex(homeController.drawerItems[index]);
                  if (index == 0 &&
                      appStorage.read(AppConstants().isLoggedIn)?.trim() == "1") {
                    return SizedBox(); // Hide the first item if not logged in
                  }
                  if (index == 8 &&
                      appStorage.read(AppConstants().isLoggedIn)?.trim() != "1") {
                    return SizedBox(); // Hide the first item if not logged in
                  }
                  print(homeController
                      .isDrawerItemVisible(homeController.drawerItems[index]));
                  return Visibility(
                    visible: bool.parse(homeController
                        .isDrawerItemVisible(homeController.drawerItems[index])),
                    child: ListTile(
                      title: Text(
                        itemTitle,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      onTap: () async{
                        switch (itemIndex) {
                          case '1':
                            Get.to(() => LoginAuthPage());
                            break;
                          case '2':
                              if (itemLink.isNotEmpty) await _launchURL(itemLink);
                              Get.snackbar(
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  "Alert",
                                  "Share Link link will only available once the app is live in Play-store / Appstore !!");
                              break;

                          case '3':
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            Get.to(() => LanguageScreen());
                            break;
                          case '4':
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                "Alert",
                                "The update link will only available once the app is live in Play-store / Appstore !!");
                            break;
                          case '5':
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            break;
                          case '6':
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            Get.snackbar(
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                "Alert",
                                "The Rate and Review link will only available once the app is live in Play-store / Appstore !!");
                            break;
                          case '7':
                            Get.to(() => AboutusScreen());
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            break;
                          case '8':
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            print(itemLink.toString());
                            break;
                          case '9':
                            // if (appStorage.read(AppConstants().isLoggedIn)?.trim() == "1") {
                            //
                            //   ;
                            // } else {
                            //   return SizedBox();
                            // }
                            if (itemLink.isNotEmpty) await _launchURL(itemLink);
                            appStorage.write(AppConstants().isLoggedIn, "0");
                            Get.offAll(() => HomeScreen());
                            break;
                          default:
                            break;
                        }
                      },
                      trailing: Container(
                          width: 30,height: 30,
                          decoration: BoxDecoration(color:appPrimaryColor,shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],),
                          child: Center(child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,))),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
