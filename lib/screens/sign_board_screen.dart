import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

class SignBoardScreen extends StatelessWidget {
  SignBoardScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> signboards = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 1',
      'description': 'Description for Signboard 1'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 2',
      'description': 'Description for Signboard 2'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 3',
      'description': 'Description for Signboard 3'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 4',
      'description': 'Description for Signboard 4'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 5',
      'description': 'Description for Signboard 5'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 6',
      'description': 'Description for Signboard 6'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 7',
      'description': 'Description for Signboard 7'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 8',
      'description': 'Description for Signboard 8'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Signboard 9',
      'description': 'Description for Signboard 9'
    },
    // Add more signboard data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/road_sign_ai.jpg',),fit: BoxFit.fill, colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7), // Change the opacity value as needed
            BlendMode.dstATop,
          ),),

        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              title:Text( "Sign Board",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            Container(
              height: AppConstants().mediaSize.height-128,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: signboards.length,
                itemBuilder: (context, index) {
                  final signboard = signboards[index];
                  return CCard(
                    imageUrl: signboard['imageUrl']!,
                    name: signboard['name']!,
                    description: signboard['description']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
