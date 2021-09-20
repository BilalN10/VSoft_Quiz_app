import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminHomeScreen/adminHomeScreen.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminLoginScreen/adminLoginScreen.dart';

class AdminRoot extends StatelessWidget {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.put(UserController()).user != null && box.read("isAdmin")
          ? AdminHome()
          : AdminScreen();
    });
  }
}
