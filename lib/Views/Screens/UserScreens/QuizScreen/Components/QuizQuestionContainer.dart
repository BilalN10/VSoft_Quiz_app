import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class QuizQuestionContainer extends StatefulWidget {
  const QuizQuestionContainer({
    Key key,
    this.question,
    this.i,
  }) : super(key: key);
  final String question;
  final int i;
  @override
  _QuizQuestionContainerState createState() => _QuizQuestionContainerState();
}

class _QuizQuestionContainerState extends State<QuizQuestionContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 40 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 15)]),
        ),
        Column(
          children: [
            Image.asset(
              "assets/Images/QuizLogo.png",
              height: 35 * SizeConfig.imageSizeMultiplier,
            ),
            Center(
              child: Container(
                height: 15 * SizeConfig.heightMultiplier,
                width: 90 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.black45, blurRadius: 06)
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 05 * SizeConfig.widthMultiplier,
                    vertical: 02 * SizeConfig.heightMultiplier,
                  ),
                  child: Center(
                      child: Text(
                    widget.question,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 2 * SizeConfig.textMultiplier),
                  )),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
