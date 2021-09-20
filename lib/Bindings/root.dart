import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserHomeScreen/userHomeScreen.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:get_storage/get_storage.dart';

class Root extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.put(UserController()).user != null && box.read("isStudent")
          ? UserHomeScreen()
          : UserScreenLogin();
    });
  }
}
