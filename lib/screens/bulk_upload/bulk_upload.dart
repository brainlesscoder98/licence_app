import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/bulk_upload_controller/bulk_upload_controller.dart';
import 'package:license_master/controller/bulk_upload_controller/question_upload_controller.dart';
import 'package:license_master/controller/bulk_upload_controller/rtocodes_upload_controller.dart';
import 'package:license_master/controller/bulk_upload_controller/signboard_upload_controller.dart';
import 'package:license_master/controller/handsign_controller.dart';
import 'package:license_master/controller/roadsign_controller.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_handsign.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_item.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_questions.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_roadsign.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_rtocodes.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_signboard.dart';

class BulkUploadPage extends StatefulWidget {
  @override
  State<BulkUploadPage> createState() => _BulkUploadPageState();
}

class _BulkUploadPageState extends State<BulkUploadPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BulkUploadItemController());
    final controllerQuestions = Get.put(QuestionsUploadController());
    final controllerSignBoard = Get.put(SignBoardUploadController());
    final controllerHandSign = Get.put(HandSignController());
    final controllerRoadSign = Get.put(RoadSignController());
    final controllerRtoCodes = Get.put(RtoCodesUploadController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        flexibleSpace: Container(
          decoration: GlobalDecoration.containerDecoration,
        ),
        title: Text(
          'Bulk Upload',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: AppConstants().mediaSize.width,
        height: AppConstants().mediaSize.height,
        decoration: GlobalDecoration.containerDecoration,
        child: ListView(
          children: [
            QuestionsBulkUploadItem(
              title: 'Questions Upload',
              allowedExtensions: ['xlsx'],
            ),
            SignboardBulkUploadItem(
              title: 'Signboard Upload',
              allowedExtensions: ['xlsx'],
            ),
            HandSignBulkUploadItem(
              title: 'Hand Sign Upload',
              allowedExtensions: ['xlsx'],
            ),
            RoadSignBulkUploadItem(
              title: 'Road Sign Upload',
              allowedExtensions: ['xlsx'],
            ),
            RtoCodesBulkUploadItem(
              title: 'RTO Codes Upload',
              allowedExtensions: ['xlsx'],
            ),
          ],
        ),
      )
    );
  }
}
