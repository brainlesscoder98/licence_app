import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class QuestionsBulkUploadPage extends StatefulWidget {
  @override
  _QuestionsBulkUploadPageState createState() => _QuestionsBulkUploadPageState();
}

class _QuestionsBulkUploadPageState extends State<QuestionsBulkUploadPage> {
  void bulkUploadData(File file) async {
    try {
      // Read the Excel file
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);

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
            await FirebaseFirestore.instance.collection('roadsigns').add(questionData);
          }
        }
      }
      print("Data uploaded successfully");
    } catch (e) {
      print("Error during bulk upload: $e");
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      bulkUploadData(file);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Bulk Upload')),
      body: Center(
        child: ElevatedButton(
          onPressed: pickFile,
          child: Text('Pick and Upload Excel File'),
        ),
      ),
    );
  }
}
