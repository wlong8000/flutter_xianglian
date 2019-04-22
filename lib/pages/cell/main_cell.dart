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
//      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      color: Colors.white,
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
          Padding(padding: EdgeInsets.all(3.0)),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "胡歌",
                  style: TextStyle(color: Colors2.color_3, fontSize: 16),
                )),
                Icon(
                  Icons.location_on,
                  color: Colors2.color_2,
                  size: 14,
                ),
                Text(
                  '北京',
                  style: TextStyle(color: Colors2.color_2, fontSize: 14),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Text(
              '34岁 身高 175 体重 75 年收入 15-20万',
              style: TextStyle(fontSize: 14, color: Colors2.color_3),
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Text(
              '大家好，我叫小可爱，今年28岁，工作稳定，在一家国企，早九晚五，热爱生活，喜欢旅游，希望找一个志同道合的伙伴',
              style: TextStyle(fontSize: 13, color: Colors2.color_4),
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(padding: EdgeInsets.all(3.0)),
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
