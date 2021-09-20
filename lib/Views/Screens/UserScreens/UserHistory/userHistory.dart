import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Models/userHistoryModel.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserHistory/showResulttoUser.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';

class Userhistory extends StatefulWidget {
  final String userId;
  //final String quizId;
  //final List<UserHistoryModel> userHistoryLidt;

  Userhistory({
    this.userId,
    //this.userHistoryLidt
  });

  @override
  _UserhistoryState createState() => _UserhistoryState();
}

class _UserhistoryState extends State<Userhistory> {
  @override
  void initState() {
    super.initState();
    userController.getuserHistory(widget.userId);
  }

  final UserController userController = Get.put(UserController());
//  String quizName = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonBackground(
          childd: Column(
            children: [
              SizedBox(
                height: 3 * SizeConfig.heightMultiplier,
              ),
              // Text(widget.userId),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Attemted Quizes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 3 * SizeConfig.textMultiplier,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              SizedBox(
                height: 3 * SizeConfig.heightMultiplier,
              ),
              Container(
                height: 68 * SizeConfig.heightMultiplier,
                //color: Colors.white,
                child: GetX<UserController>(
                    init: Get.find<UserController>(),
                    builder: (UserController userController) {
                      if (userController != null &&
                          userController.userHistory != null) {
                        return ListView.builder(
                            itemCount: userController.userHistory.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => ShowResultToUser(
                                        quizId: userController
                                            .userHistory[index].id,
                                        userId: widget.userId,

                                        // userhistory:
                                        //     userController.userHistory[index].id,
                                      ));
                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    alignment: Alignment.centerLeft,
                                    height: 10 * SizeConfig.heightMultiplier,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${index + 1}) ${userController.userHistory[index].quizName}',
                                          style: TextStyle(
                                              fontSize:
                                                  3 * SizeConfig.textMultiplier,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              );
                            });
                      } else {
                        return Text("Loading");
                      }
                    }),

                // GetX<UserController>(
                //   init: Get.find<UserController>(),
                //   builder: (UserController userController) {
                //     if (userController != null &&
                //         userController.userHistory != null) {
                //       return ListView.builder(
                //           itemCount: userController.userHistory.length,
                //           itemBuilder: (context, index) {
                //             return GestureDetector(
                //               onTap: () {
                //                 Get.to(() => ShowResultToUser(
                //                       userhistory: userController
                //                           .userHistory[index].history,
                //                     ));
                //               },
                //               child: Container(
                //                   margin: EdgeInsets.all(10),
                //                   alignment: Alignment.centerLeft,
                //                   height: 10 * SizeConfig.heightMultiplier,
                //                   decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       borderRadius: BorderRadius.circular(10)),
                //                   child: Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: GetBuilder<UserController>(
                //                         init: Get.find<UserController>(),
                //                         builder:
                //                             (UserController userController) {
                //                           return Text(
                //                             ' ${index + 1})  ${userController.userHistory[index].quizName}',
                //                             style: TextStyle(
                //                                 fontSize: 3 *
                //                                     SizeConfig.textMultiplier,
                //                                 fontWeight: FontWeight.bold),
                //                           );
                //                         }),
                //                   )),
                //             );
                //           });
                //     } else {
                //       return Text(
                //         "loading...",
                //         style: TextStyle(fontSize: 20, color: Colors.black),
                //       );
                //     }
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkText(String name) {
    return Text(name ?? "");
  }
}
