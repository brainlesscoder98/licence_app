import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/custom_widgets/c_gap.dart';

class CTable extends StatelessWidget {
  final String name;
  final String code;
  final int index;
  final Color color;

  const CTable({
    Key? key,
    required this.name,
    required this.code,
    required this.index,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: AppConstants().mediaSize.width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: AppConstants().mediaSize.width,
          height: 65,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            // color: appPrimaryColor,
            // color: color.withOpacity(0.2),
            border: Border.all(color: color,),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  // color: Colors.blue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // How far the shadow spreads from the box
                      blurRadius: 4, // How blurry the shadow is
                      offset: Offset(2, -2), // Displacement of the shadow (x, y)
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    name,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              HGap(width: 20),
              Container(
                color: Colors.transparent,
                width: AppConstants().mediaSize.width*0.61,
                child: Text(
                  code,
                  maxLines: 3,
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
     );
  }
}
