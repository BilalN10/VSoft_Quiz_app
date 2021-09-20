import 'package:flutter/material.dart';
import 'package:quizapp/Views/SizeConfig/sizeConfig.dart';

class UserTypeContainer extends StatefulWidget {
  const UserTypeContainer({
    Key key,
    this.image,
    this.title,
    this.nextPage,
  }) : super(key: key);
  final String image;
  final String title;
  final nextPage;

  @override
  _UserTypeContainerState createState() => _UserTypeContainerState();
}

class _UserTypeContainerState extends State<UserTypeContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.nextPage,
      child: Container(
        height: 18 * SizeConfig.heightMultiplier,
        width: 40 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 04,
              // spreadRadius: 01,
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 02 * SizeConfig.heightMultiplier,
            ),
            Image.asset(
              widget.image,
              height: 17 * SizeConfig.imageSizeMultiplier,
            ),
            SizedBox(
              height: 02 * SizeConfig.heightMultiplier,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 2.5 * SizeConfig.textMultiplier),
            )
          ],
        ),
      ),
    );
  }
}
