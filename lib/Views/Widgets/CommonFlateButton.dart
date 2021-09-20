import 'package:flutter/material.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:animated_button/animated_button.dart';

class CommonFlateButton extends StatelessWidget {
  const CommonFlateButton({
    Key key,
    this.title,
    this.pressed,
    this.width,
    this.height,
  }) : super(key: key);
  final String title;
  final pressed;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedButton(
          color: primarycolor,
          height: height,
          width: width,
          onPressed: pressed,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 2 * SizeConfig.textMultiplier),
          )),
    );
  }
}
