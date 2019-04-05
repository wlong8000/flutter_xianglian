import 'package:flutter/material.dart';
import 'package:xianglian_fluter/model/global_model.dart';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SplashRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashRoute> {
  Global_model _global_model;

  @override
  void initState() {
    _search();
    _request();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("app");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return _global_model == null
        ? Image.network(
            "http://img.zcool.cn/community/0122d95767a8060000012e7eda65bc.png")
        : Image.network(
            "https://photo.16pic.com/00/49/62/16pic_4962232_b.jpg");
  }

  _request() {
    Future future = getGlobal();
    future.then((data) {
//      Global_model global_model = Global_model.fromMap(data);
      _add(json.encode(data));
    });
  }

  _add(String modelStr) async {
    Future<SharedPreferences> spFuture = SharedPreferences.getInstance();
    spFuture.then((value) {
      value.setString("key_global", modelStr);
      print("save global 数据成功");
    });
  }

  _search() async {
    Future<SharedPreferences> spFuture = SharedPreferences.getInstance();
    spFuture.then((value) {
      String j = value.getString("key_global");
      Map<String, dynamic> map = json.decode(j);
      _global_model = Global_model.fromMap(map);
      print("search global 数据成功");
      setState(() {});
    });
  }
}
