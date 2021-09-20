import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/resultController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Models/userModel.dart';
import 'package:quizapp/Views/Screens/AdminScreens/UserResult/ComponentOfUserResult/results.dart';
import 'package:quizapp/Views/Screens/UserScreens/AllQuiz/allQuizScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserResults extends StatefulWidget {
  UserResults({
    Key key,
    this.userModel,
  }) : super(key: key);

  final UserModel userModel;
  // final QuizQuestionModel quizQuestionModel;
  // final List<QuizQuestionModel> questionsList;

  @override
  _UserResultsState createState() => _UserResultsState();
}

class _UserResultsState extends State<UserResults> {
  @override
  void initState() {
    super.initState();
  }

  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());

  final ResultContoller resultContoller = Get.put(ResultContoller());

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(
      Duration(seconds: 3),
      () {
        _btnController.success();

        //  print(widget.quizQuestionModel.question);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userQuestionController.userID = widget.userModel.userid.obs;
        resultContoller.getUserResult();
        Get.to(() => Results(
              userName: widget.userModel.name,
            ));
        // resultContoller.getId(widget.userModel.userid);
        // Get.to(Results(
        //   userName: widget.userModel.name,
        // ));
      },
      child: Container(
        height: 18 * SizeConfig.heightMultiplier,
        width: 90 * SizeConfig.widthMultiplier,
        margin: EdgeInsets.only(bottom: 2 * SizeConfig.heightMultiplier),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 15 * SizeConfig.heightMultiplier,
                width: 90 * SizeConfig.widthMultiplier,
                // color: Colors.red,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Name:",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text("Applied for:",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text("Email: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text("Qualification",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(widget.userModel.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text(widget.userModel.appliedFor,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text(widget.userModel.email,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                        Text(widget.userModel.qualification,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 2 * SizeConfig.textMultiplier,
                            )),
                      ],
                    ),
                    SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// onLongPress: () {
//         Get.defaultDialog(
//             title: "Delete Quiz",
//             middleText: "You want to delete this User",
//             // confirm: Text(""),
//             actions: [
//               GestureDetector(
//                 onTap: () {
//                   print("Press");
//                   //  print(userQuestionController.userID.value);
//                   // print(allQ
//                   //     .myQuizes[index].id);
//                   firebaseFirestore
//                       .collection("user")
//                       .doc(widget.userModel.userid)
//                       .delete()
//                       .then((value) {
//                     print("Dlete");
//                     Get.back();
//                   });
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 4 * SizeConfig.heightMultiplier,
//                   width: 15 * SizeConfig.widthMultiplier,
//                   decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Text(
//                     "Delete",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 2 * SizeConfig.textMultiplier),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 4 * SizeConfig.heightMultiplier,
//                   width: 15 * SizeConfig.widthMultiplier,
//                   decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 2 * SizeConfig.textMultiplier),
//                   ),
//                 ),
//               )
//             ]);
//         //
//       },
