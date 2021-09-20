import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';

class UserSignup extends StatefulWidget {
  UserSignup({Key key}) : super(key: key);

  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final userController = Get.put(UserController());
  //final allQuizController = Get.put(AllQuizController());

  final userQuestionController = Get.put(UserQuestionController());
  @override
  void initState() {
    userController.isLogin = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CommonBackground(
                childd: SingleChildScrollView(
                  child: Container(
                    height: 100 * SizeConfig.heightMultiplier,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 03 * SizeConfig.heightMultiplier,
                        ),
                        CommonTextField(
                          controller: userController.userNameController,
                          title: "Name",
                          hintText: "Enter your name",
                        ),
                        CommonTextField(
                          controller: userController.userEmailController,
                          title: "Email Address",
                          hintText: "Enter your email Address",
                        ),
                        CommonTextField(
                          controller: userController.userPhoneNumbertController,
                          title: "Phone Number",
                          hintText: "Enter your Phone Number",
                        ),
                        CommonTextField(
                          controller: userController.userPasswordController,
                          title: "Password",
                          hintText: "Enter your password",
                        ),
                        CommonTextField(
                          controller:
                              userController.userQualificationController,
                          title: "Qualification",
                          hintText: "Enter your qualification",
                        ),
                        CommonTextField(
                          controller: userController.appliedForController,
                          title: "Applied for",
                          hintText: "Applied for",
                        ),
                        SizedBox(
                          height: 01 * SizeConfig.heightMultiplier,
                        ),
                        GetX<UserController>(
                          init: Get.put<UserController>(UserController()),
                          builder: (UserController userController) {
                            return userController.isLogin.value
                                ? CommonFlateButton(
                                    height: 7.5 * SizeConfig.heightMultiplier,
                                    width: 50 * SizeConfig.widthMultiplier,
                                    title: "Signup",
                                    pressed: () {
                                      userController.isLogin.value =
                                          !userController.isLogin.value;
                                      userController.createUser(
                                          userController
                                              .userNameController.text,
                                          userController
                                              .userEmailController.text,
                                          userController
                                              .userPasswordController.text,
                                          int.parse(userController
                                              .userPhoneNumbertController.text),
                                          userController
                                              .userQualificationController.text,
                                          userController
                                              .appliedForController.text);
                                    },
                                  )
                                : CircularProgressIndicator();
                          },
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 1.7 * SizeConfig.textMultiplier),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(UserScreenLogin());
                              },
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 1.7 * SizeConfig.textMultiplier),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 01 * SizeConfig.heightMultiplier,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
