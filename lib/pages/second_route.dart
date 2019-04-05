import 'package:flutter/material.dart';

class SecondRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondPage();
  }
}

class _SecondPage extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("首页2"),);
  }
}
