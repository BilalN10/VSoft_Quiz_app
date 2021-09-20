import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/Controllers/EnterAmountValidationController.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';
import 'package:quizapp/Views/Widgets/CommonBackground.dart';
import 'package:quizapp/Views/Widgets/CommonFlateButton.dart';

class McqsAmount extends StatefulWidget {
  const McqsAmount({Key key}) : super(key: key);

  @override
  _McqsAmountState createState() => _McqsAmountState();
}

class _McqsAmountState extends State<McqsAmount> {
  TextEditingController amountvalue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final amountController = Get.put(EnterAmountValidation());
    return Scaffold(
      body: CommonBackground(
        childd: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter amount of Mcqs",
              style: TextStyle(
                  color: Colors.white, fontSize: 3 * SizeConfig.textMultiplier),
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier,
            ),
            Form(
              key: amountController.formkey,
              child: Container(
                height: 6.5 * SizeConfig.heightMultiplier,
                width: 40 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 03 * SizeConfig.widthMultiplier),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // keyboardType:
                    //     widget.isNumberField ? TextInputType.number : TextInputType.text,

                    // inputFormatters: [
                    //   widget.isNumberField
                    //       ? FilteringTextInputFormatter.digitsOnly
                    //       : FilteringTextInputFormatter.singleLineFormatter
                    // ],

                    decoration: InputDecoration(
                        hintText: "Enter Amount",
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: InputBorder.none),
                    onChanged: (text) {
                      amountController.updateamoun(int.parse(text));
                    },
                    validator: (value) {
                      return amountController.enterAmount(value);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10 * SizeConfig.heightMultiplier,
            ),
            CommonFlateButton(
              title: "Generate",
              height: 6.5 * SizeConfig.heightMultiplier,
              width: 30 * SizeConfig.widthMultiplier,
              pressed: () {
                return amountController.onAmountValidate();
              },
            )
          ],
        ),
      ),
    );
  }
}
