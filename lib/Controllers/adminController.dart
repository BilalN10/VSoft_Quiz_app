import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminHomeScreen/adminHomeScreen.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminLoginScreen/adminLoginScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/constants.dart';

class AdminController extends GetxController {
  final UserController userController = Get.put(UserController());
  final UserQuestionController userQuestionController =
      Get.put(UserQuestionController());

  final TextEditingController adminEmailController = TextEditingController();
  final TextEditingController adminPasswordController = TextEditingController();
  final TextEditingController adminSignUPEmailController =
      TextEditingController();
  final TextEditingController adminSignUPpaswrdController =
      TextEditingController();
  final TextEditingController adminNameController = TextEditingController();
  final box = GetStorage();
  RxBool isLogin = true.obs;
  RxBool isSignUp = true.obs;

  void createAdmin(String email, String password, String name) async {
    print("email is $email");
    try {
      firebaseAuth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        addAdminInformation(email, name);
      }).catchError((e) {
        Get.snackbar(
          "Error creating Account",
          "Account not Create",
          snackPosition: SnackPosition.TOP,
        );
        isSignUp.value = !isSignUp.value;
        print("Value after snackbar $isSignUp");
      });

      //print("Admin Sign Up");
    } catch (e) {
      Get.snackbar(
        "Error creating Account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> addAdminInformation(String email, String name) async {
    try {
      await firebaseFirestore
          .collection("Admin")
          .doc(userController.user.uid)
          .set({
        "Name": name,
        "Email": email,
      }).then((value) {
        isSignUp.value = true;
        controllerClear();
        Get.to(() => AdminScreen());
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> adminLogin(String email, String password) async {
    try {
      firebaseAuth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        firebaseFirestore
            .collection('Admin')
            .doc(value.user.uid)
            .get()
            .then((value) {
          print("the value we get is ${value.id}");
          if (value.data() == null) {
            isLogin.value = !isLogin.value;
            Get.defaultDialog(
                title: "Admin not found",
                middleText: "Please create account as a Admin",
                middleTextStyle: TextStyle(color: primarycolor),
                actions: [
                  CommonFlateButton(
                    height: 5 * SizeConfig.heightMultiplier,
                    width: 10 * SizeConfig.widthMultiplier,
                    title: "Ok",
                    pressed: () {
                      Get.back();
                    },
                  )
                ]);
            adminEmailController.clear();
            adminPasswordController.clear();
          } else {
            //     userQuestionController.adminID = value.user.uid.obs;
            // print(value.user.uid);
            box.write("isAdmin", true);
            box.write("isStudent", false);
            isLogin.value = !isLogin.value;
            adminEmailController.clear();
            adminPasswordController.clear();
            Get.to(AdminHome());
          }
        });
      }).catchError((e) {
        Get.snackbar(
          "Error in login",
          "${e.toString()}",
        );
        isLogin.value = !isLogin.value;
      });
    } catch (e) {
      print(e);
    }
  }

  void controllerClear() {
    adminSignUPEmailController.clear();
    adminNameController.clear();
    adminPasswordController.clear();
  }
}
