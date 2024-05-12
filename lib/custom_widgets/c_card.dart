import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';

class CCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;

  const CCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:AppConstants().mediaSize.width,
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.2)
      ),
      child: ListTile(
        leading: Container(
          width: 60,height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(imageUrl,))
          ),

        ),
        title: Text(name,style: GoogleFonts.poppins(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w800),),
        subtitle: Text(description,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400),),
      ),
    );
  }
}