import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';

import 'ComponentsofUserScreen/listofUser.dart';

class UserScreen extends StatelessWidget {
  UserScreen({
    Key key,
    this.questionModel,
    this.checkModel,
  }) : super(key: key);
  final QuizQuestionModel questionModel;
  final List<QuizQuestionModel> checkModel;
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonBackground(
            childd: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 02 * SizeConfig.heightMultiplier,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    "Users",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  GetX<UserController>(
                    init: Get.put<UserController>(UserController()),
                    builder: (UserController userController) {
                      if (userController != null &&
                          userController.users != null) {
                        return Container(
                          height: 66 * SizeConfig.heightMultiplier,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: userController.users.length + 1,
                            itemBuilder: (_, index) {
                              print(
                                  "Total index is ${userController.users.length + 1} ");

                              if (index == userController.users.length) {
                                print("MY index is $index");
                                return SizedBox(
                                  height: 8 * SizeConfig.heightMultiplier,
                                );
                              } else {
                                return UsersList(
                                  // index: index,
                                  questionsList: checkModel,
                                  userModel: userController.users[index],
                                  quizQuestionModel: questionModel,
                                );
                              }
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
                  // UserResults(
                  //   title: "Abrar Ahmad",
                  //   numbers: "Generate Quiz",
                  // ),
                  // UserResults(
                  //   title: "Hamza Shehroz",
                  //   numbers: "Generate Quiz",
                  // ),
                  // UserResults(
                  //   title: "Amad Zahid",
                  //   numbers: "Generate Quiz",
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 2 * SizeConfig.heightMultiplier,
            right: 35 * SizeConfig.widthMultiplier,
            child: GestureDetector(
              onTap: () {
                checkModel.length = 0;
                userQuestionController.quizNameController.text = "";

                Get.back();
                //Get.offAll(AdminHome());
                // Get.to(AdminHome());
              },
              child: Container(
                alignment: Alignment.center,
                height: 8 * SizeConfig.heightMultiplier,
                width: 30 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primarycolor),
                child: Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
