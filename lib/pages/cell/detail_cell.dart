import 'package:flutter/material.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/model/detail_page_model.dart';
import 'package:xianglian_fluter/common/string_utils.dart';
import 'package:xianglian_fluter/common/date_utils.dart';
import 'package:xianglian_fluter/common/touch_callback.dart';
import 'package:xianglian_fluter/pages/detail_route.dart';

class DetailCell extends StatelessWidget {
  final Detail_page_model detailPageModel;

  const DetailCell({Key key, this.detailPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TouchCallBack(
        child: _buildContainer(context),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return DetailRoute(id: detailPageModel.id,);
          }));
        });
  }

  Container _buildContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(3.0)),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  getText(detailPageModel.username),
                  style: TextStyle(color: Colors2.color_3, fontSize: 16),
                )),
                _buildIcon(detailPageModel.work_area_name),
                Text(
                  getText(detailPageModel.work_area_name),
                  style: TextStyle(color: Colors2.color_2, fontSize: 14),
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
              getText(detailPageModel.person_intro),
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
    int age = getAge(detailPageModel.birthday);
    if (age > 0) {
      buffer.write('$age岁  ');
    }
    if (detailPageModel.height > 0) {
      buffer.write('身高 ');
      buffer.write(detailPageModel.height.floor());
      buffer.write("cm  ");
    }
    if (detailPageModel.weight > 0) {
      buffer.write('体重 ');
      buffer.write(detailPageModel.weight.floor());
      buffer.write("kg  ");
    }
    if (detailPageModel.income > 0) {
      buffer.write('年收入 ');
      buffer.write(detailPageModel.income.floor());
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
