import 'package:flutter/material.dart';
import 'package:xianglian_fluter/model/global_model.dart';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/common/shared_preferences_utils.dart';
import 'dart:convert';

class SplashRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashRoute> {
  Global_model _globalModel;

  @override
  void initState() {
    search("key_global", (value) {
      Map<String, dynamic> map = json.decode(value);
      _globalModel = Global_model.fromMap(map);
      print("search global 数据成功");
      setState(() {});
    });
    _request();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed("app");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build...");
    return _globalModel == null
        ? Image.network(
            "http://img.zcool.cn/community/0122d95767a8060000012e7eda65bc.png")
        : Image.network(_globalModel.default_splash_img);
  }

  _request() {
    Future future = getGlobal();
    future.then((data) {
      add("key_global", data);
    });
  }
}
