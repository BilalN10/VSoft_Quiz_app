import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';

class CheckQuiz extends StatelessWidget {
  const CheckQuiz({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        childd: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 05 * SizeConfig.heightMultiplier,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20 * SizeConfig.heightMultiplier,
              ),
              UserResults(
                title: "user1",
                numbers: "3/5",
              ),
              UserResults(
                title: "user2",
                numbers: "4/5",
              ),
              UserResults(
                title: "user3",
                numbers: "1/5",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserResults extends StatelessWidget {
  const UserResults({
    Key key,
    this.title,
    this.numbers,
  }) : super(key: key);
  final String title;
  final String numbers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: TextStyle(color: Colors.white)),
            SizedBox(
              width: 10 * SizeConfig.widthMultiplier,
            ),
            Container(
              height: 05 * SizeConfig.heightMultiplier,
              width: 40 * SizeConfig.widthMultiplier,
              decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(05),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 06,
                    )
                  ]),
              child: Center(
                child: Text(
                  "$numbers  Marks",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 02 * SizeConfig.heightMultiplier,
        ),
      ],
    );
  }
}
