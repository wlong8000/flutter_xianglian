import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/cell/main_cell.dart';
import 'dart:convert';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/common/xl_ui_kit.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/ui/DQRefreshFooter.dart';
import 'package:xianglian_fluter/ui/DQRefreshHeader.dart';
import 'package:xianglian_fluter/common/data_callback.dart';

class MainRoute extends StatefulWidget {
  final DataCallback onCallBack;

  const MainRoute({Key key, this.onCallBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }

  void doSome(data) {

  }
}

class _MainPage extends State<MainRoute> {
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<DQRefreshHeaderState> _headerKey =
      new GlobalKey<DQRefreshHeaderState>();
  GlobalKey<DQRefreshFooterState> _footerKey =
      new GlobalKey<DQRefreshFooterState>();

  List<ResultsListBean> _data = [];
  bool _isLoadMore = false;
  String _nextUrl;
  bool _isFirstRequest = true;

  Future _requestFuture;

  Future _getData() async {
    return getUsers(loadMore: _isLoadMore, nextUrl: _nextUrl);
  }

  @override
  Widget build(BuildContext context) {
    _requestFuture = _getData();
    return FutureBuilder(
      builder: _buildRefreshFuture,
      future: _getData(),
    );
  }

  Widget _buildRefreshFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text('');
      case ConnectionState.active:
        return Text('');
      case ConnectionState.waiting:
        print('');
        if (_isFirstRequest) {
          _isFirstRequest = false;
          return LoadingKit();
        }
        return _buildListView(context, snapshot, loading: true);
      case ConnectionState.done:
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildListView(context, snapshot);
      default:
        return Text('还没有开始网络请求');
    }
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot,
      {loading = false}) {
    if (snapshot.hasData) {
      var resultString = snapshot.data.toString();
      debugPrint(resultString);
      var data = json.decode(resultString);

      MainPageModel newModel = MainPageModel.fromMap(data);
      List<ResultsListBean> list = newModel.results;

      _nextUrl = newModel.next;
      print(">>> next... $_nextUrl");
      if (!loading) {
        if (!_isLoadMore) {
          _data.clear();
          _data.addAll(list);
        } else {
          _data.addAll(list);
          _easyRefreshKey.currentState.callLoadMoreFinish();
        }
      }

      return EasyRefresh(
        key: _easyRefreshKey,
        behavior: ScrollOverBehavior(),
        autoControl: false,
        refreshHeader: DQRefreshHeader(
          key: _headerKey,
          bgColor: Color(0xfffafafa),
          showMore: true,
        ),
        refreshFooter: DQRefreshFooter(
          key: _footerKey,
          bgColor: Color(0xfffafafa),
          showMore: false,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MainCell(
              mainPageModel: _data[index],
            );
          },
          itemCount: _data.length,
          scrollDirection: Axis.vertical,
          semanticChildCount: _data.length + 1,
        ),
        onRefresh: () async {
          await _requestFuture;
          setState(() {
            _isLoadMore = false;
          });
          _easyRefreshKey.currentState.callRefreshFinish();
        },
        loadMore: () async {
          if (_nextUrl == null) {
            _easyRefreshKey.currentState.callLoadMoreFinish();
            return;
          }
          await _requestFuture;
          setState(() {
            _isLoadMore = true;
          });
        },
      );
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }
}
