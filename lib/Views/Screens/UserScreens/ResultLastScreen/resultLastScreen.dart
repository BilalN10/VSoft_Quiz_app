import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CommonBackground(
      childd: Column(
        children: [
          SizedBox(
            height: 05 * SizeConfig.heightMultiplier,
          ),
          Image.asset(
            "assets/Images/result.png",
            height: 15 * SizeConfig.heightMultiplier,
          ),
          SizedBox(
            height: 20 * SizeConfig.heightMultiplier,
          ),
          Text(
            "Your Result : ",
            style: TextStyle(
                color: Colors.white,
                fontSize: 4 * SizeConfig.heightMultiplier,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 05 * SizeConfig.heightMultiplier,
          ),
          Container(
            width: 40 * SizeConfig.widthMultiplier,
            height: 08 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
                color: primarycolor, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                "3/5",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 2.5 * SizeConfig.textMultiplier),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
