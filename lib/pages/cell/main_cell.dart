import 'package:flutter/material.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/config/color_config.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';

class MainCell extends StatelessWidget {
  final ResultsListBean mainPageModel;

  const MainCell({Key key, this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                mainPageModel.pic1,
                fit: BoxFit.cover,
                height: getScreenWidth(context) - 10,
                width: getScreenWidth(context) - 10,
              ),
              Image.asset(
                "images/icon_add_v.png",
                width: 60,
                height: 20,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(3.5)),
          Row(
            children: <Widget>[
              Text('胡歌'),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('胡歌'), color: Colors2.color_1,),)
            ],
          ),
          Padding(padding: EdgeInsets.all(3.5)),
          Row(
            children: <Widget>[
              Text('胡歌'),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text('胡歌'), color: Colors2.color_1,),)
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
            child: Text("大家好，我是一名HR,芳年40，希望找一个有责任心的男生，年龄不超过40，有车有房，有事业"),
          )
        ],
      ),
    );
  }

  Chip buildLabel(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
      ),
      backgroundColor: Color(0xfff5f5f5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
