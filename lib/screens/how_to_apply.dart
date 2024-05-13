import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:licence_app/app_constants/app_constants.dart';
import 'package:licence_app/custom_widgets/c_card.dart';
import 'package:licence_app/custom_widgets/c_gap.dart';

class HowToApplyScreen extends StatelessWidget {
  HowToApplyScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView(
          children: [
            AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              title:Text( "How to apply",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500),),
            ),
            const VGap(height: 40),
            Text( "Eligibility Criteria for Obtaining Driving License in Kerala",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700),),
            const VGap(height: 10),
            Text( "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.justify),
            const VGap(height: 10),
            Text( "Where does it come from?",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700),),
            const VGap(height: 10),
            Text( "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32.",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.justify),
            const VGap(height: 10),
            Text( "Where can I get some?",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w700),),
            const VGap(height: 10),
            Text( "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.justify),
            const VGap(height: 10),

          ],
        ),
      ),
    );
  }
}
