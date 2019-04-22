import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/pages/cell/main_cell.dart';
import 'dart:convert';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';

class MainRoute extends StatefulWidget {
  Map<String, dynamic> _params;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }

  void setSearchData(data) {
    _params = data;
    print(data);
    createState();
  }
}

class _MainPage extends State<MainRoute> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  List<ResultsListBean> _data = [];
  bool _isLoadMore = false;
  String _nextUrl;
  bool _isFirstRequest = true;

  Future _getData() async {
    return getUsers(
        loadMore: _isLoadMore, nextUrl: _nextUrl, params: widget._params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(">>> build...");
    return FutureBuilder(
      builder: _buildRefreshFuture,
      future: _getData(),
    );
  }

  Widget _buildRefreshFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('>>> & 还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('>>> & active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('>>> & waiting');
        if (_isFirstRequest) {
          _isFirstRequest = false;
          return buildLoadingView();
        }
        return _buildListView(context, snapshot, loading: true);
      case ConnectionState.done:
        print('>>> & done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildListView(context, snapshot);
      default:
        return Text('还没有开始网络请求');
    }
  }

  Center buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot,
      {loading = false}) {
    bool hasData = snapshot.hasData;
    print(">>> _buildRefreshFuture... $hasData");
    if (hasData) {
      var resultString = snapshot.data.toString();
      var data = json.decode(resultString);
      Main_page_model model = Main_page_model.fromMap(data);
      _nextUrl = model.next;
      print(">>> next... $_nextUrl");
      List<ResultsListBean> results = model.results;
      if (!loading) {
        print(">>> &&&&");
        if (!_isLoadMore) {
          _data.clear();
          _data.addAll(results);
        } else {
          _data.addAll(results);
        }
      }

      return EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        child: _buildListView2(_data),
        onRefresh: () async {
          print(">>> onRefresh...");
          _easyRefreshKey.currentState.waitState(() {
            setState(() {
              _isLoadMore = false;
            });
          });
        },
        loadMore: _nextUrl != null
            ? () async {
                print(">>> loadMore...");
                _easyRefreshKey.currentState.waitState(() {
                  setState(() {
                    _isLoadMore = true;
                  });
                });
              }
            : null,
      );
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }

  ListView _buildListView2(List<ResultsListBean> results) {
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
