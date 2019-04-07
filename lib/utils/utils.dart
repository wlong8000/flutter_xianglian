import 'package:flutter/cupertino.dart';

class Utils {
  ///size ： 一个包含宽度和高度的对象，单位是dp
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  ///devicePixelRatio : 返回设备的像素密度
  static double f(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }
}
