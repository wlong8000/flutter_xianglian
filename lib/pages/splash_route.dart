import 'package:flutter/material.dart';

class SplashRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashRoute> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("app");
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.network("http://img.zcool.cn/community/0122d95767a8060000012e7eda65bc.png");
  }
}
