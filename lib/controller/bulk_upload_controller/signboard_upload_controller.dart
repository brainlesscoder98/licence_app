import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting

import 'package:license_master/main.dart';

class SignBoardUploadController extends GetxController {
  var selectedFile = Rxn<File>();
  var isUploading = false.obs;
  var uploadProgress = 0.0.obs;
  var uploadCompleted = false.obs;
  var questionsLastUpdateTime = Rxn<DateTime>();
  String? storedTime;


  @override
  void onInit() {
    super.onInit();
    // Fetch questionsLastUpdateTime from GetStorage during initialization
    fetchLastUpdateTime();
  }

  void fetchLastUpdateTime() {
    storedTime = appStorage.read('questionsLastUpdateTime');
    print("This is the time when last stored in questions :::: $storedTime");
    if (storedTime != null) {
      questionsLastUpdateTime.value = DateFormat('yyyy-MM-dd hh:mma').parse(storedTime!);
    }
  }

  void saveLastUpdateTime(DateTime updateTime) {
    questionsLastUpdateTime.value = updateTime;
    // Format the DateTime to 'yyyy-MM-dd hh:mma' format
    final formattedTime = DateFormat('yyyy-MM-dd hh:mma').format(updateTime);
    appStorage.write('questionsLastUpdateTime', formattedTime);
    fetchLastUpdateTime();
    print("Controller updated");
  }

  void pickFile(List<String> allowedExtensions) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      selectedFile.value = File(result.files.single.path!);
    }
  }

  void replaceFile() {
    selectedFile.value = null;
    uploadCompleted.value = false;
  }
  void bulkUploadSignBoard(File file) async {
    isUploading.value = true;
    uploadProgress.value = 0.0;
    uploadCompleted.value = false;

    try {
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      int totalRows = 0;
      int processedRows = 0;

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          totalRows += sheet.maxRows - 1;
        }
      }

      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
            var row = sheet.row(rowIndex);
            print("Row $rowIndex length: ${row.length}");
            print("Row $rowIndex data: ${row.map((cell) => cell?.value).toList()}");

            // Assuming the row structure is correct based on the provided Excel sheet screenshot
            String? getStringValue(Data? cell) {
              return cell?.value?.toString();
            }

            Map<String, dynamic> questionData = {
              'description': getStringValue(row[0]),
              'description_hi': getStringValue(row[1]),
              'description_ml': getStringValue(row[2]),
              'description_ta': getStringValue(row[3]),
              'imageUrl': getStringValue(row[4]),
              'name': getStringValue(row[5]),
              'name_hi': getStringValue(row[6]),
              'name_ml': getStringValue(row[7]),
              'name_ta': getStringValue(row[8]),
            };

            print("Uploading data for row $rowIndex: $questionData");

            await FirebaseFirestore.instance.collection('signboards').add(questionData);

            processedRows++;
            uploadProgress.value = processedRows / totalRows;
          }
        }
      }
      print("Signboards uploaded successfully");
      uploadCompleted.value = true;
      final updateTime = DateTime.now();
      saveLastUpdateTime(updateTime);
      fetchLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
  }
  }
