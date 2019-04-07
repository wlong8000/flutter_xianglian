import 'package:flutter/material.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/utils/utils.dart';

class MainCell extends StatelessWidget {
  final ResultsListBean mainPageModel;

  const MainCell({Key key, this.mainPageModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Image.network(mainPageModel.pic1, fit: BoxFit.fitWidth, ),
        ],
      ),
      Text(mainPageModel.username),
    ],);
  }


}