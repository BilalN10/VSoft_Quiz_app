import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Constant/firebaseConstant.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Models/quizCategoryModel.dart';
import 'package:quizapp/Views/Screens/AdminScreens/AdminQuizesScreen/adminQuizezScreen.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/constants.dart';

class Categories extends StatelessWidget {
  Categories({
    Key key,
    this.quizCategoryModel,
  }) : super(key: key);
  final QuizCategoryModel quizCategoryModel;
  final quizQuestionController = Get.put(QuizQuestionController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //firebaseFirestore.collection("Quiz").
        Get.defaultDialog(
            title: "Delete Category",
            titleStyle: TextStyle(
              fontSize: 3 * SizeConfig.textMultiplier,
            ),
            middleText: "Do you want to delete this Category",
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        firebaseFirestore
                            .collection("Quiz")
                            .doc(quizCategoryModel.id)
                            .delete();
                        Get.back();
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            fontSize: 3 * SizeConfig.textMultiplier,
                            color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      width: 4 * SizeConfig.widthMultiplier,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 3 * SizeConfig.textMultiplier,
                            color: primarycolor),
                      ),
                    ),
                  ],
                ),
              )
            ]);
      },
      onTap: () {
        quizQuestionController.quizCategoryID = quizCategoryModel.id.obs;
        print("On Press Quiz ID is ${quizQuestionController.quizCategoryID}");
        quizQuestionController.getCategoryUId(quizCategoryModel.id);
        Get.to(AdminQuizScreen());

        // Get.to(McqsAmount());
      },
      child: Container(
        height: 10 * SizeConfig.heightMultiplier,
        width: 40 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 3 * SizeConfig.heightMultiplier,
            ),
            SizedBox(
              height: 6 * SizeConfig.heightMultiplier,
              child: Image.asset("assets/Images/AppLogo.png"),
            ),
            Spacer(),
            Container(
              width: 43 * SizeConfig.widthMultiplier,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      quizCategoryModel.categoryName,
                      style:
                          TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 0.5 * SizeConfig.heightMultiplier,
                    ),
                    Container(
                      width: 43 * SizeConfig.widthMultiplier,
                      height: 3 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      // child: Center(
                      //   child:Text(
                      //           "${quizQuestionController.quiz.length.toString()} MCQ's",
                      //           style: TextStyle(
                      //               color: Colors.white,
                      //               fontWeight: FontWeight.w500),
                      //         )
                      // ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
