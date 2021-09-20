import 'package:cloud_firestore/cloud_firestore.dart';

class AllQuizModel {
  String id;
  String quizName;
  AllQuizModel({this.id, this.quizName});
  AllQuizModel.docuemnt(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    quizName = documentSnapshot['quizName'] ?? "";
  }
}
