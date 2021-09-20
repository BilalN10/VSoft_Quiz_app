import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userid;
  String name;
  String email;
  String password;
  int phoneNumber;
  String qualification;
  String appliedFor;
  bool isQuizAssign;
  UserModel(
      {this.appliedFor,
      this.userid,
      this.email,
      this.isQuizAssign,
      this.name,
      this.phoneNumber,
      this.password,
      this.qualification});
  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    userid = doc.id;
    name = doc.data()["name"];
    email = doc.data()["email"];
    phoneNumber = doc.data()["phoneNumber"];
    qualification = doc.data()["qualfication"];
    appliedFor = doc.data()["appliedFor"];
    isQuizAssign = doc.data()["isQuizAssign"];
    print("user id is $userid");
    print("user id is $name");
  }
}
