import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/resultController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';

class Results extends StatelessWidget {
  final String userName;
  Results({this.userName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: primarycolor,
        //   centerTitle: true,
        //   title: Text("User Result"),
        // ),
        body: CommonBackground(
          childd: Column(
            children: [
              SizedBox(
                height: 3 * SizeConfig.heightMultiplier,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User Result",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 5 * SizeConfig.heightMultiplier,
              ),
              GetX<ResultContoller>(
                init: Get.put(ResultContoller()),
                builder: (ResultContoller resultContoller) {
                  if (resultContoller != null &&
                      resultContoller.resultlist != null) {
                    return Container(
                      height: 68 * SizeConfig.heightMultiplier,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: resultContoller.resultlist.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            height: 25 * SizeConfig.heightMultiplier,
                            width: 20 * SizeConfig.widthMultiplier,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black12,
                                      offset: Offset(2, 2))
                                ]),
                            //color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Name ",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Obtain Marks",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Total Marks",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        ":",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ":",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ":",
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      //Container(),
                                      //  CalendarDatePicker(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate, onDateChanged: onDateChanged),
                                      Text(
                                        userName,
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        resultContoller
                                            .resultlist[index].obtainMarks
                                            .toString(),
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        resultContoller
                                            .resultlist[index].totalMarks
                                            .toString(),
                                        style: TextStyle(
                                            fontSize:
                                                3 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          );
                          // in
                        },
                      ),
                    );
                  } else {
                    return Text(
                      "loading...",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
