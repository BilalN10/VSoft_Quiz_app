import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';

class QuizBankController extends GetxController {
  Rx<List<QuizQuestionModel>> quizBankList = Rx<List<QuizQuestionModel>>();
  List<QuizQuestionModel> get quizBank => quizBankList.value;

  @override
  void onInit() {
    super.onInit();
    quizBankList.bindStream(quizBankStream());
  }

  Future<void> deleteAllFromQuizBank(List<QuizQuestionModel> quizList) async {
    for (int i = 0; i < quizList.length; i++) {
      firebaseFirestore
          .collection("QuizBank")
          .doc(quizList[i].id)
          .delete()
          .then((value) {
        print("ID is $quizList[i].id");
        print("Question deleted");
      });
    }
    // await for (var data
    //     in firebaseFirestore.collection("QuizBank").snapshots()) {
    //   for (var data1 in data.docs) {
    //     firebaseFirestore.collection("QuizBank").doc(data1.id).delete();
    //   }
    //   print("Delete you are calling me");
    // }
  }

  Stream<List<QuizQuestionModel>> quizBankStream() {
    return firebaseFirestore
        .collection("QuizBank")
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<QuizQuestionModel> retriveData = [];
      snapshot.docs.forEach((element) {
        retriveData.add(QuizQuestionModel.fromDocumentSnapshot(element));
      });
      return retriveData;
    });
  }

  Future<void> quizBankQuestion(QuizQuestionModel quizQuestionModel) async {
    try {
      print("i am here");
      await firebaseFirestore
          .collection("QuizBank")
          .doc(quizQuestionModel.id)
          .set({
        "question": quizQuestionModel.question,
        "option1": quizQuestionModel.option_1,
        "option2": quizQuestionModel.option_2,
        "option3": quizQuestionModel.option_3,
        "option4": quizQuestionModel.option_4,
        "rightOption": quizQuestionModel.rightOptoin,
      }).then((value) {
        print("Question added");
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> removeQuizBankQuestion(String id) async {
    try {
      await firebaseFirestore
          .collection("QuizBank")
          .doc(id)
          .delete()
          .then((value) {
        print("ID is $id");
        print("Question deleted");
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addQuizBankQuestionToUser(
    List<QuizQuestionModel> list,
    String uid,
  ) async {
    try {
      var result = list.map((item) {
        return {"option1": item.option_1, "option3": item.option_3};
      }).toList();
      print(result);
      for (int i = 0; i < list.length; i++) {
        print("question is ${list[i].question}");
        await firebaseFirestore
            .collection("user")
            .doc(uid)
            .collection("MYQuiz")
            .add({
          "question": list[i].question,
          "option1": list[i].option_1,
          "option2": list[i].option_2,
          "option3": list[i].option_3,
          "option4": list[i].option_4,
          "rightOption": list[i].rightOptoin,
          "userSelection": ""
        });
      }

      print("DAta added Id is $uid");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
