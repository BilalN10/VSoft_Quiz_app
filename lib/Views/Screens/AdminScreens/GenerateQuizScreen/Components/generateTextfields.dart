import 'package:flutter/material.dart';

class GenerateQuizTextField extends StatelessWidget {
  const GenerateQuizTextField(
      {Key key,
      this.height,
      this.width,
      this.lines,
      this.hinttext,
      this.bordercircular,
      this.value,
      this.radioButton,
      this.contentPadding,
      this.validator})
      : super(key: key);
  final Widget radioButton;
  final double height;
  final double width;
  final int lines;
  final String hinttext;
  final double bordercircular;
  final bool contentPadding;
  final TextEditingController value;
  final Function validator;
  @override
  Widget build(BuildContext context) {
    Color primaryClr = Colors.blue;
    // final double leftPadding = 0;
    return SizedBox(
      //height: 56,
      //width: SizeConfig.widthMultiplier * 100,
      child: TextFormField(
        maxLines: null,
        //height: 56,
        //width: SizeConfig.widthMultiplier * 100,
        // keyboardType:
        //     widget.isNumberField ? TextInputType.number : TextInputType.text,

        // inputFormatters: [
        //   widget.isNumberField
        //       ? FilteringTextInputFormatter.digitsOnly
        //       : FilteringTextInputFormatter.singleLineFormatter
        // ],

        controller: value,
        // style: const TextStyle(color: Colors.blue),
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator ??
            (value) => value == null || value.isEmpty ? 'Required' : null,
        //obscureText: !_showPass && widget.isPass,
        cursorColor: primaryClr,

        //controller: widget.controller,
        decoration: InputDecoration(
          // border: InputBorder.none,
          //hintStyle: const TextStyle(color: Colors.blue),

          fillColor: Colors.white,
          filled: true,
          // prefixIcon: widget.prefixIcon != null
          //     ? Icon(
          //         widget.prefixIcon,
          //         color: primaryClr,
          //       )
          //     : null,
          hintText: hinttext,

          // labelText: widget.label,
          // labelStyle: MyTextStyles.bodyText2.copyWith(color: primaryClr),
          suffix: Container(
              height: 20,
              width: 25,
              decoration: BoxDecoration(
                  //color: Colors.amber,
                  shape: BoxShape.circle),
              child: radioButton),
          //     ? GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             _showPass = !_showPass;
          //           });
          //         },
          //         child: _showPass
          //             ? Icon(
          //                 Icons.visibility,
          //                 color: _showPass ? primaryClr : Colors.grey,
          //               )
          //             : Icon(
          //                 Icons.visibility_off,
          //                 color: _showPass ? primaryClr : Colors.grey,
          //               ),
          //       )
          //
          //    : null,
          // contentPadding:
          // contentPadding
          //     ? EdgeInsets.symmetric(
          //         vertical: 60.0, horizontal: 3 * SizeConfig.widthMultiplier)
          //     : EdgeInsets.only(top: 1, left: leftPadding),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          // widget.contentPadding
          //     ? EdgeInsets.symmetric(
          //         vertical: 60.0, horizontal: 3 * SizeConfig.widthMultiplier)
          //     :
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            // borderSide: const BorderSide(
            //   width: 3,
            // )
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            //   borderSide: BorderSide(width: 2, color: primaryClr)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            // borderSide: BorderSide(width: 2.0, color: primaryClr)
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            // borderSide: BorderSide(width: 2, color: primaryClr)
          ),
        ),
      ),
    );
    // return SizedBox(
    //   height: 6 * SizeConfig.heightMultiplier,
    //   width: width,
    //   child: Padding(
    //     padding:
    //         EdgeInsets.symmetric(horizontal: 0 * SizeConfig.widthMultiplier),
    //     child: TextField(
    //       controller: value,
    //       maxLines: lines,
    //       decoration: InputDecoration(
    //           contentPadding: EdgeInsets.only(top: 60, left: 1),
    //           suffix: radioButton,
    //           border:
    //               OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    //           hintText: hinttext,
    //           hintStyle: TextStyle(fontWeight: FontWeight.w300)),
    //       onSubmitted: (value) {},
    //     ),
    //   ),
    // );
  }
}
