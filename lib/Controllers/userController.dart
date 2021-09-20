import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Models/quizQuestionModel.dart';
import 'package:quizapp/Models/resultModel.dart';
import 'package:quizapp/Models/userHistoryModel.dart';
import 'package:quizapp/Models/userModel.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserHomeScreen/userHomeScreen.dart';
import 'package:quizapp/Views/Screens/UserScreens/UserLoginScreen.dart/userLogin.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneNumbertController = TextEditingController();
  TextEditingController userQualificationController = TextEditingController();
  TextEditingController appliedForController = TextEditingController();
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());

  final box = GetStorage();
  RxString quizName = "".obs;
  RxInt totalMarks = 0.obs;
  RxInt obtainMarks = 0.obs;

  // final AllQuizController allQuizController = AllQuizController();

  TextEditingController userloginPasswordController = TextEditingController();
  TextEditingController userloginEmailController = TextEditingController();

  Rx<List<QuizQuestionModel>> quizList = Rx<List<QuizQuestionModel>>();

  List<QuizQuestionModel> get quiz => quizList.value;
  set student(String value) => this._student.value = value;
  int right = 0;
  RxString userId;
  RxBool isLogin = false.obs;
  RxBool isSignIn = true.obs;

  RxString _student = "".obs;
  // String set student = _student.value;
  String get student => _student.value;

  //final Rx<User> user = firebaseAuth.currentUser.obs;
  Rx<User> _firebaseUser = Rx<User>();

  User get user => _firebaseUser.value;

  Rx<List<QuizQuestionModel>> _healthList = Rx<List<QuizQuestionModel>>([]);
  List<QuizQuestionModel> get questionList => _healthList.value;
  Rx<List<UserModel>> userList = Rx<List<UserModel>>([]);
  List<UserModel> get users => userList.value;
  @override
  void onInit() {
    _firebaseUser.bindStream(firebaseAuth.authStateChanges());
    super.onInit();
  }

  void getUserForQuiz(String quizID) {
    userList.bindStream(userStream(quizID));
  }

  void condition() {
    isLogin = true.obs;
  }

  void addQuestion(QuizQuestionModel questionModel) {
    questionList.add(QuizQuestionModel(
      id: questionModel.id,
      option_3: questionModel.option_3,
      option_4: questionModel.option_4,
      question: questionModel.question,
      rightOptoin: questionModel.rightOptoin,
      option_1: questionModel.option_1,
      option_2: questionModel.option_2,
    ));

    update();
    //print(questionList);
    // calculate();
  }

  void removeQuestion(String question) {
    questionList.removeWhere((element) => element.question == question);
    update();
    //print(questionList);
  }

  void userLogin(String email, String password) {
    try {
      print("Enter in login function");
      firebaseAuth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        print("user Login iD is ${value.user.uid}");
        box.write('studentid', "${value.user.uid}");
        box.write("isStudent", true);
        box.write("isAdmin", false);

        //_student = value.user.uid.obs;
        //student = value.user.uid;
        isLogin.value = !isLogin.value;

        // allQuizController.getuserid(value.user.uid);
        // isLogin.value = !isLogin.value;

        // print("Email is $email");
        // userQuestionController.getUserId(value.user.uid
        //     // userController.userloginEmailController.value.text
        //     );
        // userId = userloginEmailController.value.text.obs;
        // userQuestionController.userID = value.user.uid.obs;
        // userId = value.user.uid.obs;
        userloginEmailController.clear();
        userloginPasswordController.clear();
        isSignIn.value = !isSignIn.value;

        Get.to(() => UserHomeScreen());
        // Get.to(() => AllQuiz(
        //       isAdmin: false,
        //     ));
      }).catchError((e) {
        isSignIn.value = !isSignIn.value;
        print(e);
        Get.snackbar(
          "Error in login",
          "Please provide valid Email and password",
        );
      });
    } catch (e) {
      print("Hello");
      Get.snackbar("Error", e.toString());
    }
  }

  Stream<List<UserModel>> userStream(String quizID) {
    return firebaseFirestore
        .collection("Admin")
        .doc(user.uid)
        .collection("MYQuiz")
        .doc(quizID)
        .collection("Student")
        .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserModel.fromDocumentSnapshot(element));
      });
      print("coming data is is  $retVal");
      return retVal;
    });
  }

  void createUser(
    String name,
    String email,
    String password,
    int phoneNumber,
    String qualification,
    String appliedFor,
  ) async {
    print("email is $email");
    try {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) => addUserInformation(
              name, email, phoneNumber, qualification, appliedFor))
          .catchError((e) {
        isLogin.value = !isLogin.value;
        Get.snackbar(
          "Error creating Account",
          e.toString(),
          snackPosition: SnackPosition.TOP,
        );
      });
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addUserInformation(
    String name,
    String email,
    int phoneNumber,
    String qualification,
    String appliedFor,
  ) async {
    try {
      await firebaseFirestore.collection("user").doc(user.uid).set({
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "qualfication": qualification,
        "appliedFor": appliedFor,
        "isQuizAssign": false,
        'dateCreated': Timestamp.now(),
      }).then((value) {
        Get.off(UserScreenLogin());
        // firebaseFirestore.collection("user").doc(value.id);
        // print(value.id);

        print("User Created");
        clearController();
      }).catchError((e) {
        Get.snackbar("Error", e.toString());
      });
      //print("DAta added Id is $userid");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void clearController() {
    userNameController.clear();
    userPasswordController.clear();

    userEmailController.clear();
    userPhoneNumbertController.clear();
    userQualificationController.clear();
    appliedForController.clear();
  }

  void removeAll(
    String userId,
    List<QuizQuestionModel> list,
  ) {
    for (int i = 0; i < list.length; i++) {
      firebaseFirestore
          .collection("user")
          .doc(userId)
          .collection("MYQuiz")
          .doc(list[i].id)
          .delete();
      print(list[i].id);
      //print(list[i].question);

      print(userId);
      print("Delete Data");
    }
  }

  Rx<List<UserHistoryModel>> userHistoryList = Rx<List<UserHistoryModel>>();
  List<UserHistoryModel> get userHistory => userHistoryList.value;

  void getuserHistory(String userId) {
    userHistoryList.bindStream(userHistoryStream(userId));
  }

  Stream<List<UserHistoryModel>> userHistoryStream(String userId) {
    // print("user iDD is $userid");
    return firebaseFirestore
        .collection("user")
        .doc(userId)
        .collection("QuizHistory")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserHistoryModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserHistoryModel.fromDocumentSnapshot(element));
      });
      print("coming data from userHistory  ${retVal.length}");
      //print("user id is $userID.value");
      return retVal;
    });
  }

  Rx<List<UserResultModel>> userReslutHistoryList = Rx<List<UserResultModel>>();
  List<UserResultModel> get resultHistory => userReslutHistoryList.value;

  void getidForReslut(String userId, String quizId) {
    userReslutHistoryList.bindStream(resultHistoryStream(userId, quizId));
  }

  Stream<List<UserResultModel>> resultHistoryStream(
      String userId, String quizId) {
    print("user iDD is $userId");
    print("QUiId is $quizId");
    return firebaseFirestore
        .collection("user")
        .doc(userId)
        .collection("QuizHistory")
        .doc(quizId)
        .collection("Result")
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserResultModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(UserResultModel.fromDocumentSnapshot(element));
      });
      print("coming data from userReslutHistory  ${retVal.length}");
      //print("user id is $userID.value");
      return retVal;
    });
  }

  // void addProductToCart(ProductModel product) {
  //   try {
  //     print("User value is ${userController.userModel.value}");
  //     if (_isItemAlreadyAdded(product)) {
  //       Get.snackbar("Check your cart", "${product.name} is already added");
  //     } else {
  //       String itemId = Uuid().toString();
  //       userController.updateUserData({
  //         "cart": FieldValue.arrayUnion([
  //           {
  //             "id": itemId,
  //             "productId": product.id,
  //             "name": product.name,
  //             "quantity": 1,
  //             "price": product.price,
  //             "image": product.image,
  //             "cost": product.price
  //           }
  //         ])
  //       });
  //       Get.snackbar("Item added", "${product.name} was added to your cart");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Cannot add this item");
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> addQuestionToUser(
  //   String question,
  //   String op1,
  //   String op2,
  //   String op3,
  //   String op4,
  //   String uid,
  // ) async {
  //   try {
  //     await firebaseFirestore
  //         .collection("user")
  //         .doc(uid)
  //         .collection("MY Quiz")
  //         .add({
  //       'option1': op1,
  //       'option2': op2,
  //       'option3': op3,
  //       'option4': op4,
  //       "question": question,
  //     });
  //     print("DAta added Id is $uid");
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
