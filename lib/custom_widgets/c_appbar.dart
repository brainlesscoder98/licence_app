
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Custom AppBar',style: TextStyle(color: Colors.black),),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.menu,color: Colors.black),
        onPressed: (){
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.search),
        //   onPressed: () {
        //     // Handle search action
        //     Get.snackbar('Search', 'Search button pressed');
        //   },
        // ),
        IconButton(
          icon: Icon(Icons.settings,color: Colors.black),
          onPressed: () {
            // Handle settings action
            Get.snackbar('Settings', 'Settings button pressed');
          },
        ),
      ],
    );
  }
}