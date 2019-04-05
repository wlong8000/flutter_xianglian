import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/app_route.dart';
import 'package:xianglian_fluter/pages/splash_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        'app': (BuildContext context) => AppRoute(),
      },
      home: SplashRoute(),
    );
  }
}
