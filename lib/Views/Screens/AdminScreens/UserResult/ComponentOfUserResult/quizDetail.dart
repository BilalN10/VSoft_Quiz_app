import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/UserResult/ComponentOfUserResult/results.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';

class QuizDetail extends StatelessWidget {
  QuizDetail({this.quizID});
  final String quizID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CommonBackground(
      childd: GetX<UserQuestionController>(
        init: Get.put<UserQuestionController>(UserQuestionController()),
        builder: (UserQuestionController quizQuestionController) {
          if (quizQuestionController != null &&
              quizQuestionController.questionList != null) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4 * SizeConfig.widthMultiplier,
                      vertical: 2 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonFlateButton(
                        height: 5 * SizeConfig.heightMultiplier,
                        width: 22 * SizeConfig.widthMultiplier,
                        pressed: () {
                          Get.to(() => Results());
                        },
                        title: "Check Result",
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70 * SizeConfig.heightMultiplier,
                  child: ListView.builder(
                      itemCount: quizQuestionController.questionList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 26 * SizeConfig.heightMultiplier,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    2 * SizeConfig.heightMultiplier),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${index + 1}) ${quizQuestionController.questionList[index].question}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "a) ${quizQuestionController.questionList[index].option_1}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "b) ${quizQuestionController.questionList[index].option_2}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "c) ${quizQuestionController.questionList[index].option_3}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "d) ${quizQuestionController.questionList[index].option_4}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Right Option",
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        SizedBox(
                                          width: 5 * SizeConfig.widthMultiplier,
                                        ),
                                        Text(
                                          quizQuestionController
                                              .questionList[index].rightOptoin,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "User Selection",
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        SizedBox(
                                          width: 5 * SizeConfig.widthMultiplier,
                                        ),
                                        Text(
                                          quizQuestionController
                                              .questionList[index]
                                              .userSelection,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            )
                          ],
                        );
                      }),
                ),
              ],
            );
          } else {
            return Text(
              "loading...",
              style: TextStyle(fontSize: 20, color: Colors.black),
            );
          }
        },
      ),
    ));
  }
}
