import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/common/string_utils.dart';
import 'package:xianglian_fluter/common/date_utils.dart';
import 'package:xianglian_fluter/common/touch_callback.dart';
import 'package:xianglian_fluter/pages/detail_route.dart';

class MainCell extends StatelessWidget {
  final ResultsListBean mainPageModel;

  const MainCell({Key key, this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TouchCallBack(
        child: _buildContainer(context),
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: (context) {
            return DetailRoute(id: mainPageModel.id,);
          }));
        });
  }

  Container _buildContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(
                mainPageModel.pic1,
                fit: BoxFit.cover,
                height: getScreenWidth(context) - 150,
                width: getScreenWidth(context) - 150,
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
                  getText(mainPageModel.username),
                  style: TextStyle(color: Colors2.color_3, fontSize: 15),
                )),
                _buildIcon(mainPageModel.work_area_name),
                Text(
                  getText(mainPageModel.work_area_name),
                  style: TextStyle(color: Colors2.color_2, fontSize: 13),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: _buildText(),
            alignment: Alignment.centerLeft,
          ),
          Padding(padding: EdgeInsets.all(3.0)),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Text(
              getText(mainPageModel.person_intro),
              style: TextStyle(fontSize: 13, color: Colors2.color_4),
            ),
            alignment: Alignment.centerLeft,
          ),
          Padding(padding: EdgeInsets.all(3.0)),
        ],
      ),
    );
  }

  Text _buildText() {
    ///34岁 身高 175 体重 75 年收入 15-20万
    StringBuffer buffer = StringBuffer();
    int age = getAge(mainPageModel.birthday);
    if (age > 0) {
      buffer.write('$age岁  ');
    }
    if (mainPageModel.height > 0) {
      buffer.write('身高 ');
      buffer.write(mainPageModel.height.floor());
      buffer.write("cm  ");
    }
    if (mainPageModel.weight > 0) {
      buffer.write('体重 ');
      buffer.write(mainPageModel.weight.floor());
      buffer.write("kg  ");
    }
    if (mainPageModel.income > 0) {
      buffer.write('年收入 ');
      buffer.write(mainPageModel.income.floor());
      buffer.write("w");
    }
    return Text(
      buffer.toString(),
      style: TextStyle(fontSize: 14, color: Colors2.color_3),
    );
  }

  Widget _buildIcon(String text) {
    if (text == null) {
      return Text('');
    } else {
      return Icon(
        Icons.location_on,
        color: Colors2.color_2,
        size: 14,
      );
    }
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
