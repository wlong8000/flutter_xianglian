import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/pages/main_route.dart';
import 'package:xianglian_fluter/pages/MyRoute.dart';
import 'package:xianglian_fluter/pages/party_route.dart';
import 'package:xianglian_fluter/model/search_page_model.dart';

class AppRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppPage();
  }
}

class _AppPage extends State<AppRoute> {
  int _currentIndex = 0;

  MainRoute mainRoute;

  PartyRoute secondRoute;

//  ThreeRoute threeRoute;

  MyRoute fourRoute;

  currentPage() {
    switch (_currentIndex) {
      case 0:
        if (mainRoute == null) {
          mainRoute = new MainRoute();
        }
        return mainRoute;
      case 1:
        if (secondRoute == null) {
          secondRoute = new PartyRoute();
        }
        return secondRoute;
      case 2:
        if (fourRoute == null) {
          fourRoute = new MyRoute();
        }
        return fourRoute;
//      case 3:
//        if (threeRoute == null) {
//          threeRoute = new ThreeRoute();
//        }
//        return threeRoute;
      default:
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      ///把状态栏显示出来
      SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text(
              String2.app_name,
              style: TextStyle(fontSize: FontSize2.app_bar_title_size),
            ),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0),
                child: GestureDetector(
                  onTap: () {
                    print("搜索");
                    Future f = Navigator.pushNamed(context, 'search');
                    f.then((data) {
                      mainRoute.setSearchData(data);
//                      print(data);
                    });
                  },
                  child: Icon(Icons.search),
                ),
              )
            ],
          ),
          preferredSize: Size.fromHeight(Size2.app_bar_height_size)),
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
//      _buildBottomNavigationBarItem(
//          titleName: '侃侃',
//          index: 1,
//          icon: 'images/main_meet.png',
//          selectedIcon: 'images/main_meet_selected.png'),
      _buildBottomNavigationBarItem(
          titleName: '活动',
          index: 1,
          icon: 'images/main_active.png',
          selectedIcon: 'images/main_active_selected.png'),
      _buildBottomNavigationBarItem(
          titleName: '我的',
          index: 2,
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
