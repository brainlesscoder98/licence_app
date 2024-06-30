import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class QuestionsBulkUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Bulk Upload')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          BulkUploadItem(
            title: 'Questions Upload',
            allowedExtensions: ['xlsx'],
          ),
          BulkUploadItem(
            title: 'Signboard Upload',
            allowedExtensions: ['xlsx'],
          ),
          BulkUploadItem(
            title: 'Hand Sign Upload',
            allowedExtensions: ['xlsx'],
          ),
          BulkUploadItem(
            title: 'Road Sign Upload',
            allowedExtensions: ['xlsx'],
          ),
          BulkUploadItem(
            title: 'RTO Codes Upload',
            allowedExtensions: ['xlsx'],
          ),
        ],
      ),
    );
  }
}

class BulkUploadItem extends StatefulWidget {
  final String title;
  final List<String> allowedExtensions;

  const BulkUploadItem({
    Key? key,
    required this.title,
    required this.allowedExtensions,
  }) : super(key: key);

  @override
  _BulkUploadItemState createState() => _BulkUploadItemState();
}

class _BulkUploadItemState extends State<BulkUploadItem> {
  File? selectedFile;
  bool isUploading = false;
  double uploadProgress = 0.0;
  bool uploadCompleted = false;
  DateTime? lastUpdateTime;

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void bulkUploadData(File file) async {
    setState(() {
      isUploading = true;
      uploadProgress = 0.0;
      uploadCompleted = false;
    });

    try {
      // Read the Excel file
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      int totalRows = 0;
      int processedRows = 0;

      // Calculate the total number of rows for progress calculation
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          totalRows += sheet.maxRows - 1; // excluding the header row
        }
      }

      // Parse and upload the data to Firestore
      for (var table in excel.tables.keys) {
        var sheet = excel.tables[table];
        if (sheet != null) {
          for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
            var row = sheet.row(rowIndex);

            // Ensure the row has enough cells
            if (row.length < 20) {
              print("Skipping row $rowIndex due to insufficient cells");
              continue;
            }

            // Convert cell values to strings
            String? getStringValue(Data? cell) {
              return cell?.value?.toString();
            }

            // Initialize answers list
            List<Map<String, dynamic>> answers = [];

            // Check if cell at index 19 exists and is not empty
            if (getStringValue(row[19]) != null) {
              // Parse answers from cell A19 (adjust the index as per your sheet)
              String? answersString = getStringValue(row[19]);

              // Parse answers string if it's not null
              if (answersString != null && answersString.isNotEmpty) {
                // Remove leading and trailing square brackets and split by '}, {'
                answersString = answersString.substring(1, answersString.length - 1);
                List<String> answerParts = answersString.split('}, {');

                // Process each answer part
                for (String part in answerParts) {
                  // Handle leading and trailing '{' and '}'
                  if (part.startsWith('{')) {
                    part = part.substring(1);
                  }
                  if (part.endsWith('}')) {
                    part = part.substring(0, part.length - 1);
                  }

                  // Split by ',' to get individual key-value pairs
                  List<String> keyValuePairs = part.split(', ');

                  // Create map for current answer
                  Map<String, dynamic> answerMap = {};
                  for (String pair in keyValuePairs) {
                    List<String> keyValue = pair.split(': ');
                    if (keyValue.length == 2) {
                      // Remove leading and trailing quotes from key and value
                      String key = keyValue[0].replaceAll('"', '');
                      String value = keyValue[1].replaceAll('"', '');
                      answerMap[key] = value;
                    }
                  }

                  // Add answer map to answers list
                  answers.add(answerMap);
                }
              }
            }

            // Create a question document
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

            // Upload questionData to Firestore
            await FirebaseFirestore.instance.collection('testquestions').add(questionData);

            // Update progress
            processedRows++;
            setState(() {
              uploadProgress = processedRows / totalRows;
            });
          }
        }
      }
      print("Data uploaded successfully");
      setState(() {
        uploadCompleted = true;
        lastUpdateTime = DateTime.now();
      });
    } catch (e) {
      print("Error during bulk upload: $e");
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  void pickFile() async {
    await requestStoragePermission();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  void replaceFile() {
    setState(() {
      selectedFile = null;
      uploadCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (selectedFile != null && !isUploading) {
                bulkUploadData(selectedFile!);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  isUploading ? 'Uploading...' : 'Upload File',
                  style: TextStyle(color: Colors.white),
                ),
                if (isUploading)
                  Positioned.fill(
                    child: LinearProgressIndicator(
                      value: uploadProgress,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 10),
          selectedFile != null
              ? Column(
            children: [
              SizedBox(height: 10),
              isUploading
                  ? Column(
                children: [
                  CircularProgressIndicator(value: uploadProgress),
                  SizedBox(height: 10),
                  Text(
                    'Upload Progress: ${(uploadProgress * 100).toStringAsFixed(2)}%',
                  ),
                ],
              )
                  : uploadCompleted
                  ? Column(
                children: [
                  Icon(Icons.check, color: Colors.green, size: 30),
                  SizedBox(height: 10),
                  Text(
                    'Upload completed on ${DateFormat('dd/MM/yyyy HH:mm').format(lastUpdateTime!)}',
                    textAlign: TextAlign.center,
                  ),
                ],
              )
                  : Container(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: isUploading ? null : replaceFile,
                child: Text('Replace File'),
              ),
            ],
          )
              : ElevatedButton(
            onPressed: pickFile,
            child: Text('Pick Excel File'),
          ),
        ],
      ),
    );
  }
}
