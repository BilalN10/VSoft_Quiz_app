import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/Screens/UserScreens/AllUsers/ComponentsOfAlluser/userList.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';

class AllUsersScreen extends StatelessWidget {
  // AllUsersScreen({
  //   Key key,
  //   this.questionModel,
  //   this.checkModel,
  // }) : super(key: key);
  // final QuizQuestionModel questionModel;
  // final List<QuizQuestionModel> checkModel;

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
                            itemCount: userController.users.length,
                            itemBuilder: (_, index) {
                              return UserList(
                                // checkModel: checkModel,
                                userModel: userController.users[index],
                                //quizQuestionModel: questionModel,
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
          // Positioned(
          //   bottom: 2 * SizeConfig.heightMultiplier,
          //   right: 35 * SizeConfig.widthMultiplier,
          //   child: GestureDetector(
          //     onTap: () {
          //       Get.back();
          //       //Get.offAll(AdminHome());
          //       // Get.to(AdminHome());
          //     },
          //     child: Container(
          //       alignment: Alignment.center,
          //       height: 8 * SizeConfig.heightMultiplier,
          //       width: 30 * SizeConfig.widthMultiplier,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50),
          //           color: primarycolor),
          //       child: Text(
          //         "Done",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
