import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminQuizesScreen/GetuizLink/getQuizLink.dart';
import 'package:quizapp/Views/Screens/AdminScreens/GenerateQuizScreen/generateQuiz.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'AdminQuizEditScreen/Components/mcqContainer.dart';
import 'AdminQuizEditScreen/adminQuizEditScreen.dart';

class AdminQuizScreen extends StatefulWidget {
  //final String categoryId;
  final quizQuestionController = Get.put(QuizQuestionController());
  final userController = Get.put(UserController());
  final quizQuestionmodel = QuizQuestionModel();

  @override
  _FlutterQuizScreenState createState() => _FlutterQuizScreenState();
}

class _FlutterQuizScreenState extends State<AdminQuizScreen> {
  bool allValue = false;
  @override
  void initState() {
    //allValue = false;
    super.initState();
  }

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
                          setState(() {
                            allValue = false;
                          });
                          //
                          Get.to(() => GetQuizLink(
                              questionList:
                                  widget.userController.questionList));
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
                                        widget
                                            .quizQuestionController.quiz.length;
                                    i++) {
                                  widget.userController.addQuestion(
                                      widget.quizQuestionController.quiz[i]);
                                  print("question added");
                                  print(widget
                                      .userController.questionList.length);
                                }
                              } else {
                                widget.userController.questionList.length = 0;
                                print("Remove Questions ");
                                print(
                                    widget.userController.questionList.length);
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
              GetX<QuizQuestionController>(
                init: Get.put<QuizQuestionController>(QuizQuestionController()),
                builder: (QuizQuestionController questionController) {
                  if (questionController != null &&
                      questionController.quiz != null) {
                    return Expanded(
                      child: ListView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: questionController.quiz.length + 1,
                          itemBuilder: (context, index) {
                            if (index == questionController.quiz.length) {
                              return SizedBox(
                                height: 10 * SizeConfig.heightMultiplier,
                              );
                            }
                            questionController.singleQuizLength =
                                questionController.quiz.length;
                            print(
                                "Question length is ${questionController.quiz.length}");
                            return Slidable(
                              actionPane: SlidableDrawerActionPane(),

                              ///left side slide
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: "Delete",
                                  color: Colors.red.shade400,
                                  icon: Icons.delete,
                                  onTap: () {
                                    widget.quizQuestionController.removeQestion(
                                        widget.quizQuestionController
                                            .quizCategoryID.value,
                                        questionController.quiz[index].id);
                                  },
                                ),
                                IconSlideAction(
                                  caption: "Edit",
                                  color: Colors.blue.shade400,
                                  icon: Icons.edit,
                                  onTap: () {
                                    Get.to(AdminQuizEditScreen(
                                      categoryId: widget.quizQuestionController
                                          .quizCategoryID.value,
                                      index: index,
                                      quizQuestionModel:
                                          questionController.quiz[index],
                                    ));
                                  },
                                )
                              ],
                              child: ListTile(
                                title: McqContainer(
                                  valuefirst: allValue,
                                  checkModel: questionController.quiz,
                                  index: index,
                                  //ques: flutter[index],
                                  questionModel: questionController.quiz[index],
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
          print(
              "id from Flutter Quiz Screen ${widget.quizQuestionController.quizCategoryID.value}");

          Get.to(GenerateQuiz(
            categoryId: widget.quizQuestionController.quizCategoryID.value,
          ));
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
                "Add a new Question   ",
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
