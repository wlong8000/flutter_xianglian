import 'package:flutter/material.dart';

getScreenWidth(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width;
}

getScreenHeight(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.height;
}

String getBirthday(age) {
  if (age == null) return null;
  int year = DateTime.now().year;
  int birthDay = year - age;
  return birthDay.toString() + "-01-01";
}
