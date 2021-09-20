import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';

class QuizQuestionController extends GetxController {
  final UserController userController = Get.put(UserController());
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());

  Rx<List<QuizQuestionModel>> quizList = Rx<List<QuizQuestionModel>>();
  List<QuizQuestionModel> get quiz => quizList.value;
  int right = 0;
  int singleQuizLength;
  RxString quizCategoryID = "".obs;

  Rx<List<int>> _rightOtionList = Rx<List<int>>([]);
  List<int> get rightOptions => _rightOtionList.value;
  void updateRightAnswerList(int rightOption, int index) {
    if (rightOption == 1) {
      rightOptions.insert(index, 1);
    } else {
      rightOptions.insert(index, 0);
    }
    print("inerted $rightOptions at $index");
    update();
    // calculate();
  }

  void calculate() {
    for (int i = 0; i < rightOptions.length; i++) {
      if (rightOptions[i] == 1) {
        print("Right option list is ${rightOptions[i]}");
        right++;
      }
      print("Result is $right");
    }
  }

  // @override
  // void onInit() {
  //   //String uid = Get.find<AuthController>().user.uid;
  //    //stream coming from firebase
  // }
  void getCategoryUId(String uid) {
    quizList.bindStream(quizStream(uid));
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  void controllerClear() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
  }

  Future<void> addQueastion(
    String question,
    String op1,
    String op2,
    String op3,
    String op4,
    String rightOpt,
    String uid,
  ) async {
    try {
      await firebaseFirestore
          .collection("Quiz")
          .doc(uid)
          .collection("Question")
          .add({
        "rightOption": rightOpt,
        'option1': op1,
        'option2': op2,
        'option3': op3,
        'option4': op4,
        "question": question,
        "dateTime": DateTime.now()
      });
      print("DAta added Id is $uid");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<QuizQuestionModel>> quizStream(String uid) {
    print("Enter in dklfsnklds");
    return firebaseFirestore
        .collection("Quiz")
        .doc(uid)
        .collection("Question")
        .orderBy("dateTime", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuizQuestionModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(QuizQuestionModel.fromDocumentSnapshot(element));
      });
      print("coming data from quiz question is  $retVal");
      return retVal;
    });
  }

  void removeQestion(
    String quizId,
    String questionId,
  ) {
    firebaseFirestore
        .collection("Quiz")
        .doc(quizId)
        .collection("Question")
        .doc(questionId)
        .delete()
        .then((value) {
      print("Delete Data");
    });
  }

  void updateQestion(
      String quizId,
      String questionId,
      String question,
      String rightOption,
      String option1,
      String option2,
      String option3,
      String option4) {
    print("quid ID is $quizId");
    print("Question  ID is $questionId");
    firebaseFirestore
        .collection("Quiz")
        .doc(quizId)
        .collection("Question")
        .doc(questionId)
        .update({
      "rightOption": rightOption,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      "question": question,
    }).then((value) {
      print("Update Data");
    });
  }

  void clearController() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
  }
}
