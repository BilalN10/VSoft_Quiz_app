import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizBankController.dart';
import 'package:quizapp/Controllers/quizCategoryController.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminQuizesScreen/GetuizLink/getQuizLink.dart';
import 'package:quizapp/Views/Screens/AdminScreens/QuizBank/ComponentsOfQuizBankScreen/questionOptionScreen.dart';
import 'package:quizapp/Views/Screens/AdminScreens/SelectedFile/selectFile.dart';
import 'package:quizapp/Views/Screens/UserScreens/GenerateQuizScreen/UsersScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class QuizBankScreen extends StatefulWidget {
  QuizBankScreen({Key key, this.categoryId}) : super(key: key);
  final String categoryId;
  final quizQuestionController = Get.put(QuizQuestionController());
  final userController = Get.put(UserController());
  final quizQuestionmodel = QuizQuestionModel();
  final quizBankController = Get.put(QuizBankController());
  final quizCategoryController = Get.put(QuizCategoryController());

  @override
  _FlutterQuizScreenState createState() => _FlutterQuizScreenState();
}

class _FlutterQuizScreenState extends State<QuizBankScreen> {
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
                    vertical: 2 * SizeConfig.heightMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.quizBankController.quizBank.length == 0) {
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
                                    widget.quizBankController.quizBank,
                              ));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 5 * SizeConfig.heightMultiplier,
                        width: 20 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primarycolor),
                        child: Text(
                          "Generate",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 2 * SizeConfig.textMultiplier,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.quizBankController.deleteAllFromQuizBank(
                                  widget.quizBankController.quizBank);
                            },
                            child: Text(
                              "Clear all",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          // Checkbox(
                          //   checkColor: Colors.greenAccent,
                          //   activeColor: Colors.red,
                          //   value: this.allValue,
                          //   onChanged: (bool value) {
                          //     setState(() {
                          //       this.allValue = value;
                          //       if (allValue == true) {
                          //         for (int i = 0;
                          //             i <
                          //                 widget
                          //                     .quizQuestionController.quiz.length;
                          //             i++) {
                          //           widget.userController.addQuestion(
                          //               widget.quizQuestionController.quiz[i]);
                          //           print("question added");
                          //           print(widget
                          //               .userController.questionList.length);
                          //         }
                          //       } else {
                          //         widget.userController.questionList.length = 0;
                          //         print("Remove Questions ");
                          //         print(
                          //             widget.userController.questionList.length);
                          //       }

                          //       // print(this.valuefirst);
                          //     });
                          //   },
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GetX<QuizBankController>(
                init: Get.put<QuizBankController>(QuizBankController()),
                builder: (QuizBankController quizBankController) {
                  if (quizBankController != null &&
                      quizBankController.quizBank != null) {
                    return Expanded(
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: quizBankController.quizBank.length,
                          itemBuilder: (context, index) {
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
                                    widget.quizBankController
                                        .removeQuizBankQuestion(
                                            quizBankController
                                                .quizBank[index].id);

                                    // widget.quizQuestionController.removeQestion(
                                    //     widget.categoryId,
                                    //     quizBankController.quizBank[index].id);
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
                                //           questionController.quiz[index],
                                //     ));
                                //   },
                                // )
                              ],
                              child: ListTile(
                                title: QuestionOptionScreen(
                                  valuefirst: allValue,
                                  // checkModel: questionController.quiz,
                                  index: index,
                                  //ques: flutter[index],
                                  questionModel:
                                      quizBankController.quizBank[index],
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     print("id from Flutter Quiz Screen ${widget.categoryId}");

      //     Get.to(GenerateQuiz(
      //       categoryId: widget.categoryId,
      //     ));
      //   },
      //   child: Container(
      //     height: 07 * SizeConfig.heightMultiplier,
      //     width: 50 * SizeConfig.widthMultiplier,
      //     decoration: BoxDecoration(
      //         color: primarycolor, borderRadius: BorderRadius.circular(50)),
      //     child: Center(
      //         child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Add a new Question   ",
      //           style:
      //               TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      //         ),
      //         Icon(
      //           Icons.add,
      //           color: Colors.white,
      //           size: 19,
      //         )
      //       ],
      //     )),
      //   ),
      // ),
    );
  }
}
