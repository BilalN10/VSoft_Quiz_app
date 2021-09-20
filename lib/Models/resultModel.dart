import 'package:cloud_firestore/cloud_firestore.dart';

class UserResultModel {
  String id;
  int obtainMarks;
  int totalMarks;
  UserResultModel({this.obtainMarks, this.totalMarks});
  UserResultModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    obtainMarks = doc.data()['obtainMarks'] ?? 0;
    totalMarks = doc.data()["totalMarks"] ?? 0;

    print(" Result id is $id");
    // print("category name is $categoryName");
  }
}
