import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizCategoryController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonTextField.dart';
import 'package:quizapp/Views/constants.dart';

class CategoryBottomSheet extends StatelessWidget {
  final TextEditingController categorytxtController =
      new TextEditingController();
  final quizCategoryController = Get.put(QuizCategoryController());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60 * SizeConfig.heightMultiplier,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 2 * SizeConfig.heightMultiplier,
            ),
            Center(
              child: Text(
                "Enter Category Name",
                style: TextStyle(
                    fontSize: 3 * SizeConfig.textMultiplier,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CommonTextField(
              controller: categorytxtController,
              hintText: "Category Name",
              title: "Catrgory Name ",
              validations: null,
            ),
            //
            GestureDetector(
              onTap: () {
                if (categorytxtController.text == null ||
                    categorytxtController.text.isEmpty) {
                  Get.defaultDialog(
                      title: "Enter name",
                      titleStyle: TextStyle(
                        fontSize: 3 * SizeConfig.textMultiplier,
                      ),
                      middleText: "Please Enter Category Name",
                      middleTextStyle: TextStyle(
                        fontSize: 2 * SizeConfig.textMultiplier,
                      ),
                      actions: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontSize: 3 * SizeConfig.textMultiplier,
                              ),
                            ))
                      ]);
                } else {
                  quizCategoryController
                      .addCategory(categorytxtController.text);
                  Get.back();
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 5 * SizeConfig.heightMultiplier,
                width: 20 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
