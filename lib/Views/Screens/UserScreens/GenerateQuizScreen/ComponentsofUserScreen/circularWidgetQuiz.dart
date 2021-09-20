// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quizapp/Controllers/userQuestionController.dart';

// class CircularWidget extends StatefulWidget {
//   @override
//   _CircularWidgetState createState() => _CircularWidgetState();
// }

// class _CircularWidgetState extends State<CircularWidget> {
//   bool checkBoxValue = false;

//   final UserQuestionController userQuestionController =
//       Get.put(UserQuestionController());

//   @override
//   Widget build(BuildContext context) {
//     return GetX<UserQuestionController>(
//       init: Get.put<UserQuestionController>(UserQuestionController()),
//       builder: (UserQuestionController controller) {
//         return controller.isQuizAssign.value
//             ? Checkbox(
//                 value: checkBoxValue,
//                 onChanged: (value) {
//                   setState(() {
//                     checkBoxValue = value;
//                     if (checkBoxValue == true) {
//                       // userQuestionController
//                       // .addQuestionToUser(
//                       //     widget.questionsList, widget.userModel.userid)
//                       //     .then((value) {
//                       //      //   print("Condition is ${controller.isQuizAssign.value}");
//                       // });
//                       // print(widget.questionsList.length);
//                       controller.isQuizAssign.value =
//                           !controller.isQuizAssign.value;
//                     } else {
//                       // print(widget.questionsList.length);

//                       // userQuestionController.deleteAll(
//                       //     widget.userModel.userid, widget.questionsList);
//                     }
//                   });
//                 })
//             : CircularProgressIndicator();
//       },
//     );
//   }
// }
