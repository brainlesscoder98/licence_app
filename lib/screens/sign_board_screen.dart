import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controller/signboard_controller.dart';

class SignBoardScreen extends StatelessWidget {
  final SignboardController signboardController = Get.put(SignboardController());

  Future<void> _refreshData() async {
    await signboardController.fetchData(); // Example: fetching data again
  }
  @override
  Widget build(BuildContext context) {
    print("Selected App Language is ::: ${appStorage.read(AppConstants().appLang)}");
    return Scaffold(
      appBar:AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,), onPressed: () { Get.back(); },),
        title:Text( "Sign Board",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
      ),
      body: Container(

        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          color: Colors.black,

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Obx((){
          if (signboardController.signboards.isEmpty) {
            return Center(child: LoadingAnimationWidget.flickr(
              size: 50, leftDotColor: Colors.blue, rightDotColor: Colors.red,
            ));
          }
          return Container(
            height: AppConstants().mediaSize.height-128,
            width: AppConstants().mediaSize.width,
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: signboardController.signboards.length,
                itemBuilder: (context, index) {
                  final signboard = signboardController.signboards[index];
                  String name = '';
                  String description = '';
                  switch (appStorage.read(AppConstants().appLang.toString())){
                    case 'ml':
                      name = signboard['name_ml'] ?? signboard['name'].toString();
                      description = signboard['description_ml'] ??  signboard['description'].toString();
                      break;
                    default:
                      name = signboard['name']!;
                      description = signboard['description']!;
                  }
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
        })
      ),
    );
  }
}
