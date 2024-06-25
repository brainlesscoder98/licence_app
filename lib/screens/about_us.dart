import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/aboutus_controller.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/home_controller.dart';
import '../custom_widgets/c_appbar.dart';
import '../main.dart';

class AboutusScreen extends StatelessWidget {
  final AboutusController aboutusController = Get.put(AboutusController());
  final HomeController homeController = Get.put(HomeController());

  Future<void> _refreshData() async {
    await aboutusController.fetchData(); // Example: fetching data again
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: CustomAppBar(
          title: "About Us",
          onRefresh: (){
            aboutusController.fetchData();
            print("Api call success");
          },
          onLanguageSelected: (String value) {
            print('App Language :: $value');
            appStorage.write(AppConstants().appLang, value);
            aboutusController.onInit();
          },
        ),
        body: Container(
          height: AppConstants().mediaSize.height,
          // decoration: GlobalDecoration.containerDecoration,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(() {
            if (aboutusController.notes.isEmpty) {
              return Center(
                  child: LoadingAnimationWidget.flickr(
                size: 50,
                leftDotColor: Colors.blue,
                rightDotColor: Colors.red,
              ));
            }
            return Container(
              height: AppConstants().mediaSize.height - 128,
              width: AppConstants().mediaSize.width,
              child: RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: aboutusController.notes.length,
                  itemBuilder: (context, index) {
                    final aboutus = aboutusController.notes[index];
                    String title = _getLocalizedTitle(aboutus);
                    String subTitle = _getLocalizedDescription(aboutus);
                    String supportLink = _getLocalizedSupport(aboutus);
                    String supportEmail = _getLocalizedEmail(aboutus);
                    Future<void> _launchEmail(String url) async {
                      final Uri _url = Uri.parse("mailto:${url}");
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const VGap(height: 15),
                        Text(subTitle.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left),
                        const VGap(height: 10),
                        Text(title.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left),
                        const VGap(height: 15),

                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: supportLink.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              WidgetSpan(child: HGap(width: 5,)),
                              TextSpan(
                                text: supportEmail.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _launchEmail(supportLink);
                                  },
                              ),
                            ],
                          ),
                        ),
                        const VGap(height: 0),

                      ],
                    );
                  },
                ),
              ),
            );
          }),
        ));
  }

  String _getLocalizedTitle(Map<String, String> aboutus) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return aboutus['title_ml'] ?? aboutus['title'].toString();
      case 'hi':
        return aboutus['title_hi'] ?? aboutus['title'].toString();
      case 'ta':
        return aboutus['title_ta'] ?? aboutus['title'].toString();
      default:
        return aboutus['title']!;
    }
  }
  String _getLocalizedEmail(Map<String, String> aboutus) {
        return aboutus['help_email']!;
    }
  }

  String _getLocalizedDescription(Map<String, String> aboutus) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return aboutus['sub_title_ml'] ?? aboutus['sub_title'].toString();
      case 'hi':
        return aboutus['sub_title_hi'] ?? aboutus['sub_title'].toString();
      case 'ta':
        return aboutus['sub_title_ta'] ?? aboutus['sub_title'].toString();
      default:
        return aboutus['sub_title']!;
    }
  }

  String _getLocalizedSupport(Map<String, String> aboutus) {
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return aboutus['help_ml'] ?? aboutus['help'].toString();
      case 'hi':
        return aboutus['help_hi'] ?? aboutus['help'].toString();
      case 'ta':
        return aboutus['help_ta'] ?? aboutus['help'].toString();
      default:
        return aboutus['help']!;
    }
  }
