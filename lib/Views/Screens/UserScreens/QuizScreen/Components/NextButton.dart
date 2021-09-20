import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import '../../../../constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
    this.pressed,
    this.title,
  }) : super(key: key);
  final pressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        height: 6.3 * SizeConfig.heightMultiplier,
        width: 40 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: primarycolor, borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
