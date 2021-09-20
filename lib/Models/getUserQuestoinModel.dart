import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserQuestionModel {
  String id;
  String question;
  String option_1;
  String option_2;
  String option_3;
  String option_4;
  String rightOptoin;
  String userSelection;

  // List<String> options;
  // int rightOption;
  // String question;

  GetUserQuestionModel(
      {
      // this.options, this.rightOption, this.question
      this.userSelection,
      this.id,
      this.option_1,
      this.option_2,
      this.option_3,
      this.option_4,
      this.question,
      this.rightOptoin});
  GetUserQuestionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    question = doc.data()['question'] ?? "";
    option_1 = doc.data()["option1"] ?? " ";
    option_2 = doc.data()['option2'] ?? "";
    option_1 = doc.data()["option1"] ?? " ";
    option_3 = doc.data()["option3"] ?? " ";
    option_4 = doc.data()["option4"] ?? " ";
    rightOptoin = doc.data()["rightOption"] ?? " ";
    userSelection = doc.data()["userSelection"] ?? " ";
    // print(" nick name is is $id");
    // print("option 1 is $option_1");
    // print("Questions is $question");
  }
}
