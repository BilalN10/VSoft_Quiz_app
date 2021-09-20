import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Models/userModel.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserHomeScreen/userHomeScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class UserList extends StatefulWidget {
  UserList({
    Key key,
    this.userModel,
  }) : super(key: key);

  final UserModel userModel;
  // final QuizQuestionModel quizQuestionModel;
  //final List<QuizQuestionModel> checkModel;

  @override
  _UserResultsState createState() => _UserResultsState();
}

class _UserResultsState extends State<UserList> {
  bool checkBoxValue = false;

  final UserController userController = Get.put(UserController());
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15 * SizeConfig.heightMultiplier,
      child: Column(
        children: [
          Container(
            height: 10 * SizeConfig.heightMultiplier,
            width: 90 * SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                SizedBox(
                  width: 2 * SizeConfig.widthMultiplier,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.userModel.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 3 * SizeConfig.textMultiplier,
                        )),
                    Row(
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
                      ],
                    ),
                  ],
                ),

                // SizedBox(
                //   width: 10 * SizeConfig.widthMultiplier,
                // ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // userQuestionController.getUserId(widget.userModel.userid);
                    userController.userId = widget.userModel.userid.obs;

                    Get.to(UserHomeScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 5 * SizeConfig.heightMultiplier,
                    width: 23 * SizeConfig.widthMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primarycolor,
                    ),
                    child: Text(
                      "Attempt Quiz",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 2 * SizeConfig.textMultiplier),
                    ),
                  ),
                ),
                // Checkbox(
                //     value: checkBoxValue,
                //     onChanged: (value) {
                //       setState(() {
                //         checkBoxValue = value;
                //         if (checkBoxValue == true) {
                //           userController.addQuestionToUser(
                //               widget.checkModel, widget.userModel.userid);
                //         } else {
                //           userController.deleteAll(widget.userModel.userid);
                //         }
                //       });
                //     }),
                // RoundedLoadingButton(
                //   width: 20 * SizeConfig.widthMultiplier,
                //   color: primarycolor,
                //   child: Text('Generate', style: TextStyle(color: Colors.white)),
                //   controller: _btnController,
                //   onPressed: _doSomething,
                // ),
                SizedBox(
                  width: 2 * SizeConfig.widthMultiplier,
                ),
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
}
