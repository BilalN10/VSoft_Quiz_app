import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/getUserQuestoinModel.dart';
import 'package:quizapp/Models/resultModel.dart';

class ResultContoller extends GetxController {
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  UserController userController = Get.put(UserController());
  Rx<List<UserResultModel>> userResultList = Rx<List<UserResultModel>>();
  List<UserResultModel> get resultlist => userResultList.value;

  Rx<List<GetUserQuestionModel>> reslutCalculateList =
      Rx<List<GetUserQuestionModel>>();
  List<GetUserQuestionModel> get reslutCalculate => reslutCalculateList.value;
  RxInt result = 0.obs;
  void calulate() {
    for (int i = 0; i < reslutCalculate.length; i++) {
      if (reslutCalculate[i].userSelection == reslutCalculate[i].rightOptoin) {
        print(reslutCalculate[i].userSelection);
        result++;
        update();
      }
      print("Your Result is $result");
    }
  }

  // @override
  // void onInit() {
  //   print("Start");
  //   userResultList.bindStream(resultStream());
  //   super.onInit();
  // }

  void getBindingStream(String userId, String adminId, String quizid) {
    reslutCalculateList
        .bindStream(calculateResultStream(userId, adminId, quizid));
  }

  Stream<List<GetUserQuestionModel>> calculateResultStream(
      String userid, String adminId, String quizid) {
    print("admin id $adminId");
    print("qiuz is $quizid");
    print("studen id is $userid");
    print("Get Stream");
    //print("User ID ${userQuestionController.userID.value}");
    //print("Quiz ID ${userQuestionController.quizIDForUpdate.value}");
    return firebaseFirestore
        .collection("Admin")
        .doc(adminId)
        .collection("MYQuiz")
        .doc(quizid)
        .collection("Student")
        .doc(userid)
        .collection("Attempted Quiz")
        .doc(quizid)
        .collection("Question")
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs.length);

      List<GetUserQuestionModel> retVal = List();
      query.docs.forEach((element) {
        print("Enter in forEach ");
        retVal.add(GetUserQuestionModel.fromDocumentSnapshot(element));
        print("coming data from resultControlller is  ${retVal.length}");
      });

      //print("coming data is quizCategoryModel  $retVal");
      return retVal;
    });
  }

  // void getId(String uid) {
  //   userResultList.bindStream(resultStream(uid));
  // }
  getUserResult() {
    userResultList.bindStream(resultStream());
  }

  Stream<List<UserResultModel>> resultStream() {
    print("Get Stream");
    //  print("User ID $userid");
    print("Quiz ID ${userQuestionController.quizIDForUpdate.value}");
    return firebaseFirestore
        .collection("Admin")
        .doc(userController.user.uid)
        .collection("MYQuiz")
        .doc(userQuestionController.quizIDForUpdate.value)
        .collection("Student")
        .doc(userQuestionController.userID.value)
        .collection("Attempted Quiz")
        .doc(userQuestionController.quizIDForUpdate.value)
        .collection("Result")
        .orderBy("time", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs.length);

      List<UserResultModel> retVal = List();
      query.docs.forEach((element) {
        print("Enter in forEach ");
        retVal.add(UserResultModel.fromDocumentSnapshot(element));
        print("coming data from result is  $retVal");
      });
      //print("coming data is quizCategoryModel  $retVal");
      return retVal;
    });
  }
}
