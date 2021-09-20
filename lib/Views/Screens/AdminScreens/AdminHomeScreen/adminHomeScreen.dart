import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Views/Screens/AdminScreens/QuizBank/quizBankScreen.dart';
import 'package:quizapp/Views/Screens/AdminScreens/QuizCategoriesScreen/quizCategories.dart';
import 'package:quizapp/Views/Screens/AdminUserSelectionPage/adminUserSelectionPage.dart';
import 'package:quizapp/Views/Screens/UserScreens/AllQuiz/allQuizScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';
import 'package:quizapp/Views/Screens/AdminScreens/SelectedFile/selectFile.dart';

class AdminHome extends StatelessWidget {
  AdminHome({Key key}) : super(key: key);
  final bool isquizBank = false;
  final bool isquizGenerate = true;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        childd: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
            ),
            SizedBox(
                height: 10 * SizeConfig.heightMultiplier,
                child: Image.asset("assets/Images/admin.png")),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier,
            ),
            CommonFlateButton(
                title: "Genearte Quiz",
                pressed: () {
                  Get.to(QuizCategories(
                    isQuizBank: isquizGenerate,
                  ));
                },
                width: 70 * SizeConfig.widthMultiplier,
                height: 08 * SizeConfig.heightMultiplier),
            SizedBox(height: 05 * SizeConfig.heightMultiplier),
            // CommonFlateButton(
            //     title: "",
            //     pressed: () {
            //       Get.to(UserScreen());
            //     },
            //     width: 70 * SizeConfig.widthMultiplier,
            //     height: 08 * SizeConfig.heightMultiplier),
            // SizedBox(height: 05 * SizeConfig.heightMultiplier),

            CommonFlateButton(
                title: "Quiz Bank",
                pressed: () {
                  Get.to(QuizBankScreen());
                },
                width: 70 * SizeConfig.widthMultiplier,
                height: 08 * SizeConfig.heightMultiplier),
            SizedBox(height: 05 * SizeConfig.heightMultiplier),

            CommonFlateButton(
                title: "Select File",
                pressed: () {
                  Get.to(SelecFile()
                      //   MyHomePage(
                      //   title: "Pick File",
                      // )
                      );
                },
                width: 70 * SizeConfig.widthMultiplier,
                height: 08 * SizeConfig.heightMultiplier),
            SizedBox(height: 05 * SizeConfig.heightMultiplier),

            CommonFlateButton(
                title: "Users Result",
                pressed: () {
                  // firebaseAuth.signOut().then((value) {
                  //   print("user SignOut");
                  // });
                  // Get.to(ShowAllUsers());
                  Get.to(() => AllQuiz(
                        isAdmin: true,
                      ));
                },
                width: 70 * SizeConfig.widthMultiplier,
                height: 08 * SizeConfig.heightMultiplier),
            SizedBox(height: 03 * SizeConfig.heightMultiplier),

            GestureDetector(
                onTap: () {
                  box.write("isAdmin", false);
                  firebaseAuth.signOut();

                  //userController.student = null;

                  //userid.value = "";
                  Get.offAll(() => AdminUserSelectionPage());
                },
                child: Text(
                  "LogOut",
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 01 * SizeConfig.heightMultiplier,
                    decoration: TextDecoration.underline,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
