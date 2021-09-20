import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/Views/Screens/AdminScreens/GenerateQuizScreen/generateQuiz.dart';

class EnterAmountValidation extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  int amountvalue;
  updateamoun(int value) {
    amountvalue = value;
    update();
  }

  String enterAmount(String value) {
    if (value.isEmpty) {
      return "Please Enter Amount";
    } else {
      return null;
    }
  }

  void onAmountValidate() {
    final isvalid = formkey.currentState.validate();
    if (isvalid) {
      Get.off(
          //Check()
          GenerateQuiz(
              // pages: amountvalue,
              ));
    } else {
      return;
    }
    formkey.currentState.save();
  }
}
