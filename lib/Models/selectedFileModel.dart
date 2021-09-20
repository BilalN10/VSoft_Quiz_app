import 'package:cloud_firestore/cloud_firestore.dart';

class SelectedFilesModel {
  String id;
  String question;
  SelectedFilesModel({this.id, this.question});
  SelectedFilesModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    question = doc.data()['Questions'] ?? "";

    print(" category id is $id");
    //  print("category name is $question");
  }
}
