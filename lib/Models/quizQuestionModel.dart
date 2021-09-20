import 'package:cloud_firestore/cloud_firestore.dart';

class QuizQuestionModel {
  String id;
  String question;
  String option_1;
  String option_2;
  String option_3;
  String option_4;
  String rightOptoin;

  // List<String> options;
  // int rightOption;
  // String question;

  QuizQuestionModel(
      {
      // this.options, this.rightOption, this.question
      this.id,
      this.option_1,
      this.option_2,
      this.option_3,
      this.option_4,
      this.question,
      this.rightOptoin});
  QuizQuestionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id = doc.id;
    question = doc.data()['question'].toString() ?? "";
    option_1 = doc.data()["option1"].toString();
    option_2 = doc.data()['option2'].toString();
    option_3 = doc.data()["option3"].toString();
    option_4 = doc.data()["option4"].toString();
    rightOptoin = doc.data()["rightOption"].toString();
    print(" nick name is is $id");
    print("option 1 is $option_1");
    print("Question is $question");
  }
  QuizQuestionModel.fromMap(Map<String, dynamic> data) {
    question = data['question'];
    option_1 = data["option1"];
    option_2 = data['option2'];
    option_3 = data["option3"];
    option_4 = data["option4"];
    rightOptoin = data["rightOption"];
    // id = data[ID];
    // image = data[IMAGE];
    // name = data[NAME];
    // quantity = data[QUANTITY];
    // cost = data[COST].toDouble();
    // productId = data[PRODUCT_ID];
    // price = data[PRICE].toDouble();
  }

  // Map toJson() => {
  //       // ID: id,
  //       // PRODUCT_ID: productId,
  //       // IMAGE: image,
  //       // NAME: name,
  //       // QUANTITY: quantity,
  //       // COST: price * quantity,
  //       // PRICE: price
  //       "question": question,
  //       "option1": option_1,
  //       'option2': option_2,
  //       "option3": option_3,
  //       "option4": option_4,

  //       "rightOption": rightOptoin,
  //     };
}
