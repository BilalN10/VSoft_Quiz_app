import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:firebase_storage/firebase_storage.dart';

class QuizGenerator extends StatefulWidget {
  @override
  _QuizGeneratorState createState() => _QuizGeneratorState();
}

class _QuizGeneratorState extends State<QuizGenerator> {
  List<String> data = ["Q1", "Q2", "Q3", "Q4"];
  List<String> option = ["option1", "option2", "option3", "option4"];
  String getUrl = "C";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: createExcelFile, child: Text("File")),
      ),
    );
  }

  Future<void> createExcelFile() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    //sheet.getRangeByName("A3").setText("Hello World");
    sheet.getColumnIndex("A");
    for (int i = 0; i < data.length; i++) {
      sheet.getRangeByName("A${i + 1}").setText(data[i]);
      sheet.getRangeByName("B${i + 1}").setText(option[i]);
    }
    print("my Column is ${sheet.getColumnIndex("A")}");

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = "$path/Output.xlsx";
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    createUser(file);
    //OpenFile.open(fileName);
  }

  Future<bool> createUser(File file) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user-images')
          .child("Questoin.xlsx");
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      print(url);

      return true;
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
      return false;
    }
  }
}
