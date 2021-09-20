import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/allQuizController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/UserResult/showAllUser.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';

class AllQuiz extends StatelessWidget {
  AllQuiz({this.isAdmin});
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());

  // final AllQuizController allQuizController = Get.put(AllQuizController());
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CommonBackground(
        childd: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "User Quiz",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 3 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // allQuizController.myQuizes.length == 0
            //     ? Center(
            //         child: Text("No quiz assigned yet"),
            //       )
            //     :
            GetX<AllQuizController>(
              init: Get.put<AllQuizController>(AllQuizController()),
              builder: (AllQuizController allQuizController) {
                if (allQuizController != null &&
                    allQuizController.myQuizes != null) {
                  return Container(
                    height: 74 * SizeConfig.heightMultiplier,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: allQuizController.myQuizes.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            userQuestionController.quizIDForUpdate =
                                allQuizController.myQuizes[index].id.obs;

                            userController.getUserForQuiz(
                                allQuizController.myQuizes[index].id);
                            // userQuestionController.getUserId(
                            //     allQuizController.myQuizes[index].id);
                            // userQuestionController.quizIDForUpdate =
                            //     allQuizController.myQuizes[index].id.obs;

                            // if (isAdmin == true) {
                            //   Get.to(() => QuizDetail(quizID: "HH"));
                            // } else {
                            //   userQuestionController.quizIDForUpdate =
                            //       allQuizController.myQuizes[index].id.obs;
                            //   userQuestionController.getUserId(
                            //       allQuizController.myQuizes[index].id);
                            Get.to(() => ShowAllUsers());
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              height: 10 * SizeConfig.heightMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2 * SizeConfig.widthMultiplier),
                                child: Row(
                                  children: [
                                    Text(
                                      "${index + 1}) ${allQuizController.myQuizes[index].quizName}",
                                      style: TextStyle(
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
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
      )),
    );
  }
}

//  onLongPress: () {
//                             if (isAdmin == true) {
//                               Get.defaultDialog(
//                                   title: "Delete Quiz",
//                                   middleText: "You want to delete this Quiz?",
//                                   // confirm: Text(""),
//                                   actions: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         print("Press");
//                                         print(userQuestionController
//                                             .userID.value);
//                                         print(allQuizController
//                                             .myQuizes[index].id);
//                                         firebaseFirestore
//                                             .collection("user")
//                                             .doc(userQuestionController
//                                                 .userID.value)
//                                             .collection("MYQuiz")
//                                             .doc(allQuizController
//                                                 .myQuizes[index].id)
//                                             .delete()
//                                             .then((value) {
//                                           print("Dlete");
//                                           Get.back();
//                                         });
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: 4 * SizeConfig.heightMultiplier,
//                                         width: 15 * SizeConfig.widthMultiplier,
//                                         decoration: BoxDecoration(
//                                             color: Colors.red,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Text(
//                                           "Delete",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 2 *
//                                                   SizeConfig.textMultiplier),
//                                         ),
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       onTap: () {
//                                         Get.back();
//                                       },
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         height: 4 * SizeConfig.heightMultiplier,
//                                         width: 15 * SizeConfig.widthMultiplier,
//                                         decoration: BoxDecoration(
//                                             color: Colors.blue,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Text(
//                                           "Cancel",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 2 *
//                                                   SizeConfig.textMultiplier),
//                                         ),
//                                       ),
//                                     )
//                                   ]);
//                               //
//                             }
//                           },