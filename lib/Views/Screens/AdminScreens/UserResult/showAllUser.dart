import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';
import 'ComponentOfUserResult/allusersResult.dart';

class ShowAllUsers extends StatefulWidget {
  @override
  _ShowAllUsersState createState() => _ShowAllUsersState();
}

class _ShowAllUsersState extends State<ShowAllUsers> {
  final TextEditingController searchController = TextEditingController();

  final UserController userController = Get.put(UserController());

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
                    child: TextFormField(
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {});
                      },
                      cursorColor: secondarycolor,
                      controller: searchController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search user",
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  GetX<UserController>(
                    init: Get.put<UserController>(UserController()),
                    builder: (UserController userController) {
                      if (userController != null &&
                          userController.users != null) {
                        return Container(
                          height: 68 * SizeConfig.heightMultiplier,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: userController.users.length,
                            itemBuilder: (_, index) {
                              return userController.users[index].name
                                      .toUpperCase()
                                      .contains(
                                          searchController.text.toUpperCase())
                                  ? UserResults(
                                      // index: index,
                                      // questionsList: checkModel,
                                      userModel: userController.users[index],
                                      //quizQuestionModel: questionModel,
                                    )
                                  : Container();
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
            ),
          ),
        ],
      ),
    );
  }

  // Widget generatedField({
  //   TextEditingController controller,
  //   String hintText,
  // }) {
  //   SizedBox(
  //     //height: 56,
  //     //width: SizeConfig.widthMultiplier * 100,
  //     child: TextFormField(
  //       maxLines: null,
  //       controller: controller,
  //       decoration: InputDecoration(
  //         fillColor: Colors.white,
  //         filled: true,
  //         hintText: hintText,
  //         contentPadding: EdgeInsets.symmetric(horizontal: 10),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         focusedErrorBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
