import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/color_config.dart';
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
      appBar: PreferredSize(
          child: AppBar(
            title: Text(
              "享恋",
              style: TextStyle(fontSize: 14),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: GestureDetector(
                  onTap: () {
                    print("搜索");
                  },
                  child: Icon(Icons.search),
                ),
              )
            ],
          ),
          preferredSize: Size.fromHeight(44)),
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
      _buildBottomNavigationBarItem(
          titleName: '首页',
          index: 0,
          icon: 'images/main_home.png',
          selectedIcon: 'images/main_home_selected.png'),
      _buildBottomNavigationBarItem(
          titleName: '通讯录',
          index: 1,
          icon: 'images/main_meet.png',
          selectedIcon: 'images/main_meet_selected.png'),
      _buildBottomNavigationBarItem(
          titleName: '发现',
          index: 2,
          icon: 'images/main_active.png',
          selectedIcon: 'images/main_active_selected.png'),
      _buildBottomNavigationBarItem(
          titleName: '我的',
          index: 3,
          icon: 'images/main_me.png',
          selectedIcon: 'images/main_me_selected.png'),
    ];
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String titleName, int index, String selectedIcon, String icon}) {
    return BottomNavigationBarItem(
        title: new Text(
          titleName,
          style: TextStyle(
              color:
                  _currentIndex == index ? Colors2.color_1 : Color(0xff999999)),
        ),
        icon: _currentIndex == index
            ? Image.asset(
                selectedIcon,
                width: 24.0,
                height: 24.0,
              )
            : Image.asset(
                icon,
                width: 24.0,
                height: 24.0,
              ));
  }
}
