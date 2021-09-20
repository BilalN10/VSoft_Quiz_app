import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Models/getUserQuestoinModel.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Views/Screens/UserScreens/QuizScreen/quizScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/constants.dart';

class UserQuestionController extends GetxController {
  //Get.put(UserController());
  RxInt result = 0.obs;
  RxString userID = "".obs;
  RxBool isQuizAssign = false.obs;
  RxString quizID = "".obs;
  RxString quizIDForUpdate = "".obs;
  RxString adminID = "".obs;
  RxString adminIdFromUrl;
  RxString quizIdFromUrl;
  RxBool isQuizStart = true.obs;
  Rx<Uri> deepLink;
  RxBool isQuizAttempt = false.obs;

  //RxString adminLink = "".obs;

  TextEditingController quizNameController = TextEditingController();

  Rx<List<GetUserQuestionModel>> getQuestionList =
      Rx<List<GetUserQuestionModel>>();
  List<GetUserQuestionModel> get questionList => getQuestionList.value;

  // @override
  // void onInit() {
  //   //  userID = userController.userEmailController.text.obs;
  //   getQuestionList.bindStream(userQuestionStream());
  //   super.onInit();

  //   // calulate();
  //   //String uid = Get.find<UserController>(). .uid;
  //   //stream coming from firebase
  // }

  // void updateId(String value) {
  //   RxString userID = value.obs;
  //   update();
  //   // getUserId();
  //   print("user ID is $userID");
  // }

  void getUserId(String adminidUrl, String quizidUrl) {
    //print("IDDD is $uid");
    getQuestionList.bindStream(userQuestionStream(adminidUrl, quizidUrl));
  }

