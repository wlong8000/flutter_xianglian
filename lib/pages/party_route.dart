import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/model/party_page_model.dart';
import 'package:xianglian_fluter/pages/cell/party_cell.dart';
import 'package:xianglian_fluter/common/xl_ui_kit.dart';

class PartyRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PartyPage();
  }
}

class _PartyPage extends State<PartyRoute> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  List<ResultsListBean> _data = [];
  bool _isLoadMore = false;
  String _nextUrl;
  bool _isFirstRequest = true;

  Future _getData() async {
    return getParty(_isLoadMore, _nextUrl);
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
          return LoadingKit();
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

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot,
      {loading = false}) {
    bool hasData = snapshot.hasData;
    print(">>> _buildRefreshFuture... $hasData");
    if (hasData) {
      var resultString = snapshot.data.toString();
      var data = json.decode(resultString);
      Party_page_model model = Party_page_model.fromMap(data);
//      _nextUrl = model.next;
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
        return PartyCell(
          resultsListBean: results[index],
        );
      },
      itemCount: results.length,
    );
  }
}
