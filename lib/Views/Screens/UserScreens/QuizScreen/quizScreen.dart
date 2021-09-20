import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/resultController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/getUserQuestoinModel.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizFinishedScreen/quizFinished.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizScreen/Components/QuizQuestionContainer.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/constants.dart';
import 'Components/NextButton.dart';
import 'Components/QuestionNumberContainer.dart';
import 'Components/QuizOptions.dart';

class QuizScreen extends StatefulWidget {
  final String adminIdFromurl;
  final String quizIdFromUrl;
  final String studentid;
  QuizScreen({this.adminIdFromurl, this.quizIdFromUrl, this.studentid});
  // QuizScreen({this.questionList});
  //  List<GetUserQuestionModel> questionList = [];
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // final RoundedLoadingButtonController _btnController =
  //     new RoundedLoadingButtonController();
  UserQuestionController userQuestionController = Get.find();

  UserController userController = Get.put(UserController());

  bool changeState = false;

  void _doSomething() async {
    Timer(
      Duration(seconds: 1),
      () {
        //_btnController.success();
        Get.off(QuizFinished(
          finalresult: result,
          adminIdFromurl: widget.adminIdFromurl,
          quizIdFromUrl: widget.quizIdFromUrl,
          studentid: widget.studentid,
        ));
      },
    );
  }

  Timer _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (currentindex == userQuestionController.questionList?.length ?? 0) {
          Get.off(QuizFinished(
            finalresult: result,
          ));
        } else if (_start == 0) {
          setState(() {
            currentindex += 1;
            _start = 15;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    userQuestionController.getUserId(
        widget.adminIdFromurl, widget.quizIdFromUrl);

    // print(userQuestionController.questionList.length);
    //userQuestionController.getUserId();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  int currentindex = 0;
  int result = 0;
  int selectedoption = -1;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Column(
    //     children: [],
    //   ),
    // );
    return Scaffold(
      backgroundColor: secondarycolor,
      // body: SafeArea(
      //     child: Column(
      //   children: [
      //     Text(
      //       widget.questionList[currentindex].question,
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),
      //     ),
      //     Text(
      //       "$_start secs",
      //       style:
      //           TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
      //     ),
      //   ],
      // )));
      body: currentindex == userQuestionController.questionList?.length ?? 0
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // QuizQuestionContainer(
                //   i: currentindex,
                //   question: widget.questionList[currentindex].question,
                // ),

                GetX<UserQuestionController>(
                  init:
                      Get.put<UserQuestionController>(UserQuestionController()),
                  builder: (UserQuestionController userQuestionController) {
                    if (userQuestionController != null &&
                        userQuestionController.questionList != null) {
                      return QuizQuestionContainer(
                        i: currentindex,
                        question: userQuestionController
                            .questionList[currentindex].question,
                      );
                    } else {
                      return Text(
                        "loading...",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 1 * SizeConfig.heightMultiplier,
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 42 * SizeConfig.widthMultiplier,
                //     ),
                QuestionNumberContainer(
                    totalQuestion:
                        userQuestionController.questionList?.length ?? 0,
                    currentindex: currentindex + 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 7 * SizeConfig.widthMultiplier),
                      child: Container(
                        height: 5 * SizeConfig.heightMultiplier,
                        width: 40 * SizeConfig.widthMultiplier,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 0 * SizeConfig.widthMultiplier),
                              child: Text(
                                "Time Left :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            Text(
                              "$_start secs",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //     SizedBox(
                //       width: 0 * SizeConfig.widthMultiplier,
                //     )
                //   ],
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 02 * SizeConfig.widthMultiplier,
                      vertical: 03 * SizeConfig.heightMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //QuizOptions(
                      //   questionList: widget.questionList,
                      //   // change: changeState,
                      //   questionModel: widget.questionList[currentindex],
                      //   currentIndex: currentindex,
                      // ),
                      GetX<UserQuestionController>(
                        init: Get.put<UserQuestionController>(
                            UserQuestionController()),
                        builder:
                            (UserQuestionController userQuestionController) {
                          // print("Index is is $currentindex  ");
                          if (userQuestionController != null &&
                              userQuestionController.questionList != null) {
                            // print("Enter in quizOption");

                            return QuizOptions(
                              adminIdFromurl: widget.adminIdFromurl,
                              quizIdFromUrl: widget.quizIdFromUrl,
                              studentid: widget.studentid,

                              questionList: userQuestionController.questionList,
                              // change: changeState,
                              questionModel: userQuestionController
                                  .questionList[currentindex],
                              currentIndex: currentindex,
                            );
                          } else {
                            return Text(
                              "loading...",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 03 * SizeConfig.heightMultiplier,
                      ),

                      userQuestionController.questionList != null
                          ? Row(
                              children: [
                                Spacer(),
                                if (currentindex ==
                                    userQuestionController.questionList.length -
                                        1) ...[
                                  NextButton(
                                    pressed: () {
                                      _doSomething();
                                    },
                                    title: "Finish",
                                  ),
                                ] else ...[
                                  NextButton(
                                    pressed: () {
                                      setState(() {
                                        currentindex++;
                                        _start = 15;
                                        selectedoption = -1;
                                        changeState = false;
                                      });
                                    },
                                    title: "Next",
                                  )
                                ]
                              ],
                            )
                          : Text("Loading")
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
