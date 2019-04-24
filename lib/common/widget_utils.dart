import 'package:flutter/material.dart';

///这样封装，基本够用了
Widget buildDecoratedBox(
    {String text,
    Color textColor,
    double textSize,
    Color borderColor,
    double radius,
    double plr,
    double ptm,
    Color solidColor = Colors.transparent}) {
  if (text == null) {
    return Text('');
  } else {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: solidColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(plr, ptm, plr, ptm),
        child: Text(
          text,
          style: TextStyle(fontSize: textSize, color: textColor),
        ),
      ),
    );
  }
}
