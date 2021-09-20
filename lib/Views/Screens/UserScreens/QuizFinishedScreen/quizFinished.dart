import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/resultController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Views/Screens/AdminUserSelectionPage/adminUserSelectionPage.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';

import '../../../constants.dart';

class QuizFinished extends StatefulWidget {
  const QuizFinished(
      {Key key,
      this.finalresult,
      this.adminIdFromurl,
      this.quizIdFromUrl,
      this.studentid})
      : super(key: key);
  final int finalresult;
  final String adminIdFromurl;
  final String quizIdFromUrl;
  final String studentid;

  @override
  _QuizFinishedState createState() => _QuizFinishedState();
}

class _QuizFinishedState extends State<QuizFinished> {
  final userQuestionController = Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());
  ResultContoller resultContoller = Get.put(ResultContoller());
  final box = GetStorage();
  bool showResult = false;
  // final quizQuestionController = Get.put(QuizQuestionController());
  @override
  void initState() {
    super.initState();
    resultContoller.getBindingStream(
        widget.studentid, widget.adminIdFromurl, widget.quizIdFromUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        childd: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Quiz has been submitted   ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 3 * SizeConfig.textMultiplier, color: Colors.white),
            ),
            SizedBox(
              height: 01 * SizeConfig.heightMultiplier,
            ),
            Text(
              "Thank You!",
              style: TextStyle(
                  color: primarycolor,
                  fontSize: 3 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier,
            ),
            showResult
                ? GetX<ResultContoller>(
                    init: Get.put<ResultContoller>(ResultContoller()),
                    builder: (ResultContoller resultContoller) {
                      if (resultContoller != null &&
                          resultContoller.reslutCalculate != null) {
                        return Text(
                          "Your result is ${resultContoller.result} / ${resultContoller.reslutCalculate.length}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 2 * SizeConfig.textMultiplier),
                        );
                      } else {
                        return Text(
                          "loading...",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        );
                      }
                    },
                  )
                : SizedBox(),

            // Obx(() {
            //   return
            // }),

            SizedBox(
              height: 05 * SizeConfig.heightMultiplier,
            ),

            showResult == false
                ? CommonFlateButton(
                    height: 7.5 * SizeConfig.heightMultiplier,
                    width: 50 * SizeConfig.widthMultiplier,
                    title: "Check reult",
                    pressed: () {
                      resultContoller.calulate();
                      setState(() {
                        showResult = !showResult;
                      });
                      print("User id ${userController.user.uid}");
                      firebaseFirestore
                          .collection("Admin")
                          .doc(widget.adminIdFromurl)
                          .collection("MYQuiz")
                          .doc(widget.quizIdFromUrl)
                          .collection("Student")
                          .doc(widget.studentid)
                          .collection("Attempted Quiz")
                          .doc(widget.quizIdFromUrl)
                          .collection("Result")
                          .add({
                        "time": DateTime.now(),
                        "obtainMarks": resultContoller.result.value,
                        "totalMarks": resultContoller.reslutCalculate.length
                      }).then((value) async {
                        box.write("isQuiz", false);
                        firebaseFirestore
                            .collection("user")
                            .doc(widget.studentid)
                            .collection("QuizHistory")
                            .doc(widget.quizIdFromUrl)
                            .collection("Result")
                            .add({
                          "time": DateTime.now(),
                          "obtainMarks": resultContoller.result.value,
                          "totalMarks": resultContoller.reslutCalculate.length
                        });

                        // print("Result Added");
                        // box.write("isQuiz", false);

                        // Get.offAll(() => AdminUserSelectionPage());
                      });
                    })
                : CommonFlateButton(
                    height: 7.5 * SizeConfig.heightMultiplier,
                    width: 50 * SizeConfig.widthMultiplier,
                    title: "Finish all",
                    pressed: () {
                      Get.offAll(() => AdminUserSelectionPage());
                    }),

            // RaisedButton(onPressed: () {})
            // TextContainer(
            //   title: "${widget.finalresult}/${questions.length} Marks",
            //   width: 40 * SizeConfig.widthMultiplier,
            //   height: 08 * SizeConfig.heightMultiplier,
            //   r: 50,
            // )
          ],
        ),
      ),
    );
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({
    Key key,
    this.title,
    this.height,
    this.width,
    this.r,
  }) : super(key: key);
  final String title;
  final double height;
  final double width;
  final double r;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: primarycolor, borderRadius: BorderRadius.circular(r)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 2.5 * SizeConfig.textMultiplier),
        ),
      ),
    );
  }
}
