import 'package:flutter/material.dart';
import 'package:quizapp/Models/getUserQuestoinModel.dart';

import 'Views/Screens/UserScreens/QuizScreen/Components/QuizQuestionContainer.dart';

class Check extends StatefulWidget {
  Check({this.question});
  List<GetUserQuestionModel> question;
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  // initState() {
  //   super.initState();
  //   //  this.initDynamicLinks();
  //   print("Enter in init");
  // }

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //     final Uri deepLink = dynamicLink?.link;
  //     print("deeplink found");
  //     if (deepLink != null) {
  //       print(deepLink);
  //       Get.to(() => UserScreenLogin());
  //     }
  //   }, onError: (OnLinkErrorException e) async {
  //     print("deeplink error");
  //     print(e.message);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            QuizQuestionContainer(
              i: 1,
              question: widget.question[1].question,
            ),
            // GetX<UserQuestionController>(
            //   init: Get.put<UserQuestionController>(UserQuestionController()),
            //   builder: (UserQuestionController userQuestionController) {
            //     if (userQuestionController != null &&
            //         userQuestionController.questionList != null) {
            //       return QuizQuestionContainer(
            //         i: 1,
            //         question: userQuestionController.questionList[1].question,
            //       );
            //     } else {
            //       return Text(
            //         "loading...",
            //         style: TextStyle(fontSize: 20, color: Colors.black),
            //       );
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
