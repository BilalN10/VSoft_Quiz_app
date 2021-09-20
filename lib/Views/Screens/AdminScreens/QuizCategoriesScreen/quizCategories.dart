import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/quizCategoryController.dart';
import 'package:quizapp/Controllers/quizQuestionComtroller.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/constants.dart';

import 'components/bottomSheet.dart';
import 'components/quizCategories.dart';

class QuizCategories extends StatelessWidget {
  QuizCategories({Key key, this.isQuizBank}) : super(key: key);
  final quizQuestionController = Get.put(QuizQuestionController());
  final bool isQuizBank;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: isQuizBank
      //     ?
      //     : SizedBox(),
      body: SingleChildScrollView(
        child: Container(
          height: 100 * SizeConfig.heightMultiplier,
          child: CommonBackground(
            childd: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 2 * SizeConfig.widthMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            CategoryBottomSheet(),

                            //barrierColor: Colors.red[50],
                            isDismissible: false,
                          );
                        },
                        child: Container(
                          height: 06 * SizeConfig.heightMultiplier,
                          width: 45 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add new Category ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 19,
                              )
                            ],
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5 * SizeConfig.widthMultiplier,
                      top: 03 * SizeConfig.heightMultiplier,
                      right: 5 * SizeConfig.widthMultiplier),
                  child: GetX<QuizCategoryController>(
                    init: Get.put<QuizCategoryController>(
                        QuizCategoryController()),
                    builder: (QuizCategoryController quizCategoryController) {
                      if (quizCategoryController != null &&
                          quizCategoryController.categorys != null) {
                        // for (int i = 0;
                        //     i < quizCategoryController.categorys.length;
                        //     i++) {
                        //   quizQuestionController.getCategoryUId(
                        //       quizCategoryController.categorys[i].id);
                        // }
                        return Container(
                          height: 71 * SizeConfig.heightMultiplier,
                          child: GridView.builder(
                              itemCount:
                                  quizCategoryController.categorys.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio:
                                          0.12 * SizeConfig.heightMultiplier,
                                      mainAxisSpacing:
                                          2 * SizeConfig.heightMultiplier,
                                      crossAxisSpacing:
                                          4 * SizeConfig.widthMultiplier,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                print(
                                    "Qategory id is ${quizCategoryController.categorys[index].id}");
                                return Categories(
                                  quizCategoryModel:
                                      quizCategoryController.categorys[index],
                                );
                              }),
                        );
                      } else {
                        return Text(
                          "loading...",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
