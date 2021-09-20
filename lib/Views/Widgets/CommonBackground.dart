import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class CommonBackground extends StatelessWidget {
  const CommonBackground({
    Key key,
    this.childd,
  }) : super(key: key);
  final childd;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 94 * SizeConfig.heightMultiplier,
          width: 100 * SizeConfig.widthMultiplier,
          // color: Colors.red,
          child: Column(
            children: [
              Expanded(
                  child: Stack(children: [
                // Container(
                //   color: primarycolor,
                // ),

                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4 * SizeConfig.widthMultiplier,
                          vertical: 1 * SizeConfig.heightMultiplier),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 6 * SizeConfig.imageSizeMultiplier,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8 * SizeConfig.heightMultiplier,
                      width: 20 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                              image: AssetImage("assets/Images/QuizLogo.png"),
                              fit: BoxFit.cover)),
                      // child: Center(
                      //   child: Image.asset(
                      //     "assets/Images/QuizLogo.png",
                      //   ),
                      // ),
                    ),
                  ],
                )
              ])),
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: 100 * SizeConfig.widthMultiplier,
                      height: 80 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: secondarycolor,
                          boxShadow: [
                            BoxShadow(color: Colors.black45, blurRadius: 06)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: childd,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
