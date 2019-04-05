import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/main_route.dart';
import 'package:xianglian_fluter/pages/second_route.dart';
import 'package:xianglian_fluter/pages/three_route.dart';
import 'package:xianglian_fluter/pages/four_route.dart';

class AppRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AppRoute> {
  int _currentIndex = 0;

  MainRoute mainRoute;

  SecondRoute secondRoute;

  ThreeRoute threeRoute;

  FourRoute fourRoute;

  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (mainRoute == null) {
          mainRoute = new MainRoute();
        }
        return mainRoute;
      case 1:
        if (secondRoute == null) {
          secondRoute = new SecondRoute();
        }
        return secondRoute;
      case 2:
        if (fourRoute == null) {
          fourRoute = new FourRoute();
        }
        return fourRoute;
      case 3:
        if (threeRoute == null) {
          threeRoute = new ThreeRoute();
        }
        return threeRoute;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页tab"),
      ),
      body: currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: ((index) {
          setState(() {
            _currentIndex = index;
          });
        }),
        items: buildBottomBarItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> buildBottomBarItems() {
    return [
      new BottomNavigationBarItem(
          title: new Text(
            '首页',
            style: TextStyle(
                color:
                    _currentIndex == 0 ? Color(0xFF46c01b) : Color(0xff999999)),
          ),
          icon: _currentIndex == 0
              ? Image.asset(
                  'images/main_home_selected.png',
                  width: 32.0,
                  height: 28.0,
                )
              : Image.asset(
                  'images/main_home.png',
                  width: 32.0,
                  height: 28.0,
                )),
      new BottomNavigationBarItem(
          title: new Text(
            '通讯录',
            style: TextStyle(
                color:
                    _currentIndex == 1 ? Color(0xFF46c01b) : Color(0xff999999)),
          ),
          icon: _currentIndex == 1
              ? Image.asset(
                  'images/main_meet_selected.png',
                  width: 32.0,
                  height: 28.0,
                )
              : Image.asset(
                  'images/main_meet.png',
                  width: 32.0,
                  height: 28.0,
                )),
      new BottomNavigationBarItem(
          title: new Text(
            '发现',
            style: TextStyle(
                color:
                    _currentIndex == 2 ? Color(0xFF46c01b) : Color(0xff999999)),
          ),
          icon: _currentIndex == 2
              ? Image.asset(
                  'images/main_active_selected.png',
                  width: 32.0,
                  height: 28.0,
                )
              : Image.asset(
                  'images/main_active.png',
                  width: 32.0,
                  height: 28.0,
                )),
      new BottomNavigationBarItem(
          title: new Text(
            '我',
            style: TextStyle(
                color:
                    _currentIndex == 3 ? Color(0xFF46c01b) : Color(0xff999999)),
          ),
          icon: _currentIndex == 3
              ? Image.asset(
                  'images/main_me_selected.png',
                  width: 32.0,
                  height: 28.0,
                )
              : Image.asset(
                  'images/main_me.png',
                  width: 32.0,
                  height: 28.0,
                )),
    ];
  }
}
