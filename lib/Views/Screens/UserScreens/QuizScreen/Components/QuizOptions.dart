import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/getUserQuestoinModel.dart';

import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/constants.dart';

// ignore: must_be_immutable
class QuizOptions extends StatefulWidget {
  QuizOptions({
    Key key,
    // this.option,
    this.currentIndex,
    this.questionModel,
    this.questionList,
    this.adminIdFromurl,
    this.quizIdFromUrl,
    this.studentid,

    //this.press,
    //this.selectedoption,
    // this.questionModel, this.qlist,
  }) : super(key: key);
  final int currentIndex;

  final String adminIdFromurl;
  final String quizIdFromUrl;
  final String studentid;

  // final String option;
  // final VoidCallback press;
  // final int selectedoption;
  // final GetUserQuestionModel questionModel;
  final List<GetUserQuestionModel> questionList;
  final GetUserQuestionModel questionModel;
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());

  @override
  _QuizOptionsState createState() => _QuizOptionsState();
}

class _QuizOptionsState extends State<QuizOptions> {
  @override
  void initState() {
    super.initState();
    print("initState call");
    print("quiz id is ${widget.quizIdFromUrl}}");
    print("Admin id is ${widget.adminIdFromurl}");
    print("student id is ${widget.studentid}");
    // firebaseFirestore
    //     .collection("Admin")
    //     .doc(widget.userQuestionController.adminIdFromUrl.value)
    //     .collection("MYQuiz")
    //     .doc(widget.userQuestionController.quizIdFromUrl.value)
    //     .collection("Question")
    //     .get();
    DocumentReference docRef = firebaseFirestore
        .collection("Admin")
        .doc(widget.adminIdFromurl)
        .collection("MYQuiz")
        .doc(widget.quizIdFromUrl);
    docRef.get().then((datashnapshot) {
      if (datashnapshot.exists) {
        firebaseFirestore
            .collection("Admin")
            .doc(widget.adminIdFromurl)
            .collection("MYQuiz")
            .doc(widget.quizIdFromUrl)
            .collection("Student")
            .doc(widget.studentid)
            .collection("Attempted Quiz")
            .doc(widget.quizIdFromUrl)
            .set({
          "quizName": datashnapshot.data()["quizName"],
          "time": DateTime.now(),
        }).then((value) {
          for (int i = 0; i < widget.questionList.length; i++) {
            firebaseFirestore
                .collection("Admin")
                .doc(widget.adminIdFromurl)
                .collection("MYQuiz")
                .doc(widget.quizIdFromUrl)
                .collection("Student")
                .doc(widget.studentid)
                .collection("Attempted Quiz")
                .doc(widget.quizIdFromUrl)
                .collection("Question")
                .doc(widget.questionList[i].id)
                .set({
              "question": widget.questionList[i].question,
              "option1": widget.questionList[i].option_1,
              "option2": widget.questionList[i].option_2,
              "option3": widget.questionList[i].option_3,
              "option4": widget.questionList[i].option_4,
              "rightOption": widget.questionList[i].rightOptoin,
              "dateTime": DateTime.now(),
              "userSelection": "",
            });
          }
        }).then((value) {
          docRef.get().then((datashnapshot) {
            firebaseFirestore
                .collection("user")
                .doc(widget.studentid)
                .collection("QuizHistory")
                .doc(widget.quizIdFromUrl)
                .set({
              "quizName": datashnapshot.data()["quizName"],
              "time": DateTime.now(),
            });
          });

          // DocumentReference docforhistory = firebaseFirestore
          //     .collection("Admin")
          //     .doc(widget.adminIdFromurl)
          //     .collection("MYQuiz")
          //     .doc(widget.quizIdFromUrl)
          //     .collection("Student")
          //     .doc(widget.studentid)
          //     .collection("Attempted Quiz")
          //     .doc(widget.quizIdFromUrl);
          // docforhistory.get().then((value) {
          //   firebaseFirestore
          //       .collection("user")
          //       .doc(widget.studentid)
          //       .collection("History")
          //       .add({"History": docforhistory});
          // });
        });
      }
    });
  }

  int myIndex = 0;

  List<String> abcd = ["a)", "b)", "c)", "d)"];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        optionContainer(widget.questionModel.option_1, 1),
        optionContainer(widget.questionModel.option_2, 2),
        optionContainer(widget.questionModel.option_3, 3),
        optionContainer(widget.questionModel.option_4, 4),

        //optionContainer(widget.option1, 3),
        //optionContainer(widget.option2, 4),
      ],
    );
  }

  Widget optionContainer(String option, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 01 * SizeConfig.heightMultiplier),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 05 * SizeConfig.widthMultiplier),
          GestureDetector(
            onTap: () {
              widget.userQuestionController.updateUpdateUserSelection(
                  adminId: widget.adminIdFromurl,
                  questionId: widget.questionModel.id,
                  quizId: widget.quizIdFromUrl,
                  studentId: widget.studentid,
                  userSelection: option);
              //print("MY index is ${widget.currentIndex}");
              setState(() {
                selectedIndex = index;

                myIndex = widget.currentIndex;
              });
            },
            child: Container(
              height: 06 * SizeConfig.heightMultiplier,
              width: 85 * SizeConfig.widthMultiplier,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border:
                      selectedIndex == index && myIndex == widget.currentIndex
                          ? Border.all(width: 3, color: primarycolor)
                          : null,
                  boxShadow: [
                    BoxShadow(color: Colors.black45, blurRadius: 10)
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 05 * SizeConfig.widthMultiplier,
                  ),
                  Text(
                    abcd[index - 1], // abcd[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                  SizedBox(
                    width: 03 * SizeConfig.widthMultiplier,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 60 * SizeConfig.widthMultiplier,
                    height: 6 * SizeConfig.heightMultiplier,
                    //  color: Colors.blue,
                    child: Text(
                      option.trim(),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      // overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  selectedIndex == index && myIndex == widget.currentIndex
                      ? Container(
                          height: 03 * SizeConfig.heightMultiplier,
                          width: 06 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              color: primarycolor, shape: BoxShape.circle),
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 03 * SizeConfig.widthMultiplier,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
