import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/adminController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminSignUp/AdminSignUp.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key key}) : super(key: key);
  final adminController = Get.put(AdminController());

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
                  child: Image.asset("assets/Images/admin.png")),
              SizedBox(
                height: 08 * SizeConfig.heightMultiplier,
              ),
              CommonTextField(
                controller: adminController.adminEmailController,
                title: "Email Address",
                hintText: "Enter your Email Address",
              ),
              SizedBox(height: 01 * SizeConfig.heightMultiplier),
              CommonTextField(
                controller: adminController.adminPasswordController,
                hintText: "Password",
                title: "Password",
              ),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
              ),
              GetX<AdminController>(
                init: Get.put<AdminController>(AdminController()),
                builder: (AdminController adminController) {
                  return adminController.isLogin.value
                      ? CommonFlateButton(
                          height: 7.5 * SizeConfig.heightMultiplier,
                          width: 50 * SizeConfig.widthMultiplier,
                          title: "Signin",
                          pressed: () {
                            adminController.isLogin.value =
                                !adminController.isLogin.value;
                            adminController.adminLogin(
                                adminController.adminEmailController.text,
                                adminController.adminPasswordController.text);
                          },
                        )
                      : CircularProgressIndicator();
                },
              ),
              // CommonFlateButton(
              //   height: 7.5 * SizeConfig.heightMultiplier,
              //   width: 50 * SizeConfig.widthMultiplier,
              //   title: "Signin",
              //   pressed: () {
              //     adminController.adminLogin(
              //         adminController.adminEmailController.text,
              //         adminController.adminPasswordController.text);
              //   },
              // ),
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
                      Get.to(AdminSignUP());
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
