import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    Key key,
    this.title,
    this.validations,
    this.hintText,
    this.controller,
  }) : super(key: key);
  final String title;
  final validations;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 2.3 * SizeConfig.textMultiplier,
              color: Colors.white,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 01 * SizeConfig.heightMultiplier,
        ),
        Container(
          alignment: Alignment.center,
          height: 07 * SizeConfig.heightMultiplier,
          width: 90 * SizeConfig.widthMultiplier,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 06,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(
                left: 03 * SizeConfig.widthMultiplier,
                top: 0.5 * SizeConfig.widthMultiplier,
                bottom: 1 * SizeConfig.heightMultiplier),
            child: TextFormField(
              controller: controller,
              validator: validations,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(fontWeight: FontWeight.w300)),
            ),
          ),
        ),
        SizedBox(
          height: 02 * SizeConfig.heightMultiplier,
        )
      ],
    );
  }
}
