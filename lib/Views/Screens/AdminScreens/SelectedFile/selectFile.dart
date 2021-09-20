import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/selectedFileController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminQuizesScreen/AdminQuizEditScreen/Components/mcqContainer.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminQuizesScreen/GetuizLink/getQuizLink.dart';
import 'package:quizapp/Views/Screens/UserScreens/GenerateQuizScreen/UsersScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quizapp/Views/Screens/AdminScreens/SelectedFile/homepages.dart';

class SelecFile extends StatefulWidget {
  final selectedFileController = Get.put(SelectedFileController());
  final userController = Get.put(UserController());
  final quizQuestionmodel = QuizQuestionModel();

  @override
  _FlutterQuizScreenState createState() => _FlutterQuizScreenState();
}

class _FlutterQuizScreenState extends State<SelecFile> {
  bool allValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CommonBackground(
        childd: Container(
          height: 100 * SizeConfig.heightMultiplier,
          width: 100 * SizeConfig.widthMultiplier,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.widthMultiplier,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.userController.questionList.length == 0) {
                          Get.defaultDialog(
                              middleText: "Please Select Question first",
                              title: "Select Question",
                              confirm: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 3 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.bold),
                                  )),
                              actions: []);
                        } else {
                          Get.to(() => GetQuizLink(
                                questionList:
                                    widget.userController.questionList,
                              ));

                          // UserScreen(
                          //       checkModel: widget.userController.questionList,
                          //       questionModel: widget.quizQuestionmodel,
                          //     ));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 4 * SizeConfig.heightMultiplier,
                        width: 20 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primarycolor),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 2 * SizeConfig.textMultiplier,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select all",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 2 * SizeConfig.textMultiplier,
                          ),
                        ),
                        Checkbox(
                          checkColor: Colors.greenAccent,
                          activeColor: Colors.red,
                          value: this.allValue,
                          onChanged: (bool value) {
                            setState(() {
                              this.allValue = value;
                              if (allValue == true) {
                                for (int i = 0;
                                    i <
                                        widget.selectedFileController
                                            .selectedFile.length;
                                    i++) {
                                  widget.userController.addQuestion(widget
                                      .selectedFileController.selectedFile[i]);
                                  print("question added");
                                }
                              } else {
                                widget.userController.questionList.length = 0;
                              }

                              // print(this.valuefirst);
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GetX<SelectedFileController>(
                init: Get.put<SelectedFileController>(SelectedFileController()),
                builder: (SelectedFileController questionController) {
                  if (questionController != null &&
                      questionController.selectedFile != null) {
                    return Expanded(
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: questionController.selectedFile.length,
                          itemBuilder: (context, index) {
                            // questionController.singleQuizLength =
                            //     questionController.quiz.length;
                            // print(
                            //     "Question length is ${questionController.quiz.length}");
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),

                              ///left side slide
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: "Delete",
                                  color: Colors.red.shade400,
                                  icon: Icons.delete,
                                  onTap: () {
                                    widget.selectedFileController
                                        .removeSelectedFileQestion(
                                            questionController
                                                .selectedFile[index].id);
                                  },
                                ),
                                // IconSlideAction(
                                //   caption: "Edit",
                                //   color: Colors.blue.shade400,
                                //   icon: Icons.edit,
                                //   onTap: () {
                                //     Get.to(FlutterQuizEditScreen(
                                //       categoryId: widget.categoryId,
                                //       index: index,
                                //       quizQuestionModel:
                                //           questionController.selectedFile[index],
                                //     ));
                                //   },
                                // )
                              ],
                              child: ListTile(
                                title: McqContainer(
                                  valuefirst: allValue,
                                  checkModel: questionController.selectedFile,
                                  index: index,
                                  // ques: flutter[index],
                                  questionModel:
                                      questionController.selectedFile[index],
                                ),
                              ),
                            );
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(() => MyHomePage(
                title: "Select File",
              ));
          //  print("id from Flutter Quiz Screen ${widget.categoryId}");

          // Get.to(GenerateQuiz(
          //   categoryId: widget.categoryId,
          // ));
        },
        child: Container(
          height: 07 * SizeConfig.heightMultiplier,
          width: 50 * SizeConfig.widthMultiplier,
          decoration: BoxDecoration(
              color: primarycolor, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add New File",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 19,
              )
            ],
          )),
        ),
      ),
    );
  }
}
