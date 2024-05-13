import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

class CCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final int index;
  final Color color;

  const CCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.index,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants().mediaSize.width,
        height: 140,
        margin: EdgeInsets.symmetric(vertical: 0),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Container(
              width: AppConstants().mediaSize.width,
              height: 100,
              margin: EdgeInsets.symmetric(vertical: 20),
              // padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                // color: color.withOpacity(0.2),
                border: Border.all(color: color.withOpacity(0.2),),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: color.withOpacity(0.3)),
                    image: DecorationImage(
                        image: NetworkImage(
                      imageUrl,
                    ))),
              ),
            ),
            Positioned(
              top: 30,
              left: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        )
        );
  }
}
