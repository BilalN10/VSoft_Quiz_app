import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Bindings/root.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Views/Screens/AdminUserSelectionPage/adminUserSelectionPage.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizFinishedScreen/quizFinished.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizScreen/Components/QuizQuestionContainer.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizScreen/quizScreen.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserHistory/userHistory.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Views/constants.dart';
import 'package:quizapp/check.dart';
import 'package:quizapp/dynamicLinks/homePage.dart';

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String chcekDeepLink = "null";
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
//  bool isQUizAttempt = false;

  final UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userQuestionController.isQuizAttempt = false.obs;
    userQuestionController.isQuizStart = true.obs;
    print("init call");

    initDynamicLinks();
    // userController.getuserHistory(userController.user.uid);
  }

  //Url checkUri = https://learndy.page.link/helloworld?d=1 ;
  int adminIDindex;

  String getlink;
  final box = GetStorage();
  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink;
    deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        chcekDeepLink = "deepLink not null";
      });
      //  print("Deep Link is admin user $userQuestionControllerdeepLink");
      print("Deep Link isis userHome $deepLink");
      userQuestionController.quizIdFromUrl =
          deepLink.toString().split("?").last.obs;
      adminIDindex = deepLink.toString().split("?").length - 1;
      userQuestionController.adminIdFromUrl =
          deepLink.toString().split("?")[adminIDindex - 1].obs;
      userQuestionController.isQuizAttempt = false.obs;
      // userQuestionController.getUserId(
      //     deepLink.toString().split("?")[adminIDindex - 1],
      //     deepLink.toString().split("?").last);
      print(
          "Quiz id from getInitiallink ${userQuestionController.quizIdFromUrl}");
      print(
          "User ID fro url getInitiallink ${userQuestionController.adminIdFromUrl} ");
      firebaseFirestore
          .collection('Admin')
          .doc(userQuestionController.adminIdFromUrl.value)
          .collection("MYQuiz")
          .doc(userQuestionController.quizIdFromUrl.value)
          .collection("Student")
          .doc(userController.user.uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          print("user already attempt this quiz ${value.id}");
          setState(() {
            userQuestionController.isQuizAttempt = true.obs;
          });
          // userQuestionController.isQuizAttempt = true.obs;
          print(userQuestionController.isQuizAttempt);
        }
      });
      // userQuestionController.attemtedQuiz(
      //     userController.user.uid,
      //     userQuestionController.adminIdFromUrl.value,
      //     userQuestionController.quizIdFromUrl.value);

      // userQuestionController.quizIdFromUrl =
      //     deepLink.toString().split("?").last.obs;
      // adminIDindex = deepLink.toString().split("?").length - 1;
      // userQuestionController.adminIdFromUrl =
      //     deepLink.toString().split("?")[adminIDindex - 1].obs;

      // userQuestionController.getUserId();
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      deepLink = dynamicLink?.link;
      print("Link is USERsCREEN $deepLink");

      //userQuestionController.adminID = deepLink.toString().obs;

      if (deepLink != null) {
        box.write("isQuiz", true);
        setState(() {
          getlink = deepLink.toString();
        });
        //box.write("isQuiz", true);
        userQuestionController.quizIdFromUrl =
            deepLink.toString().split("?").last.obs;
        adminIDindex = deepLink.toString().split("?").length - 1;
        userQuestionController.adminIdFromUrl =
            deepLink.toString().split("?")[adminIDindex - 1].obs;
        print(
            "Quiz id is from onClick ${userQuestionController.quizIdFromUrl}");
        userQuestionController.isQuizAttempt = false.obs;
        print(userQuestionController.isQuizAttempt);

        print(
            "User ID fro url  from onClick ${userQuestionController.adminIdFromUrl} ");
        // userQuestionController.attemtedQuiz(
        //     userController.user.uid,
        //     userQuestionController.adminIdFromUrl.value,
        //     userQuestionController.quizIdFromUrl.value);
        firebaseFirestore
            .collection('Admin')
            .doc(userQuestionController.adminIdFromUrl.value)
            .collection("MYQuiz")
            .doc(userQuestionController.quizIdFromUrl.value)
            .collection("Student")
            .doc(userController.user.uid)
            .get()
            .then((value) {
          if (value.data() != null) {
            setState(() {
              userQuestionController.isQuizAttempt = true.obs;
            });
            print("user already attempt this quiz ${value.id}");
            print("on link click quiz ${userQuestionController.isQuizAttempt}");
          }
        });

        // userQuestionController.quizIdFromUrl =
        //     deepLink.toString().split("?").last.obs;
        // adminIDindex = deepLink.toString().split("?").length - 1;
        // userQuestionController.adminIdFromUrl =
        //     deepLink.toString().split("?")[adminIDindex - 1].obs;

        // userQuestionController.getUserId();

      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

  // void initDynamicLinks() async {
  //   PendingDynamicLinkData data =
  //       await FirebaseDynamicLinks.instance.getInitialLink();
  //   Uri deepLink;

  //   //data = await FirebaseDynamicLinks.instance.getInitialLink();
  //   print("DAta is $data");

  //   deepLink = data?.link;
  //   print(deepLink);

  //   if (deepLink != null) {
  //     setState(() {
  //       getlink = deepLink.toString();
  //     });

  //     print("Deep Link isis userHome $deepLink");
  //     userQuestionController.quizIdFromUrl =
  //         deepLink.toString().split("?").last.obs;
  //     adminIDindex = deepLink.toString().split("?").length - 1;
  //     userQuestionController.adminIdFromUrl =
  //         deepLink.toString().split("?")[adminIDindex - 1].obs;
  //     // userQuestionController.getUserId(
  //     //     deepLink.toString().split("?")[adminIDindex - 1],
  //     //     deepLink.toString().split("?").last);
  //     print(
  //         "Quiz id from getInitiallink ${userQuestionController.quizIdFromUrl}");
  //     print(
  //         "User ID fro url getInitiallink ${userQuestionController.adminIdFromUrl} ");
  //     userQuestionController.attemtedQuiz(
  //         userController.user.uid,
  //         userQuestionController.adminIdFromUrl.value,
  //         userQuestionController.quizIdFromUrl.value);
  //     //   // DocumentReference docRef = firebaseFirestore
  //     //   //     .collection("Admin")
  //     //   //     .doc(userQuestionController.adminIdFromUrl.value)
  //     //   //     .collection("MYQuiz")
  //     //   //     .doc(userQuestionController.quizIdFromUrl.value)
  //     //   //     .collection("Student")
  //     //   //     .doc(userController.user.uid)
  //     //   //     .collection("Attempted Quiz")
  //     //   //     .doc(userQuestionController.quizIdFromUrl.value);
  //     //   // docRef.get().then((dataSnapShot) {
  //     //   //   print("Enter in snapshot");
  //     //   //   if (dataSnapShot.exists) {
  //     //   //     for (int i = 0; i < userQuestionController.questionList.length; i++) {
  //     //   //       print("Enter in loop");
  //     //   //       firebaseFirestore
  //     //   //           .collection("Admin")
  //     //   //           .doc(userQuestionController.adminIdFromUrl.value)
  //     //   //           .collection("MYQuiz")
  //     //   //           .doc(userQuestionController.quizIdFromUrl.value)
  //     //   //           .collection("Student")
  //     //   //           .doc(userController.user.uid)
  //     //   //           .collection("Attempted Quiz")
  //     //   //           .doc(userQuestionController.quizIdFromUrl.value)
  //     //   //           .collection("Question")
  //     //   //           .doc(userQuestionController.questionList[i].id)
  //     //   //           .update({"userSelection": ""});
  //     //   //     }
  //     //   //   } else {
  //     //   //     print("SnapSgot not found ");
  //     //   //   }
  //     //   });
  //     } else {
  //       print("dynamics link again call");
  //       //initDynamicLinks();
  //     }

  //     FirebaseDynamicLinks.instance.onLink(
  //         onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //       deepLink = dynamicLink?.link;

  //       //print("Deep Link userHome $deepLink");

  //       if (deepLink != null) {
  //         box.write("isQuiz", true);
  //         setState(() {
  //           getlink = deepLink.toString();
  //         });
  //         //box.write("isQuiz", true);
  //         userQuestionController.quizIdFromUrl =
  //             deepLink.toString().split("?").last.obs;
  //         adminIDindex = deepLink.toString().split("?").length - 1;
  //         userQuestionController.adminIdFromUrl =
  //             deepLink.toString().split("?")[adminIDindex - 1].obs;
  //         print(
  //             "Quiz id is from onClick ${userQuestionController.quizIdFromUrl}");
  //         print(
  //             "User ID fro url  from onClick ${userQuestionController.adminIdFromUrl} ");
  //         userQuestionController.attemtedQuiz(
  //             userController.user.uid,
  //             userQuestionController.adminIdFromUrl.value,
  //             userQuestionController.quizIdFromUrl.value);
  //         // userQuestionController.getUserId(
  //         //     userQuestionController.adminIdFromUrl.value,
  //         //     userQuestionController.quizIdFromUrl.value);
  //         // DocumentReference docRef = firebaseFirestore
  //         //     .collection("Admin")
  //         //     .doc(userQuestionController.adminIdFromUrl.value)
  //         //     .collection("MYQuiz")
  //         //     .doc(userQuestionController.quizIdFromUrl.value)
  //         //     .collection("Student")
  //         //     .doc(userController.user.uid)
  //         //     .collection("Attempted Quiz")
  //         //     .doc(userQuestionController.quizIdFromUrl.value);
  //         // docRef.get().then((dataSnapShot) {
  //         //   print("Enter in snapshot");
  //         //   if (dataSnapShot.exists) {
  //         //     for (int i = 0;
  //         //         i < userQuestionController.questionList.length;
  //         //         i++) {
  //         //       firebaseFirestore
  //         //           .collection("Admin")
  //         //           .doc(userQuestionController.adminIdFromUrl.value)
  //         //           .collection("MYQuiz")
  //         //           .doc(userQuestionController.quizIdFromUrl.value)
  //         //           .collection("Student")
  //         //           .doc(userController.user.uid)
  //         //           .collection("Attempted Quiz")
  //         //           .doc(userQuestionController.quizIdFromUrl.value)
  //         //           .collection("Question")
  //         //           .doc(userQuestionController.questionList[i].id)
  //         //           .update({"userSelection": ""}).then((value) {
  //         //         print("Update User Selection");
  //         //       });
  //         //     }
  //         //   }
  //         // });
  //       }
  //     }, onError: (OnLinkErrorException e) async {
  //       print('onLinkError');
  //       print(e.message);
  //     });
  //   }

  @override
  Widget build(BuildContext context) {
    //initDynamicLinks();

    return Scaffold(
      body: CommonBackground(
        childd: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 05 * SizeConfig.widthMultiplier),
          child:
              // ? Center(
              //     child: Text(
              //       "Quiz not assigned yet",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 3 * SizeConfig.textMultiplier,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   )
              // :
              Column(
            children: [
              SizedBox(
                height: 05 * SizeConfig.heightMultiplier,
              ),
              Image.asset(
                "assets/Images/clock.png",
                height: 15 * SizeConfig.heightMultiplier,
              ),

              SizedBox(
                height: 07 * SizeConfig.heightMultiplier,
              ),
              CommonFlateButton(
                  height: 7.5 * SizeConfig.heightMultiplier,
                  width: 50 * SizeConfig.widthMultiplier,
                  title: "Quiz history",
                  pressed: () {
                    Get.to(Userhistory(
                      userId: userController.user.uid,
                      //quizId: userQuestionController.quizIdFromUrl.value,
                    ));
                  }),
              // RaisedButton(onPressed: () {

              // }),

              SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
              ),
              Text("Are You Ready?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 2.5 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
              ),

              GetX<UserQuestionController>(
                init: Get.put<UserQuestionController>(UserQuestionController()),
                builder: (UserQuestionController userQuestionController) {
                  return userQuestionController.isQuizStart.value
                      ? CommonFlateButton(
                          height: 7.5 * SizeConfig.heightMultiplier,
                          width: 50 * SizeConfig.widthMultiplier,
                          title: "Start Quiz Now!",
                          pressed: () {
                            print(
                                "check quiz in condition ${userQuestionController.isQuizAttempt}");
                            // print(userQuestionController.isQuizAttempt);
                            // if (userQuestionController.listForAttemted !=
                            //     null) {
                            //   for (int i = 0;
                            //       i <
                            //           userQuestionController
                            //               .listForAttemted.length;
                            //       i++) {
                            //     if (userController.user.uid ==
                            //         userQuestionController
                            //             .listForAttemted[i].id) {
                            //       print(
                            //           "Qiuiz is Attemted id is ${userQuestionController.quizIdFromUrl.value}");
                            //       Get.defaultDialog(
                            //           title: "Quiz Alreay Attempted",
                            //           middleText:
                            //               "You already attempt this quiz",
                            //           middleTextStyle:
                            //               TextStyle(color: primarycolor),
                            //           actions: [
                            //             CommonFlateButton(
                            //               height:
                            //                   5 * SizeConfig.heightMultiplier,
                            //               width:
                            //                   10 * SizeConfig.widthMultiplier,
                            //               title: "Ok",
                            //               pressed: () {
                            //                 Get.back();
                            //               },
                            //             )
                            //           ]);
                            //     }
                            //   }
                            // } else
                            if (box.read("isQuiz") == false ||
                                userController.user.uid == null ||
                                userQuestionController.adminIdFromUrl == null ||
                                userQuestionController.quizIdFromUrl == null ||
                                userQuestionController.isQuizAttempt.value) {
                              if (userQuestionController.isQuizAttempt.value) {
                                Get.defaultDialog(
                                    title: "Quiz already attempted",
                                    middleText:
                                        "You have already attempted this quiz",
                                    middleTextStyle:
                                        TextStyle(color: primarycolor),
                                    actions: [
                                      CommonFlateButton(
                                        height: 5 * SizeConfig.heightMultiplier,
                                        width: 10 * SizeConfig.widthMultiplier,
                                        title: "Ok",
                                        pressed: () {
                                          Get.back();
                                        },
                                      )
                                    ]);
                              } else {
                                Get.defaultDialog(
                                    title: "Quiz not Found",
                                    middleText: "No Quiz Assign yet",
                                    middleTextStyle:
                                        TextStyle(color: primarycolor),
                                    actions: [
                                      CommonFlateButton(
                                        height: 5 * SizeConfig.heightMultiplier,
                                        width: 10 * SizeConfig.widthMultiplier,
                                        title: "Ok",
                                        pressed: () {
                                          Get.back();
                                        },
                                      )
                                    ]);
                              }
                            } else {
                              print("go to quiz Screen");

                              userQuestionController.isQuizStart.value =
                                  !userQuestionController.isQuizStart.value;
                              userQuestionController.addUserInformationToAdmin(
                                  userController.user.uid,
                                  userQuestionController.adminIdFromUrl.value,
                                  userQuestionController.quizIdFromUrl.value);
                            }
                          },
                        )
                      : CircularProgressIndicator();
                },
              ),
              // box.read("isQuiz")
              //     ? Text(
              //         "quiz is true",
              //         style: TextStyle(color: Colors.white),
              //       )
              //     : Text(
              //         "quiz is False",
              //         style: TextStyle(color: Colors.white),
              //       ),
              // userQuestionController.adminIdFromUrl != null
              //     ? Text(
              //         userQuestionController.adminIdFromUrl.value,
              //         style: TextStyle(color: Colors.white),
              //       )
              //     : Text("admin is null"),
              // userQuestionController.quizIdFromUrl != null
              //     ? Text(userQuestionController.quizIdFromUrl.value)
              //     : Text("Quiz id null"),

              // Text(
              //   userController.user.uid,
              //   style: TextStyle(color: Colors.white),
              // ),
              // Text(userQuestionController.adminIdFromUrl.value),
              // Text(userQuestionController.quizIdFromUrl.value),

              // GetX<UserQuestionController>(
              //     init:
              //         Get.put<UserQuestionController>(UserQuestionController()),
              //     builder: (UserQuestionController userQuestionController) {
              //       return userQuestionController.deepLink != null
              //           ? Text(
              //               userQuestionController.deepLink.toString(),
              //               style: TextStyle(color: Colors.white),
              //             )
              //           : Text(
              //               "Link is null",
              //               style: TextStyle(color: Colors.white),
              //             );
              //     }),
              // CommonFlateButton(
              //     height: 7.5 * SizeConfig.heightMultiplier,
              //     width: 50 * SizeConfig.widthMultiplier,
              //     title: "Start Quiz Now!",
              //     pressed: () async {
              //       userQuestionController
              //           .addUserInformationToAdmin(userController.user.uid);

              //     }),
              // Text(chcekDeepLink),
              // GetBuilder<UserQuestionController>(
              //   init: Get.put<UserQuestionController>(UserQuestionController()),
              //   builder: (UserQuestionController userQuestionController) {
              //     return userQuestionController.isQuizAttempt.value
              //         ? Text("Quiz already attempted")
              //         : Text(
              //             "quiz not attempted",
              //             style: TextStyle(fontSize: 20, color: Colors.black),
              //           );
              //     // QuizQuestionContainer(
              //     //   i: 1,
              //     //   question: userQuestionController.questionList[1].question,
              //     // );
              //   },
              // ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    firebaseAuth.signOut();
                    box.write("isStudent", false);
                    //userController.student = null;

                    //userid.value = "";
                    Get.offAll(() => AdminUserSelectionPage());
                  },
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 01 * SizeConfig.heightMultiplier,
                      decoration: TextDecoration.underline,
                    ),
                  )),
              SizedBox(
                height: 03 * SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
