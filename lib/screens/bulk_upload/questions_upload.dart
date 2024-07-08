import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/app_constants/app_constants.dart';
import 'package:license_master/controller/bulk_upload_controller/bulk_upload_controller.dart';
import 'package:license_master/screens/bulk_upload/bulk_upload_item.dart';

class QuestionsBulkUploadPage extends StatefulWidget {
  @override
  State<QuestionsBulkUploadPage> createState() => _QuestionsBulkUploadPageState();
}

class _QuestionsBulkUploadPageState extends State<QuestionsBulkUploadPage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BulkUploadItemController());
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
            CollapsibleBulkUploadItem(
              title: 'Questions Upload',
              allowedExtensions: ['xlsx'],
              controller: controller,
            ),
            CollapsibleBulkUploadItem(
              title: 'Signboard Upload',
              allowedExtensions: ['xlsx'],
              controller: controller,
            ),
            CollapsibleBulkUploadItem(
              title: 'Hand Sign Upload',
              allowedExtensions: ['xlsx'],
              controller: controller,
            ),
            CollapsibleBulkUploadItem(
              title: 'Road Sign Upload',
              allowedExtensions: ['xlsx'],
              controller: controller,
            ),
            CollapsibleBulkUploadItem(
              title: 'RTO Codes Upload',
              allowedExtensions: ['xlsx'],
              controller: controller,

            ),
          ],
        ),
      )
    );
  }
}
