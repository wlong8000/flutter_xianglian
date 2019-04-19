import 'package:flutter/material.dart';

class MyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyPage();
  }
}

class _MyPage extends State<MyRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("首页4"),
    );
  }
}
