import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';

import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'Components/editQuizTextfield.dart';

class AdminQuizEditScreen extends StatefulWidget {
  const AdminQuizEditScreen(
      {Key key, this.index, this.quizQuestionModel, this.categoryId})
      : super(key: key);
  final int index;
  final QuizQuestionModel quizQuestionModel;
  final String categoryId;
  @override
  _FlutterQuizEditScreenState createState() => _FlutterQuizEditScreenState();
}

class _FlutterQuizEditScreenState extends State<AdminQuizEditScreen> {
  final quizQuestionController = Get.put(QuizQuestionController());
  @override
  void initState() {
    super.initState();
    questionController =
        TextEditingController(text: widget.quizQuestionModel.question);
    optionAcontroller =
        TextEditingController(text: widget.quizQuestionModel.option_1);
    optionBcontroller =
        TextEditingController(text: widget.quizQuestionModel.option_2);
    optionCcontroller =
        TextEditingController(text: widget.quizQuestionModel.option_3);
    optionDcontroller =
        TextEditingController(text: widget.quizQuestionModel.option_4);
    rightOptioncontroller =
        TextEditingController(text: widget.quizQuestionModel.rightOptoin);
  }

  TextEditingController questionController;

  TextEditingController optionAcontroller;

  TextEditingController optionBcontroller;

  TextEditingController optionCcontroller;

  TextEditingController optionDcontroller;
  TextEditingController rightOptioncontroller;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomething() async {
    Timer(
      Duration(seconds: 3),
      () {
        quizQuestionController.updateQestion(
            widget.categoryId,
            widget.quizQuestionModel.id,
            questionController.text,
            rightOptioncontroller.text,
            optionAcontroller.text,
            optionBcontroller.text,
            optionCcontroller.text,
            optionDcontroller.text);
        _btnController.success();
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CommonBackground(
        childd: SingleChildScrollView(
          child: Container(
            height: 100 * SizeConfig.heightMultiplier,
            width: 100 * SizeConfig.widthMultiplier,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2 * SizeConfig.heightMultiplier,
                  ),
                  EditingTextField(
                      title: "Question :",
                      width: 90 * SizeConfig.widthMultiplier,
                      maxl: 3,
                      border: 10,
                      controller: questionController),
                  EditingTextField(
                    title: "Option A :",
                    width: 50 * SizeConfig.widthMultiplier,
                    controller: optionAcontroller,
                    border: 50,
                  ),
                  EditingTextField(
                    title: "Option B :",
                    width: 50 * SizeConfig.widthMultiplier,
                    controller: optionBcontroller,
                    border: 50,
                  ),
                  EditingTextField(
                    title: "Option C :",
                    width: 50 * SizeConfig.widthMultiplier,
                    controller: optionCcontroller,
                    border: 50,
                  ),
                  EditingTextField(
                    title: "Option D :",
                    width: 50 * SizeConfig.widthMultiplier,
                    controller: optionDcontroller,
                    border: 50,
                  ),
                  EditingTextField(
                    title: "Right Option :",
                    width: 50 * SizeConfig.widthMultiplier,
                    controller: rightOptioncontroller,
                    border: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RoundedLoadingButton(
                        width: 40 * SizeConfig.widthMultiplier,
                        color: primarycolor,
                        child:
                            Text('Save', style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: _doSomething,
                      ),
                      SizedBox(
                        width: 2 * SizeConfig.widthMultiplier,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
