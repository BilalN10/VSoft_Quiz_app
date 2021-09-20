import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Models/quizCategoryModel.dart';

class QuizCategoryController extends GetxController {
  Rx<List<QuizCategoryModel>> categoryList = Rx<List<QuizCategoryModel>>();
  List<QuizCategoryModel> get categorys => categoryList.value;
  @override
  void onInit() {
    //String uid = Get.find<AuthController>().user.uid;
    categoryList.bindStream(categoryStream()); //stream coming from firebase
    super.onInit();
  }

  Stream<List<QuizCategoryModel>> categoryStream() {
    return firebaseFirestore
        .collection("Quiz")
        .snapshots()
        .map((QuerySnapshot query) {
      List<QuizCategoryModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(QuizCategoryModel.fromDocumentSnapshot(element));
        print("coming data is SelectedFile  $retVal");
      });
      //print("coming data is quizCategoryModel  $retVal");
      return retVal;
    });
  }

  Future<void> addCategory(
    String categoryName,
  ) async {
    try {
      await firebaseFirestore.collection("Quiz").add({
        "Category": categoryName,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
