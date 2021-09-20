import 'package:cloud_firestore/cloud_firestore.dart';

class UserHistoryModel {
  String id;
  //DocumentReference history;
  String quizName;
  UserHistoryModel({this.id, this.quizName});

  UserHistoryModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    quizName = doc.data()["quizName"] ?? "";
    //history = doc.data()["History"] ?? "";
    // history.get().then((value) {
    //   quizName = value.data()['quizName'] ?? ' ';
    // });
    // obtainMarks = doc.data()['Obtain marks'] ?? "";
    // totalMarks = doc.data()["Total marks"] ?? "";
    // history.collection("Reslut").snapshots().map((QuerySnapshot query) {
    //   List<UserResultModel> userReslutList = [];
    // });
    //history.collection(collectionPath)

    // print(" DocumrentReferance  is $history");
    print(id);
    print(quizName);
    // FirebaseFirestore.instance.collection('user').doc(slkfjs).collection(collectionPath)
    // print("category name is $categoryName");
  }
}
