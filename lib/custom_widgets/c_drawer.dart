
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
           DrawerHeader(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),// Start color
                  Colors.white, // End color
                ],
                begin: Alignment.topLeft, // Gradient start position
                end: Alignment.bottomRight, // Gradient end position
                stops: [0.0, 1], // Gradient stops
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
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
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
            title:  Text('Add Licence Item', style: GoogleFonts.poppins(
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
          ListTile(
            title:  Text('Logout', style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
            ),),
            onTap: () {
              // Handle item 2 tap
              Get.snackbar('Item 2', 'Item 2 tapped');
            },
            trailing: const Icon(Icons.arrow_circle_right_rounded),
          ),
        ],
      ),
    );
  }
}