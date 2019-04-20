import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/color_config.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 12)),
          _getItemCell('年龄'),
          _getItemCell('身高'),
          _getItemCell('居住地'),
          _getItemCell('家乡'),
          _getItemCell('学历'),
        ],
      ),
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
