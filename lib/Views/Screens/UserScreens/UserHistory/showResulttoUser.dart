import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';

class ShowResultToUser extends StatefulWidget {
  final String userId;
  final String quizId;
  ShowResultToUser({this.quizId, this.userId});

  @override
  _ShowResultToUserState createState() => _ShowResultToUserState();
}

class _ShowResultToUserState extends State<ShowResultToUser> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userController.getidForReslut(widget.userId, widget.quizId);
    // widget.userquizId.collection("Result").get().then((value) => {
    //       value.docs.forEach((element) {
    //         element.id;
    //         print(element.id);
    //         userController.obtainMarks.value =
    //             element.data()["obtainMarks"] ?? 0;
    //         userController.totalMarks.value = element.data()["totalMarks"] ?? 0;
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
          childd: Column(
        children: [
          // Text(
          //   widget.userquizId.id,
          //   style: TextStyle(color: Colors.white),
          // ),
          SizedBox(
            height: 5 * SizeConfig.heightMultiplier,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Result",
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
          GetX<UserController>(
              init: Get.find<UserController>(),
              builder: (UserController userController) {
                if (userController != null &&
                    userController.resultHistory != null) {
                  return Container(
                    height: 60 * SizeConfig.heightMultiplier,
                    child: ListView.builder(
                        itemCount: userController.resultHistory.length,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            height: 20 * SizeConfig.heightMultiplier,
                            width: 80 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Obtain Marks :",
                                      style: TextStyle(
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    ),
                                    SizedBox(
                                      height: 4 * SizeConfig.heightMultiplier,
                                    ),
                                    Text(
                                      "Total Marks    :",
                                      style: TextStyle(
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5 * SizeConfig.widthMultiplier,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      userController
                                          .resultHistory[index].obtainMarks
                                          .toString(),
                                      style: TextStyle(
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    ),
                                    SizedBox(
                                      height: 4 * SizeConfig.heightMultiplier,
                                    ),
                                    Text(
                                      userController
                                          .resultHistory[index].totalMarks
                                          .toString(),
                                      style: TextStyle(
                                          fontSize:
                                              3 * SizeConfig.textMultiplier),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return Text("Loading");
                }
              }),
        ],
      )

          //  Center(
          //     child: CircularProgressIndicator(),
          //   ),
          ),
    );
  }
}
