import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class EditingTextField extends StatelessWidget {
  const EditingTextField({
    Key key,
    @required this.controller,
    @required this.width,
    this.maxl,
    this.border,
    @required this.title,
  }) : super(key: key);

  final TextEditingController controller;
  final double width;
  final int maxl;
  final String title;
  final double border;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * SizeConfig.widthMultiplier),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          SizedBox(
            height: 1 * SizeConfig.heightMultiplier,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.5 * SizeConfig.heightMultiplier),
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(border),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 2 * SizeConfig.widthMultiplier),
              child: TextField(
                autofocus: true,
                controller: controller,
                maxLines: maxl,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
