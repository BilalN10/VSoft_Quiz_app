import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserSignupScreen/UserSignup.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';
import 'package:get_storage/get_storage.dart';

class UserScreenLogin extends StatefulWidget {
  UserScreenLogin({Key key}) : super(key: key);

  @override
  _UserScreenLoginState createState() => _UserScreenLoginState();
}

class _UserScreenLoginState extends State<UserScreenLogin> {
  final userController = Get.put(UserController());
  final box = GetStorage();

  // final AllQuizController allQuizController = Get.put(AllQuizController());
  @override
  void initState() {
    userController.isSignIn = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        childd: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 05 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              SizedBox(
                  height: 10 * SizeConfig.heightMultiplier,
                  child: Image.asset("assets/Images/user.png")),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
              ),
              CommonTextField(
                controller: userController.userloginEmailController,
                title: "Email Address",
                hintText: "Enter your Email Address",
              ),
              SizedBox(height: 01 * SizeConfig.heightMultiplier),
              CommonTextField(
                controller: userController.userloginPasswordController,
                hintText: "Password",
                title: "Password",
              ),
              SizedBox(
                height: 08 * SizeConfig.heightMultiplier,
              ),
              GetX<UserController>(
                init: Get.put<UserController>(UserController()),
                builder: (UserController userController) {
                  return userController.isSignIn.value
                      ? CommonFlateButton(
                          height: 7.5 * SizeConfig.heightMultiplier,
                          width: 50 * SizeConfig.widthMultiplier,
                          title: "Signin",
                          pressed: () {
                            userController.isSignIn.value =
                                !userController.isSignIn.value;
                            userController.userLogin(
                                userController.userloginEmailController.text,
                                userController
                                    .userloginPasswordController.text);
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
                    "Did'nt have an account?  ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 1.7 * SizeConfig.textMultiplier),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(UserSignup());
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w800,
                          fontSize: 1.7 * SizeConfig.textMultiplier),
                    ),
                  )
                ],
              ),
              // GestureDetector(
              //     onTap: () {
              //       //firebaseAuth.signOut();
              //       print(box.read("isStudent"));
              //       print(userController.user.uid);
              //       //userController.student = null;

              //       //userid.value = "";
              //       // Get.to(UserScreenLogin());
              //     },
              //     child: Text(
              //       "LogOut",
              //       style: TextStyle(
              //         color: Colors.white,
              //         // fontSize: 01 * SizeConfig.heightMultiplier,
              //         decoration: TextDecoration.underline,
              //       ),
              //     )),
              SizedBox(
                height: 03 * SizeConfig.heightMultiplier,
              )
            ],
          ),
        ),
      ),
    );
  }
}