  Stream<List<GetUserQuestionModel>> userQuestionStream(
      String adminidUrl, String quizidUrl) {
    // print("user iDD is $userid");
    return firebaseFirestore
        .collection("Admin")
        .doc(adminidUrl)
        .collection("MYQuiz")
        .doc(quizidUrl)
        .collection("Question")
        .snapshots()
        .map((QuerySnapshot query) {
      List<GetUserQuestionModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(GetUserQuestionModel.fromDocumentSnapshot(element));
      });
      print("coming data from GetUserQuestionModel  ${retVal.length}");
      //print("user id is $userID.value");
      return retVal;
    });
  }

  void calulate() {
    for (int i = 0; i < questionList.length; i++) {
      if (questionList[i].userSelection == questionList[i].rightOptoin) {
        print(questionList[i].userSelection);
        result++;
        update();
      }
      print("Your Result is $result");
    }
  }

  Future<void> addQuestionToUser(
      List<QuizQuestionModel> list, String id) async {
    print("Enter in addQuestion");
    try {
      firebaseFirestore.collection('Admin').doc(id).collection("MYQuiz").add({
        "quizName": quizNameController.text,
        "time": DateTime.now()
      }).then((value) async {
        isQuizAssign.value = !isQuizAssign.value;
        print(isQuizAssign);
        quizID = value.id.obs;
        Get.defaultDialog(
            title: "Quiz Generated",
            middleText: "Quiz Generated Suceasfully",
            actions: [
              CommonFlateButton(
                height: 5 * SizeConfig.heightMultiplier,
                width: 10 * SizeConfig.widthMultiplier,
                pressed: () {
                  Get.back();
                },
                title: "OK",
              )
            ]);
        print("Document Created ID is${value.id}");
        for (var i in list) {
          await firebaseFirestore
              .collection("Admin")
              .doc(id)
              .collection("MYQuiz")
              .doc(value.id)
              .collection("Question")
              .add({
            "question": i.question,
            "option1": i.option_1,
            "option2": i.option_2,
            "option3": i.option_3,
            "option4": i.option_4,
            "rightOption": i.rightOptoin,
            "dateTime": DateTime.now(),
            "userSelection": "",
          });
        }
      }).then((value) {
        print("DAta added");
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void addUserInformationToAdmin(String userId, String adminId, String quizId) {
    print("Enter in add information");
    print("User id is $userId");
    print("adminId is $adminId");
    print("Quiz id is $quizId");
    print(userId);
    firebaseFirestore.collection("user").doc(userId).get();

    DocumentReference docRef = firebaseFirestore.collection('user').doc(userId);
    print(docRef);

    docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        firebaseFirestore
            .collection("Admin")
            .doc(adminIdFromUrl.value)
            .collection("MYQuiz")
            .doc(quizIdFromUrl.value)
            .collection("Student")
            .doc(userId)
            .set({
          "name": datasnapshot.data()["name"],
          "email": datasnapshot.data()["email"],
          "phoneNumber": datasnapshot.data()["phoneNumber"],
          "qualfication": datasnapshot.data()["qualfication"],
          "appliedFor": datasnapshot.data()["appliedFor"],
          "isQuizAssign": false,
          'dateCreated': Timestamp.now(),
        }).then((value) {
          isQuizStart.value = !isQuizStart.value;
          Get.to(QuizScreen(
            adminIdFromurl: adminId,
            quizIdFromUrl: quizId,
            studentid: userId,
          ));
          print("Data added");
        });

        // print(datasnapshot);
      } else {
        isQuizStart.value = !isQuizStart.value;
        Get.defaultDialog(
            title: "User not found",
            middleText: "Please create account as a user",
            middleTextStyle: TextStyle(color: primarycolor),
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
    });
  }

  Future deleteAll(
    String userId,
    List<QuizQuestionModel> questionsList,
  ) async {
    for (int i = 0; i < questionList.length; i++) {
      print("question length is ${questionList.length}");
      firebaseFirestore
          .collection("Admin")
          .doc(userId)
          .collection("MYQuiz")
          .doc(questionList[i].id)
          .delete()
          .then((value) {
        print("All Data Delete");
        firebaseFirestore
            .collection("user")
            .doc(userId)
            .update({"isQuizAssign": false}).then((value) {
          print("DAta Update");
        });
      });
      print(questionList[i].id);
    }
  }

  //   print("Delete");
  // }
  //   // await for (var data in firebaseFirestore
  //   //     .collection("user")
  //   //     .doc(userId)
  //   //     .collection("MYQuiz")
  //   //     .snapshots()) {
  //   //   for (var data1 in data.docs) {
  //   //     firebaseFirestore
  //   //         .collection("user")
  //   //         .doc(userId)
  //   //         .collection("MYQuiz")
  //   //         .doc(data1.id)
  //   //         .delete()
  //   //         .then((value) {
  //   //       print("delete");
  //   //       firebaseFirestore
  //   //           .collection("user")
  //   //           .doc(userId)
  //   //           .update({"isQuizAssign": false});
  //   //     });
  //   //   }
  //   }
  // }
  //
  void updateUpdateUserSelection({
    String userSelection,
    String questionId,
    String studentId,
    String adminId,
    String quizId,
  }) {
    print(
        "Enter in update function"); // print("quid ID is ${userQuestionController.quizID.value}");
    print("Question  ID is $questionId");
    firebaseFirestore
        .collection("Admin")
        .doc(adminId)
        .collection("MYQuiz")
        .doc(quizId)
        .collection("Student")
        .doc(studentId)
        .collection("Attempted Quiz")
        .doc(quizId)
        .collection("Question")
        .doc(questionId)
        .update({"userSelection": userSelection}).then((value) {
      print("Update");
      print(studentId);
    });
  }

  // void updateBeforeQuiz() {
  //   result = 0.obs;
  //   // print(userQuestionController.questionList.length);

  //   print("result is $result");
  //   print("Length is ${questionList.length}");
  //   for (int i = 0; i < questionList.length; i++) {
  //     firebaseFirestore
  //         .collection("user")
  //         .doc(userID.value)
  //         .collection("MYQuiz")
  //         .doc(quizIDForUpdate.value)
  //         .collection("Question")
  //         .doc(questionList[i].id)
  //         .update({
  //       "userSelection": "",
  //     }).then((value) {
  //       print("Update Data");
  //       print("User id us ${userID.value}");
  //       Get.to(QuizScreen());
  //     });
  //     print("User id us ${userID.value}");

  //     print("IDD is ${questionList[i].id}");
  //   }

  //   Get.to(QuizScreen());
  // }
}
