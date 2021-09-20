import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/allQuizModel.dart';

class AllQuizController extends GetxController {
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());
  final UserController userController = Get.put(UserController());
  Rx<List<AllQuizModel>> allQuizList = Rx<List<AllQuizModel>>();
  List<AllQuizModel> get myQuizes => allQuizList.value;
  @override
  void onInit() {
    allQuizList.bindStream(getAllQuizStream());
    super.onInit();
  }

  Stream<List<AllQuizModel>> getAllQuizStream() {
    // print("my id is $uid");
    print("Enter in quiz Stream");
    return firebaseFirestore
        .collection('Admin')
        .doc(userController.user.uid)
        .collection("MYQuiz")
        .orderBy("time", descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      print("Enter in quiz add list");
      List<AllQuizModel> quizRetrive = [];
      snapshot.docs.forEach((element) {
        print("Element is $element");
        quizRetrive.add(AllQuizModel.docuemnt(element));
        print(quizRetrive.length);
      });
      return quizRetrive;
    });
  }
}
