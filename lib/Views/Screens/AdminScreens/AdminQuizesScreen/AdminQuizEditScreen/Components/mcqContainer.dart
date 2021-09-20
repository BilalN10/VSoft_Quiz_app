import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizBankController.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class McqContainer extends StatefulWidget {
  McqContainer({
    this.checkModel,
    Key key,
    this.questionModel,
    this.index,
    this.valuefirst,
  }) : super(key: key);
  //final FlutterQuestionsModels ques;
  final QuizQuestionModel questionModel;
  final int index;
  final List<QuizQuestionModel> checkModel;
  bool valuefirst;

  @override
  _McqContainerState createState() => _McqContainerState();
}

class _McqContainerState extends State<McqContainer> {
  final userController = Get.put(UserController());
  final quizBankController = Get.put(QuizBankController());
  List<QuizQuestionModel> singleQuestionList = [];
  List<String> check = [];

  int selectedIndex = 0;

  // @override
  // void initState() {
  //   bool valuefirst = allValue;
  //   super.initState();
  // }

  bool chagebutton = true;
  bool allValue = false;

  final userCOntroller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return
        //widget.index == 0 ? Divider() :
        questionOPtion();
  }

  Widget questionOPtion() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 02 * SizeConfig.widthMultiplier,
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 3 * SizeConfig.heightMultiplier,
                  width: 10 * SizeConfig.widthMultiplier,
                  //color: Colors.yellow,
                  child: Checkbox(
                    checkColor: Colors.greenAccent,
                    activeColor: Colors.red,
                    value: widget.valuefirst,
                    onChanged: (bool value) {
                      setState(() {
                        widget.valuefirst = value;
                        print(widget.valuefirst);
                      });
                      if (widget.valuefirst == true) {
                        quizBankController
                            .quizBankQuestion(widget.questionModel);
                        userController.addQuestion(widget.questionModel);

                        print("Data added");
                      } else {
                        userController
                            .removeQuestion(widget.questionModel.question);
                        quizBankController
                            .removeQuizBankQuestion(widget.questionModel.id);
                        // print(widget.index);
                        //print("DAta remove");
                      }
                    },
                  ),
                ),
              ],
            ),
            // addDeleteButton(),
            Text(
              "${widget.index + 1}) ${widget.questionModel.question}  ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "a) ${widget.questionModel.option_1}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "b) ${widget.questionModel.option_2}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "c) ${widget.questionModel.option_3}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "d) ${widget.questionModel.option_4}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  "RightOption:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 4 * SizeConfig.widthMultiplier,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 5 * SizeConfig.heightMultiplier,
                  width: 60 * SizeConfig.widthMultiplier,
                  //   color: Colors.black,
                  child: Text(
                    widget.questionModel.rightOptoin,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      //decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 1 * SizeConfig.heightMultiplier,
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget addDeleteButton() {
    return SizedBox(
      height: 2 * SizeConfig.heightMultiplier,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          chagebutton
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      print("DAta added hahaha");
                      chagebutton = !chagebutton;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 5 * SizeConfig.imageSizeMultiplier,
                    color: Colors.white,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      chagebutton = !chagebutton;
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    size: 5 * SizeConfig.imageSizeMultiplier,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}
