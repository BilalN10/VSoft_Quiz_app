import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Models/userModel.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UsersList extends StatefulWidget {
  UsersList({
    Key key,
    this.userModel,
    this.quizQuestionModel,
    this.questionsList,
  }) : super(key: key);

  final UserModel userModel;
  final QuizQuestionModel quizQuestionModel;
  final List<QuizQuestionModel> questionsList;

  @override
  _UserResultsState createState() => _UserResultsState();
}

class _UserResultsState extends State<UsersList> {
  @override
  void initState() {
    // allQuizController.getuserid(widget.userModel.userid);
    super.initState();
    // userQuestionController.getUserId(widget.userModel.userid);
  }

  bool checkBoxValue = false;
  bool check = true;
  bool isadd = false;

  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  //final AllQuizController allQuizController = Get.put(AllQuizController());
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(
      Duration(seconds: 3),
      () {
        _btnController.success();

        print(widget.quizQuestionModel.question);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 15 * SizeConfig.heightMultiplier,
            width: 90 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 12 * SizeConfig.heightMultiplier,
                  width: 90 * SizeConfig.widthMultiplier,
                  //color: Colors.red,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3 * SizeConfig.widthMultiplier,
                            vertical: 2 * SizeConfig.heightMultiplier),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userModel.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 3 * SizeConfig.textMultiplier,
                                )),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Applied for   ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 2 * SizeConfig.textMultiplier,
                                    )),
                                Text(widget.userModel.appliedFor,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 3 * SizeConfig.textMultiplier,
                                    )),
                                // Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),

                      check && isadd == false
                          ? Checkbox(
                              value: checkBoxValue,
                              onChanged: (value) {
                                setState(() {
                                  //  check = !check;
                                  if (userQuestionController
                                              .quizNameController ==
                                          null ||
                                      userQuestionController
                                          .quizNameController.text.isEmpty) {
                                    Get.defaultDialog(
                                        title: "",
                                        middleText: "Please Enter quiz name",
                                        middleTextStyle: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                        actions: [quizNameDialog()]);
                                  } else {
                                    setState(() {
                                      checkBoxValue = value;
                                      // check = !check;
                                    });
                                    print(checkBoxValue);
                                    print(
                                      widget.userModel.userid,
                                    );

                                    if (checkBoxValue == true) {
                                      // userQuestionController.addQuestionToUser(
                                      //     widget.questionsList,
                                      //     widget.userModel.userid);

                                    }
                                  }
                                });
                              })
                          : CircularProgressIndicator()
                      //: CircularProgressIndicator()
                      // GetX<UserQuestionController>(
                      //   init: Get.put<UserQuestionController>(
                      //       UserQuestionController()),
                      //   builder: (UserQuestionController controller) {
                      //     return controller.isQuizAssign.value
                      //         ?
                      //   },
                      // ),
                      // GetX<UserQuestionController>(

                      //   builder: (controller) {
                      //   print(controller.isQuizAssign.value);
                      //   return
                      // }),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     getQuizController.getuserid(widget.userModel.userid);
                //     // allQuizController.getuserid(widget.userModel.userid);
                //     Get.to(() => AllQuiz(
                //           isAdmin: true,
                //         ));
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "See user Quiz",
                //       )
                //     ],
                //   ),
                // )
                // check
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           widget.userModel.isQuizAssign
                //               ? Text(
                //                   "Quiz assign",
                //                   style: TextStyle(
                //                     color: primarycolor,
                //                   ),
                //                 )
                //               : Text(
                //                   "Quiz not assigned",
                //                   style: TextStyle(
                //                     color: Colors.red,
                //                   ),
                //                 )
                //           // GetBuilder<UserQuestionController>(
                //           //     init: UserQuestionController(),
                //           //     builder: (value) => value.isQuizAssign.value == true
                //           //         ? Text(
                //           //             "Quiz assign",
                //           //             style: TextStyle(
                //           //               color: primarycolor,
                //           //             ),
                //           //           )
                //           //         : Text(
                //           //             "Quiz not assigned",
                //           //             style: TextStyle(
                //           //               color: Colors.red,
                //           //             ),
                //           //           )),
                //         ],
                //       )
                //     : CircularProgressIndicator(),

                // userQuestionController.questionList.length == null
                //     ? Text("Quiz not assign")
                //     : Text("Quiz assigned"),

                //     ? Text("Quiz not assign")
                //     : Text("Quiz assigned"),

                // SizedBox(
                //   width: 10 * SizeConfig.widthMultiplier,
                // ),

                // RoundedLoadingButton(
                //   width: 20 * SizeConfig.widthMultiplier,
                //   color: primarycolor,
                //   child: Text('Generate', style: TextStyle(color: Colors.white)),
                //   controller: _btnController,
                //   onPressed: _doSomething,
                // ),
                // SizedBox(
                //   width: 2 * SizeConfig.widthMultiplier,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 02 * SizeConfig.heightMultiplier,
          ),
        ],
      ),
    );
  }

  Widget quizNameDialog() {
    return Column(
      children: [
        CommonTextField(
          controller: userQuestionController.quizNameController,
          hintText: "Quiz Name",
          title: "Enter Quiz",
        ),
        CommonFlateButton(
          height: 5 * SizeConfig.heightMultiplier,
          width: 10 * SizeConfig.widthMultiplier,
          title: "Add",
          pressed: () {
            print(userQuestionController.quizNameController);
            // setState(() {
            //   check = !check;
            // });
            Get.back();
          },
        )
      ],
    );
  }
}
