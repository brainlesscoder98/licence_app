import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/bulk_upload_controller/bulk_upload_controller.dart';
import '../../custom_widgets/c_elevated_button.dart';

class CollapsibleBulkUploadItem extends StatefulWidget {
  final String title;
  final List<String> allowedExtensions;
  final BulkUploadItemController controller;

  const CollapsibleBulkUploadItem({
    Key? key,
    required this.title,
    required this.allowedExtensions,
    required this.controller,
  }) : super(key: key);

  @override
  State<CollapsibleBulkUploadItem> createState() =>
      _CollapsibleBulkUploadItemState();
}

class _CollapsibleBulkUploadItemState extends State<CollapsibleBulkUploadItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Obx(() {
                return Text(
                  "Last Updated on - ${widget.controller.storedTime ?? ''}",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                );
              }),
            ],
          ),
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Obx(() {
                        if (widget.controller.selectedFile.value == null) {
                          return CustomElevatedButton(
                            text: 'Choose File',
                            width: Get.width * 0.5,
                            onPressed: () =>
                                widget.controller.pickFile(widget.allowedExtensions),
                          );
                        } else {
                          return Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: widget.controller.uploadCompleted.value
                                          ? 'Upload Successful: '
                                          : 'Selected File: ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      "${widget.controller.selectedFile.value!.path.split('/').last}  ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: widget.controller.uploadCompleted.value
                                          ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                          : IconButton(
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          size: 25,
                                          color: Colors.redAccent,
                                        ),
                                        onPressed:
                                        widget.controller.replaceFile,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              widget.controller.uploadCompleted.value
                                  ? SizedBox()
                                  : Obx(() => LoadingElevatedButton(
                                text: 'Upload File',
                                onPressed: () {
                                  if (!widget.controller.isUploading.value) {
                                    widget.controller.bulkUploadQuestions(
                                        widget.controller.selectedFile.value!);
                                  }
                                },
                                isLoading: widget.controller.isUploading.value,
                                progress:
                                widget.controller.uploadProgress.value,
                              )),
                              if (widget.controller.uploadCompleted.value)
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    CustomElevatedButton(
                                        text: 'Upload More',
                                        onPressed: widget.controller.replaceFile),
                                  ],
                                ),
                            ],
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}