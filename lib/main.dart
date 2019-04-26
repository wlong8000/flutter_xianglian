import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xianglian_fluter/pages/app_route.dart';
import 'package:xianglian_fluter/pages/splash_route.dart';
import 'package:xianglian_fluter/pages/search_route.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/pages/webview_route.dart';

void main() {
  runApp(MyApp());

  ///flutter设置沉浸式状态栏
  if (Platform.isAndroid) {
    /// 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，
    /// 覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    ///把状态栏和虚拟按键隐藏掉
//    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: String2.app_name,
      debugShowCheckedModeBanner: false,
      theme: mDefaultTheme,
      routes: <String, WidgetBuilder>{
        'app': (BuildContext context) => AppRoute(),
        'search': (BuildContext context) => SearchRoute(),
        'webview': (BuildContext context) => WebViewRoute(),
      },
      home: SplashRoute(),
    );
  }

  final ThemeData mDefaultTheme = new ThemeData(
    primaryColor: Colors2.color_1,
    scaffoldBackgroundColor: Colors2.color_5,
    accentColor: Colors2.color_1,
  );
}
