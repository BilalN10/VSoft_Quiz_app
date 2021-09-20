import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/adminController.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';

class AdminSignUP extends StatefulWidget {
  AdminSignUP({Key key}) : super(key: key);

  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<AdminSignUP> {
  //final userController = Get.put(UserController());
  //final allQuizController = Get.put(AllQuizController());
  final AdminController adminController = Get.put(AdminController());

  // @override
  // void initState() {
  //   userController.isLogin = true.obs;
  //   super.initState();
  // }

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
                          controller: adminController.adminNameController,
                          title: "Name",
                          hintText: "Enter your name",
                        ),
                        CommonTextField(
                          controller:
                              adminController.adminSignUPEmailController,
                          title: "Email Address",
                          hintText: "Enter your email Address",
                        ),

                        CommonTextField(
                          controller:
                              adminController.adminSignUPpaswrdController,
                          title: "Password",
                          hintText: "Enter your password",
                        ),

                        SizedBox(
                          height: 01 * SizeConfig.heightMultiplier,
                        ),
                        GetX<AdminController>(
                          init: Get.put<AdminController>(AdminController()),
                          builder: (AdminController adminController) {
                            return adminController.isSignUp.value
                                ? CommonFlateButton(
                                    height: 7.5 * SizeConfig.heightMultiplier,
                                    width: 50 * SizeConfig.widthMultiplier,
                                    title: "Signin",
                                    pressed: () {
                                      adminController.isSignUp.value =
                                          !adminController.isSignUp.value;
                                      print(adminController.isSignUp.value);

                                      adminController.createAdmin(
                                          adminController
                                              .adminSignUPEmailController.text,
                                          adminController
                                              .adminSignUPpaswrdController.text,
                                          adminController
                                              .adminNameController.text);

                                      // adminController.adminLogin(
                                      //     adminController.adminEmailController.text,
                                      //     adminController.adminPasswordController.text);
                                    },
                                  )
                                : CircularProgressIndicator();
                          },
                        ),
                        // CommonFlateButton(
                        //   height: 7.5 * SizeConfig.heightMultiplier,
                        //   width: 50 * SizeConfig.widthMultiplier,
                        //   title: "Signup",
                        //   pressed: () {
                        //     adminController.createAdmin(
                        //         adminController.adminSignUPEmailController.text,
                        //         adminController
                        //             .adminSignUPpaswrdController.text,
                        //         adminController.adminNameController.text);
                        //   },
                        // ),
                        // GetX<UserController>(
                        //   init: Get.put<UserController>(UserController()),
                        //   builder: (UserController userController) {
                        //     return userController.isLogin.value
                        //         ? CommonFlateButton(
                        //             height: 7.5 * SizeConfig.heightMultiplier,
                        //             width: 50 * SizeConfig.widthMultiplier,
                        //             title: "Signup",
                        //             pressed: () {
                        //               userController.isLogin.value =
                        //                   !userController.isLogin.value;
                        //               userController.createUser(
                        //                   userController
                        //                       .userNameController.text,
                        //                   userController
                        //                       .userEmailController.text,
                        //                   userController
                        //                       .userPasswordController.text,
                        //                   int.parse(userController
                        //                       .userPhoneNumbertController.text),
                        //                   userController
                        //                       .userQualificationController.text,
                        //                   userController
                        //                       .appliedForController.text);
                        //             },
                        //           )
                        //         : CircularProgressIndicator();
                        //   },
                        // ),
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
