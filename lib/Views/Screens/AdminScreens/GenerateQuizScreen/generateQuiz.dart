import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminHomeScreen/adminHomeScreen.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizScreen/Components/NextButton.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'Components/generateTextfields.dart';

class GenerateQuiz extends StatefulWidget {
  const GenerateQuiz({
    this.categoryId,
    Key key,
  }) : super(key: key);
  final String categoryId;

  @override
  _GenerateQuizState createState() => _GenerateQuizState();
}

class _GenerateQuizState extends State<GenerateQuiz> {
  final quizQuestionController = Get.put(QuizQuestionController());
  List<String> ceorrectOPt = []; // List<String>();
  int groupvalue = -1;
  final _formKey = GlobalKey<FormState>();

  String rightopt = "";

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _doSomething() async {
    Get.off(AdminHome());
    // Timer(
    //   Duration(seconds: 3),
    //   () {
    //     //_btnController.success();
    //     Get.off(AdminHome());
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CommonBackground(
      childd: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 05 * SizeConfig.heightMultiplier,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 05 * SizeConfig.heightMultiplier,
              ),

              Text(
                "Question",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 2 * SizeConfig.textMultiplier),
              ),
              SizedBox(
                height: 01 * SizeConfig.heightMultiplier,
              ),
              GenerateQuizTextField(
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Plase Enter some value";
                  } else {
                    return null;
                  }
                },
                contentPadding: true,
                // radioButton: Radio(
                //     activeColor: Colors.green,
                //     value: 1,
                //     groupValue: groupvalue,
                //     onChanged: (value) {
                //       setState(() {
                //         groupvalue = value;
                //       });
                //     }),
                value: quizQuestionController.questionController,
                height: 15 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                hinttext: "Enter Question",
                lines: 10,
                bordercircular: 10,
              ),
              SizedBox(
                height: 02 * SizeConfig.heightMultiplier,
              ),
              Text("Options : ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 2 * SizeConfig.textMultiplier)),
              SizedBox(
                height: 1.5 * SizeConfig.heightMultiplier,
              ),
              GenerateQuizTextField(
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Plase Enter some value";
                  } else {
                    return null;
                  }
                },
                contentPadding: false,
                radioButton: Radio(
                    activeColor: Colors.green,
                    value: 1,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value;
                        rightopt =
                            quizQuestionController.option1Controller.text;
                        // ceorrectOPt.insert(page, element)
                        print(groupvalue);
                      });
                    }),
                value: quizQuestionController.option1Controller,
                bordercircular: 50,
                height: 6 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                hinttext: "Enter Option",
                lines: 10,
              ),
              SizedBox(
                height: 1.5 * SizeConfig.heightMultiplier,
              ),
              GenerateQuizTextField(
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Plase Enter some value";
                  } else {
                    return null;
                  }
                },
                contentPadding: false,
                radioButton: Radio(
                    activeColor: Colors.green,
                    value: 2,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value;
                        rightopt =
                            quizQuestionController.option2Controller.text;

                        print(groupvalue);
                      });
                    }),
                value: quizQuestionController.option2Controller,
                bordercircular: 50,
                height: 6 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                hinttext: "Enter Option",
                lines: 10,
              ),
              SizedBox(
                height: 1.5 * SizeConfig.heightMultiplier,
              ),
              GenerateQuizTextField(
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Plase Enter some value";
                  } else {
                    return null;
                  }
                },
                contentPadding: false,
                radioButton: Radio(
                    activeColor: Colors.green,
                    value: 3,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value;
                        rightopt =
                            quizQuestionController.option3Controller.text;

                        print(groupvalue);
                      });
                    }),
                value: quizQuestionController.option3Controller,
                bordercircular: 50,
                height: 6 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                hinttext: "Enter Option",
                lines: 10,
              ),
              SizedBox(
                height: 1.5 * SizeConfig.heightMultiplier,
              ),
              GenerateQuizTextField(
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return "Plase Enter some value";
                  } else {
                    return null;
                  }
                },
                contentPadding: false,
                radioButton: Radio(
                    activeColor: Colors.green,
                    toggleable: true,
//activeColor: Colors.green,
                    value: 4,
                    groupValue: groupvalue,
                    onChanged: (value) {
                      setState(() {
                        groupvalue = value;
                        rightopt =
                            quizQuestionController.option4Controller.text;

                        print(groupvalue);
                      });
                    }),
                value: quizQuestionController.option4Controller,
                bordercircular: 50,
                height: 6 * SizeConfig.heightMultiplier,
                width: 80 * SizeConfig.widthMultiplier,
                hinttext: "Enter Option",
                lines: 10,
              ),
              SizedBox(
                height: 05 * SizeConfig.heightMultiplier,
              ),
//
              NextButton(
                title: "Next",
                pressed: () {
                  _inputValidation();
                  // if ((rightopt == "") || (rightopt == null)) {
                  //   return Get.defaultDialog(
                  //       title: "Select Right Option",
                  //       content: Column(
                  //         children: [Text("Plase Select the right option")],
                  //       ),
                  //       actions: []);
                  // } else {
                  //   print("DAta Added");
                  // }

                  //Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _inputValidation() {
    if (_formKey.currentState.validate() &&
        (rightopt != "") &&
        (rightopt != null)) {
      quizQuestionController.addQueastion(
          quizQuestionController.questionController.text,
          quizQuestionController.option1Controller.text,
          quizQuestionController.option2Controller.text,
          quizQuestionController.option3Controller.text,
          quizQuestionController.option4Controller.text,
          rightopt,
          widget.categoryId);
      quizQuestionController.clearController();
      Get.back();
      print("Data added here ");

      // setState(() {
      //   groupvalue = -1;

      //   quizQuestionController .questionController.clear();
      //   quizQuestionController .option1Controller.clear();
      //   quizQuestionController .option2Controller.clear();
      //   quizQuestionController .option3Controller.clear();
      //   quizQuestionController .option4Controller.clear();

      //   // quizQuestionController .option.clear();
      // });
    } else if ((rightopt == "") || (rightopt == null)) {
      Get.defaultDialog(
          title: "Select Right Option",
          content: Column(
            children: [Text("Plase Select the right option")],
          ),
          actions: []);
    } else {
      print("Form is not validate");
    }
  }
}
