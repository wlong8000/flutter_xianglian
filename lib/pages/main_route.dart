import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/cell/main_cell.dart';
import 'dart:convert';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/common/xl_ui_kit.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/ui/DQRefreshFooter.dart';
import 'package:xianglian_fluter/ui/DQRefreshHeader.dart';

class MainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
}

class _MainPage extends State<MainRoute> {
  String homePageContent = '正在获取数据';

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<DQRefreshHeaderState> _headerKey  = new GlobalKey<DQRefreshHeaderState>();
  GlobalKey<DQRefreshFooterState> _footerKey  = new GlobalKey<DQRefreshFooterState>();

  List<ResultsListBean> _data = [];
  bool _isLoadMore = false;
  String _nextUrl;
  bool _isFirstRequest = true;

  String showMessage = "";
  Future requestFuture;

  Future _getData() async {
    return getUsers(loadMore: _isLoadMore, nextUrl: _nextUrl);
  }

  @override
  Widget build(BuildContext context) {
    requestFuture = _getData();
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

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot, {loading=false}) {
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
          //如果是下拉刷新或者第一次数据请求，那么直接替换赋值
          _data.clear();
          _data.addAll(list);
        } else {
          //加载更多的情况
          _data.addAll(list);

          if(snapshot.connectionState == ConnectionState.done) {
            if(list.length <= 0) {
              _footerKey.currentState.onNoMore();
            } else {
              _footerKey.currentState.onLoaded();
            }
            _easyRefreshKey.currentState.callLoadMoreFinish();
          }
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
          await requestFuture;
          setState(() {
            _isLoadMore = false;
          });
          _easyRefreshKey.currentState.callRefreshFinish();
        },
        loadMore: _nextUrl != null ? () async {
          await requestFuture;
          setState(() {
            _isLoadMore = true;
          });
        } : null,
      );
    } else {
      return Center(child: Text("暂无数据"),);
    }
  }
}
