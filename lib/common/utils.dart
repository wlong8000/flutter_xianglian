import 'package:flutter/material.dart';

getScreenWidth(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width;
}

getScreenHeight(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.height;
}
