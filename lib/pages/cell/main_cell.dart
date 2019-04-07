import 'package:flutter/material.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/utils/utils.dart';

class MainCell extends StatelessWidget {
  final ResultsListBean mainPageModel;

  const MainCell({Key key, this.mainPageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.network(
              mainPageModel.pic1,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
        Wrap(
          spacing: 5.0,
          runSpacing: 140.0,
          children: <Widget>[
            buildLabel("29岁"),
            buildLabel("170cm"),
            buildLabel('双子座'),
            buildLabel('年收入:20万-30万'),
          ],
        ),
        Padding(padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0), child:
          Text(/*"大家好，我是一名HR,芳年40，希望找一个有责任心的男生，年龄不超过40，有车有房，有事业"*/ mainPageModel.username),)
      ],
    );
  }

  Chip buildLabel(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
      ),
      backgroundColor: Color(0xffFFD200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
