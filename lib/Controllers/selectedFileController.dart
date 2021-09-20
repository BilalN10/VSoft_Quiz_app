import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';

class SelectedFileController extends GetxController {
  Rx<List<QuizQuestionModel>> categoryList = Rx<List<QuizQuestionModel>>();
  List<QuizQuestionModel> get selectedFile => categoryList.value;
  @override
  void onInit() {
    categoryList.bindStream(categoryStream());
    super.onInit();
  }

  Stream<List<QuizQuestionModel>> categoryStream() {
    return firebaseFirestore
        .collection("SelectedFile")
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuizQuestionModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(QuizQuestionModel.fromDocumentSnapshot(element));
        print("coming data is SelectedFile  $retVal");
      });
      //print("coming data is quizCategoryModel  $retVal");
      return retVal;
    });
  }

  Rx<List<dynamic>> _selectedFileQuestionList = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileQuestionList => _selectedFileQuestionList.value;
  Rx<List<dynamic>> _selectedFileOption_1 = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileOption_1 => _selectedFileOption_1.value;
  Rx<List<dynamic>> _selectedFileOption_2 = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileOption_2 => _selectedFileOption_2.value;
  Rx<List<dynamic>> _selectedFileOption_3 = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileOption_3 => _selectedFileOption_3.value;
  Rx<List<dynamic>> _selectedFileOption_4 = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileOption_4 => _selectedFileOption_4.value;
  Rx<List<dynamic>> _selectedFileRightOption = Rx<List<dynamic>>([]);
  List<dynamic> get selectedFileRightOption => _selectedFileRightOption.value;
  void clearAllLists() {
    selectedFileOption_1.length = 0;
    selectedFileOption_2.length = 0;
    selectedFileOption_3.length = 0;
    selectedFileOption_4.length = 0;
    selectedFileQuestionList.length = 0;
    selectedFileRightOption.length = 0;
    print("All lists are clear");
  }

  void updateRightAnswerList(
      var question, option1, option2, option3, option4, rightOption) {
    selectedFileQuestionList.add(question);
    selectedFileOption_1.add(option1);
    selectedFileOption_2.add(option2);
    selectedFileOption_3.add(option3);
    selectedFileOption_4.add(option4);
    selectedFileRightOption.add(rightOption);

    update();
    // for (int i = 1; i <= 5; i++) {
    //   print("Question list upadated ${selectedFileQuestionList[i].value}");
    // }
    // calculate();
  }

  Future<void> addQuestionToUser(
    String fileName,
    List<dynamic> questions,
    List<dynamic> option_1,
    List<dynamic> option_2,
    List<dynamic> option_3,
    List<dynamic> option_4,
    List<dynamic> rightOption,

    // QuizQuestionModel quizQuestionModel,
  ) async {
    try {
      for (int i = 1; i < questions.length; i++) {
        // print("question is ${list[i].question}");
        await firebaseFirestore.collection("SelectedFile").add({
          "question": questions[i],
          "option1": option_1[i],
          "option2": option_2[i],
          "option3": option_3[i],
          "option4": option_4[i],
          "rightOption": rightOption[i],
        });
        print("DAta Added");
      }
      //  print("DAta added Id is $uid");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void removeSelectedFileQestion(
    String quizId,
  ) {
    firebaseFirestore
        .collection("SelectedFile")
        .doc(quizId)
        .delete()
        .then((value) {
      print("Delete Data");
    });
  }
}
