import 'package:cloud_firestore/cloud_firestore.dart';

class QuizCategoryModel {
  String id;
  String categoryName;
  QuizCategoryModel({this.categoryName});
  QuizCategoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    categoryName = doc.data()['Category'] ?? "";

    print(" category id is $id");
    print("category name is $categoryName");
  }
}
