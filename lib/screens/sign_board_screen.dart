import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

class SignBoardScreen extends StatelessWidget {
  SignBoardScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> signboards = [
    {
      'imageUrl': 'https://randomuser.me/api/portraits/men/1.jpg',
      'name': 'Signboard 1',
      'description': 'Description for Signboard 1'
    },
    {
      'imageUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
      'name': 'Signboard 2',
      'description': 'Description for Signboard 2'
    },
    {
      'imageUrl': 'https://randomuser.me/api/portraits/men/3.jpg',
      'name': 'Signboard 3',
      'description': 'Description for Signboard 3'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/4.jpg',
      'name': 'Signboard 4',
      'description': 'Description for Signboard 4'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/5.jpg',
      'name': 'Signboard 5',
      'description': 'Description for Signboard 5'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/6.jpg',
      'name': 'Signboard 6',
      'description': 'Description for Signboard 6'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/7.jpg',
      'name': 'Signboard 7',
      'description': 'Description for Signboard 7'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/8.jpg',
      'name': 'Signboard 8',
      'description': 'Description for Signboard 8'
    },{
      'imageUrl': 'https://randomuser.me/api/portraits/men/9.jpg',
      'name': 'Signboard 9',
      'description': 'Description for Signboard 9'
    },
    // Add more signboard data as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:   AppBar(
      //   automaticallyImplyLeading: true,
      //   backgroundColor: Colors.transparent,
      //   title:Text( "Sign Board",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
      // ),
      body: Container(

        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.3),// Start color
              Colors.white, // End color
            ],
            begin: Alignment.topCenter, // Gradient start position
            end: Alignment.bottomCenter, // Gradient end position
            stops: [0.0, 0.3], // Gradient stops
          ),

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
              width: AppConstants().mediaSize.width,
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
                    index: index,
                    color: Colors.lightBlue,
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
