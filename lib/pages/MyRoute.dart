import 'package:flutter/material.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/config/color_config.dart';

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
    return ListView(
      children: <Widget>[
        _getHeaderCell(),
        Padding(padding: EdgeInsets.only(top: 12)),
        _getItemCell('我的相册'),
        _getItemCell('个人基本资料'),
        _getItemCell('择偶标准'),
        _getItemCell('内心独白'),
        Padding(padding: EdgeInsets.only(top: 12)),
        _getItemCell('退出账号'),
        _getItemCell('客服'),
      ],
    );
  }

  Widget _getHeaderCell() {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/set_image_bg.png',
          height: 160,
          width: getScreenWidth(context),
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 8)),
              CircleAvatar(
                backgroundImage: new NetworkImage(
                    'http://jspang.com/static//myimg/blogtouxiang.jpg'),
                radius: 40.0,
              ),
              Padding(padding: EdgeInsets.only(top: 8)),
              Text('上传头像'),
              Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                '将作为个人封面图，展示到首页',
                style: TextStyle(color: Colors2.color_10),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getItemCell(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors2.color_6),
            )),
            Image.asset(
              'images/icon_choose.png',
              width: 10,
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
