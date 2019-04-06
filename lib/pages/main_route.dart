import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/cell/main_cell.dart';
import 'dart:convert';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
}

class _MainPage extends State<MainRoute> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      builder: _buildRefreshFuture,
      future: getUsers(),
    );
  }

  Widget _buildRefreshFuture(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      var resultString = snapshot.data.toString();
      var data = json.decode(resultString);
      Main_page_model model = Main_page_model.fromMap(data);
      List<ResultsListBean> results = model.results;
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return MainCell(
            mainPageModel: results[index],
          );
        },
        itemCount: results.length,
      );
    } else {
      return SpinKitCircle(
        color: Color(0xffd9d9d9),
        size: 50.0,
      );
    }
  }
}
