import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';

class RoadSignScreen extends StatelessWidget {
  RoadSignScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> signboards = [
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 1',
      'description': 'Description for Road Sign 1'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 2',
      'description': 'Description for Road Sign 2'
    },
    {
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 3',
      'description': 'Description for Road Sign 3'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 4',
      'description': 'Description for Road Sign 4'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 5',
      'description': 'Description for Road Sign 5'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 6',
      'description': 'Description for Road Sign 6'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 7',
      'description': 'Description for Road Sign 7'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 8',
      'description': 'Description for Road Sign 8'
    },{
      'imageUrl': 'https://via.placeholder.com/150',
      'name': 'Road Sign 9',
      'description': 'Description for Road Sign 9'
    },
    // Add more Road Sign data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        height: AppConstants().mediaSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/road_ai.jpg',),fit: BoxFit.fill, colorFilter: ColorFilter.mode(
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
              title:Text( "Road Sign",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
            ),
            Container(
              height: AppConstants().mediaSize.height-128,
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: signboards.length,
                itemBuilder: (context, index) {
                  final roadSign = signboards[index];
                  return CCard(
                    imageUrl: roadSign['imageUrl']!,
                    name: roadSign['name']!,
                    description: roadSign['description']!,
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
