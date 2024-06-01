
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';
import 'package:licence_app/screens/auth/login_auth.dart';
import 'package:licence_app/screens/home_screen.dart';

import '../app_constants/app_constants.dart';
import '../main.dart';
import '../screens/languages.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           DrawerHeader(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   Color.fromARGB(255, 0, 20, 21),
                   Color.fromARGB(255, 0, 0, 0), // Black
                   // Dark Teal
                 ],
                 begin: Alignment.centerLeft,
                 end: Alignment.centerRight,
               ),
             ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                  ),
                ),
                const HGap(width: 10),
                Text(
                  'Side Drawer',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
         appStorage.read(AppConstants().isLoggedIn) =="1"?Container():
          ListTile(
            title:  Text('Login', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 1 tap
              Get.to(() => LoginAuthPage());
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          ListTile(
            title:  Text('Share', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 1 tap
              Get.snackbar('Item 1', 'Item 1 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          ListTile(
            title:  Text('Select Language', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
             Get.to(() => LanguageScreen());
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),ListTile(
            title:  Text('Update', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),ListTile(
            title:  Text('Contact', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          ListTile(
            title: Text('Rate Review', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          ListTile(
            title:  Text('About Us', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          ListTile(
            title:  Text('Privacy Policy', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
          appStorage.read(AppConstants().isLoggedIn) =="0"?Container():ListTile(
            title:  Text('Logout', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
             appStorage.write(AppConstants().isLoggedIn, '0');
             Get.offAll(() => HomeScreen());
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
        ],
      ),
    );
  }
}