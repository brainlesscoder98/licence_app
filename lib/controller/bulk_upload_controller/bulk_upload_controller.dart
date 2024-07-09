import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting

import 'package:license_master/main.dart';

class BulkUploadItemController extends GetxController {
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
    fetchquestionsLastUpdateTime();
  }

  void fetchquestionsLastUpdateTime() {
    storedTime = appStorage.read('questionsLastUpdateTime');
    print("This is the time when last stored in questions :::: $storedTime");
    if (storedTime != null) {
      questionsLastUpdateTime.value = DateFormat('yyyy-MM-dd hh:mma').parse(storedTime!);
    }
  }

  void savequestionsLastUpdateTime(DateTime updateTime) {
    questionsLastUpdateTime.value = updateTime;
    // Format the DateTime to 'yyyy-MM-dd hh:mma' format
    final formattedTime = DateFormat('yyyy-MM-dd hh:mma').format(updateTime);
    appStorage.write('questionsLastUpdateTime', formattedTime);
    fetchquestionsLastUpdateTime();
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

  void bulkUploadQuestions(File file) async {
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

            if (row.length < 20) {
              print("Skipping row $rowIndex due to insufficient cells");
              continue;
            }

            String? getStringValue(Data? cell) {
              return cell?.value?.toString();
            }

            List<Map<String, dynamic>> answers = [];

            if (getStringValue(row[19]) != null) {
              String? answersString = getStringValue(row[19]);
              if (answersString != null && answersString.isNotEmpty) {
                answersString = answersString.substring(1, answersString.length - 1);
                List<String> answerParts = answersString.split('}, {');

                for (String part in answerParts) {
                  if (part.startsWith('{')) {
                    part = part.substring(1);
                  }
                  if (part.endsWith('}')) {
                    part = part.substring(0, part.length - 1);
                  }

                  List<String> keyValuePairs = part.split(', ');

                  Map<String, dynamic> answerMap = {};
                  for (String pair in keyValuePairs) {
                    List<String> keyValue = pair.split(': ');
                    if (keyValue.length == 2) {
                      String key = keyValue[0].replaceAll('"', '');
                      String value = keyValue[1].replaceAll('"', '');
                      answerMap[key] = value;
                    }
                  }

                  answers.add(answerMap);
                }
              }
            }

            Map<String, dynamic> questionData = {
              'answer': getStringValue(row[1]),
              'answer_hi': getStringValue(row[2]),
              'answer_ml': getStringValue(row[3]),
              'answer_ta': getStringValue(row[4]),
              'answer_text': getStringValue(row[5]),
              'answer_text_hi': getStringValue(row[6]),
              'answer_text_ml': getStringValue(row[7]),
              'answer_text_ta': getStringValue(row[8]),
              'correct_answer': getStringValue(row[9]),
              'question': getStringValue(row[10]),
              'question_hi': getStringValue(row[11]),
              'question_ml': getStringValue(row[12]),
              'question_ta': getStringValue(row[13]),
              'question_text': getStringValue(row[14]),
              'question_text_hi': getStringValue(row[15]),
              'question_text_ml': getStringValue(row[16]),
              'question_text_ta': getStringValue(row[17]),
              'question_type': getStringValue(row[18]),
              'answers': answers,
            };

            await FirebaseFirestore.instance.collection('questions').add(questionData);

            processedRows++;
            uploadProgress.value = processedRows / totalRows;
          }
        }
      }
      print("Questions uploaded successfully");
      uploadCompleted.value = true;
      final updateTime = DateTime.now();
      savequestionsLastUpdateTime(updateTime);
      fetchquestionsLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
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
      savequestionsLastUpdateTime(updateTime);
      fetchquestionsLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
  }
  void bulkUploadHandSign(File file) async {
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
              'title': getStringValue(row[5]),
              'title_hi': getStringValue(row[6]),
              'title_ml': getStringValue(row[7]),
              'title_ta': getStringValue(row[8]),
            };

            print("Uploading data for row $rowIndex: $questionData");

            await FirebaseFirestore.instance.collection('handsigns').add(questionData);

            processedRows++;
            uploadProgress.value = processedRows / totalRows;
          }
        }
      }
      print("Handsigns uploaded successfully");
      uploadCompleted.value = true;
      final updateTime = DateTime.now();
      savequestionsLastUpdateTime(updateTime);
      fetchquestionsLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
  }
  void bulkUploadRoadSign(File file) async {
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
              'title': getStringValue(row[5]),
              'title_hi': getStringValue(row[6]),
              'title_ml': getStringValue(row[7]),
              'title_ta': getStringValue(row[8]),
            };

            print("Uploading data for row $rowIndex: $questionData");

            await FirebaseFirestore.instance.collection('roadsigns').add(questionData);

            processedRows++;
            uploadProgress.value = processedRows / totalRows;
          }
        }
      }
      print("Roadsigns uploaded successfully");
      uploadCompleted.value = true;
      final updateTime = DateTime.now();
      savequestionsLastUpdateTime(updateTime);
      fetchquestionsLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
  }
  void bulkUploadRTOCodes(File file) async {
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

            Map<String, dynamic> data = {
              'description': getStringValue(row[0]),
              'description_hi': getStringValue(row[1]),
              'description_ml': getStringValue(row[2]),
              'description_ta': getStringValue(row[3]),
              'title': getStringValue(row[4]),
              'title_hi': getStringValue(row[5]),
              'title_ml': getStringValue(row[6]),
              'title_ta': getStringValue(row[7]),
            };

            print("Uploading data for row $rowIndex: $data");

            await FirebaseFirestore.instance.collection('rtocodes').add(data);

            processedRows++;
            uploadProgress.value = processedRows / totalRows;
          }
        }
      }
      print("RTO Codes uploaded successfully");
      uploadCompleted.value = true;
      final updateTime = DateTime.now();
      savequestionsLastUpdateTime(updateTime);
      fetchquestionsLastUpdateTime();
      questionsLastUpdateTime.value = updateTime;
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      isUploading.value = false;
    }
  }



}
