import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  bool _isLoadMore = false;
  List<ResultsListBean> _data = [];
  String _nextUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(">>> build...");
    return FutureBuilder(
      builder: _buildRefreshFuture,
      future: getUsers(_isLoadMore, _nextUrl),
    );
  }

  Widget _buildRefreshFuture(BuildContext context, AsyncSnapshot snapshot) {
    bool hasData = snapshot.hasData;
    print(">>> _buildRefreshFuture... $hasData");
    if (hasData) {
      var resultString = snapshot.data.toString();
      var data = json.decode(resultString);
      Main_page_model model = Main_page_model.fromMap(data);
      List<ResultsListBean> results = model.results;
      if (!_isLoadMore) {
        _data.clear();
        _data.addAll(results);
      } else {
        if (_nextUrl != model.next) {
          _data.addAll(results);
        }
      }
      _nextUrl = model.next;
      print(">>> next... $_nextUrl");
      return EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        child: buildListView(_data),
        onRefresh: () async {
          print(">>> onRefresh...");
          _easyRefreshKey.currentState.waitState(() {
            setState(() {
              _isLoadMore = false;
            });
          });
        },
        loadMore: _nextUrl != null ? () async {
          print(">>> loadMore...");
          _easyRefreshKey.currentState.waitState(() {
            setState(() {
              _isLoadMore = true;
            });
          });
        } : null,
      );
    } else {
      return SpinKitCircle(
        color: Color(0xffd9d9d9),
        size: 50.0,
      );
    }
  }

  ListView buildListView(List<ResultsListBean> results) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return MainCell(
          mainPageModel: results[index],
        );
      },
      itemCount: results.length,
    );
  }
}
