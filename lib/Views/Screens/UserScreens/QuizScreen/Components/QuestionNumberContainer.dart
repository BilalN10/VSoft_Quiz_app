import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class QuestionNumberContainer extends StatelessWidget {
  const QuestionNumberContainer({
    Key key,
    @required this.currentindex,
    this.totalQuestion,
  }) : super(key: key);

  final int currentindex;
  final totalQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 06 * SizeConfig.heightMultiplier,
      width: 14 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          "${currentindex.toString()}/$totalQuestion",
          //"${currentindex + 1} {questions.length}",
          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
    );
  }
}
