import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/selectedFileController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:excel/excel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedFileController = Get.put(SelectedFileController());
  List<dynamic> list = [];
  var question;
  var option_1;
  var option_2;
  var option_3;
  var option_4;
  var rightOption;
  var excel;
  var bytes;
  FilePickerResult result;
  File pickFile;
  String filename;

  String name;
  Future<String> excelToJson() async {
    result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xls', 'xlsx', 'csv']);
    if (result != null) {
      setState(() {
        File excelFile = File(result.files.single.path);

        pickFile = excelFile;
        filename = pickFile.path.split('/').last;

        print("pick file name is $filename");
        bytes = File(pickFile.path).readAsBytesSync();
        excel = Excel.decodeBytes(bytes);
        //print("file name is ${result.paths.last}");
      });
    }

    // int i = 0;
    // List<dynamic> keys = [];
    // var jsonMap = [];

    for (var table in excel.tables.keys) {
      int cols = excel.tables[table].maxCols;
      if (cols < 6 || cols > 6) {
        print("Column is $cols");
        Get.defaultDialog(
            backgroundColor: primarycolor,
            title: "Invalid File",
            titleStyle: TextStyle(
              color: Colors.white,
            ),
            middleText: "Please select the valid File",
            middleTextStyle: TextStyle(
              color: Colors.white,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 3 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold,
                          color: secondarycolor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]);
      } else {
        print("Column is $cols");
        for (var row in excel.tables[table].rows) {
          selectedFileController.updateRightAnswerList(
              row[0].value,
              row[1].value,
              row[2].value,
              row[3].value,
              row[4].value,
              row[5].value);

          print("row data is $row");
        }
      }

      // for (int i = 1; i < 5; i++) {
      //   print(selectedFileController.selectedFileQuestionList[i]);

      //   print(selectedFileController.selectedFileOption_1[i]);
      //   print(selectedFileController.selectedFileOption_2[i]);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedFileController.clearAllLists();
                  });
                  excelToJson();
                },
                child: Row(
                  children: [
                    Text(
                      "Add File",
                      style: TextStyle(fontSize: 3 * SizeConfig.textMultiplier),
                    ),
                    SizedBox(
                      width: 2 * SizeConfig.widthMultiplier,
                    ),
                    Icon(Icons.add)
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            if (selectedFileController.selectedFileQuestionList.length != 0 &&
                selectedFileController.selectedFileQuestionList.length !=
                    null) {
              selectedFileController
                  .addQuestionToUser(
                      filename,
                      selectedFileController.selectedFileQuestionList,
                      selectedFileController.selectedFileOption_1,
                      selectedFileController.selectedFileOption_2,
                      selectedFileController.selectedFileOption_3,
                      selectedFileController.selectedFileOption_4,
                      selectedFileController.selectedFileRightOption)
                  .then((value) {
                Get.defaultDialog(
                    title: "File Uploaded",
                    middleText: "File Uploaded Successfully",
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  fontSize: 3 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold,
                                  color: secondarycolor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]);
              });
            } else {
              Get.defaultDialog(
                  title: "Select File",
                  middleText: "Please Select File First",
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold,
                                color: secondarycolor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]);
            }

            //  print("id from Flutter Quiz Screen ${widget.categoryId}");

            // Get.to(GenerateQuiz(
            //   categoryId: widget.categoryId,
            // ));
          },
          child: Container(
            height: 07 * SizeConfig.heightMultiplier,
            width: 40 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
                color: primarycolor, borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Upload File",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            )),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GetBuilder<SelectedFileController>(
                  init:
                      Get.put<SelectedFileController>(SelectedFileController()),
                  builder: (SelectedFileController selectedFileController) {
                    if (selectedFileController != null &&
                        selectedFileController.selectedFileQuestionList !=
                            null) {
                      return Container(
                        height: 80 * SizeConfig.heightMultiplier,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: selectedFileController
                                .selectedFileQuestionList.length,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return SizedBox();
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30 * SizeConfig.heightMultiplier,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height:
                                              4 * SizeConfig.heightMultiplier,
                                          color: primarycolor,
                                          child: Text(
                                            "Q$index)  ${selectedFileController.selectedFileQuestionList[index].toString().trim()}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Text(
                                          "a) ${selectedFileController.selectedFileOption_1[index].toString().trim()}",
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "b) ${selectedFileController.selectedFileOption_2[index].toString().trim()}",
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "c) ${selectedFileController.selectedFileOption_3[index].toString().trim()}",
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "d) ${selectedFileController.selectedFileOption_4[index].toString().trim()}",
                                          maxLines: 2,
                                        ),
                                        Text(
                                          "Right Option = ${selectedFileController.selectedFileRightOption[index].toString().trim()}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              // decoration:
                                              //     TextDecoration.underline
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
                      );
                    } else {
                      return Text(
                        "loading...",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      );
                    }
                  },
                ),
                // selectedFileController.selectedFileQuestionList.length == null
                //     ? Text("Please Select Flie")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
