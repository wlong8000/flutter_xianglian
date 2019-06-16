import 'package:flutter/material.dart';
import 'package:xianglian_fluter/pages/cell/main_cell.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/common/xl_ui_kit.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/ui/DQRefreshFooter.dart';
import 'package:xianglian_fluter/ui/DQRefreshHeader.dart';
import 'package:xianglian_fluter/common/data_callback.dart';
import 'package:xianglian_fluter/viewmodel/main_page_view_model.dart';

class MainRoute extends StatefulWidget {
  final DataCallback onCallBack;

  const MainRoute({Key key, this.onCallBack}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
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
  List<ResultsListBean> _results;

  MainPageViewModel _mainPageViewModel;

  ConnectionState _connectionState = ConnectionState.waiting;

  @override
  void initState() {
    super.initState();
    _mainPageViewModel = MainPageViewModel((connectionState, data) {
      setState(() {
        _connectionState = connectionState;
        _results = data;
      });
    });
    _mainPageViewModel.getData(false);
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionState == ConnectionState.waiting) {
      return LoadingKit();
    }
    if (_connectionState == ConnectionState.done) {
      return _buildListView(context);
    }
    return null;
  }

  Widget _buildListView(BuildContext context) {
    if (_data != null) {
      if (!_mainPageViewModel.loadMore) {
        _data.clear();
        _data.addAll(_results);
        if (_easyRefreshKey.currentState != null)
          _easyRefreshKey.currentState.callRefreshFinish();
      } else {
        _data.addAll(_results);
        _easyRefreshKey.currentState.callLoadMoreFinish();
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
          _mainPageViewModel.getData(false);
//          await _requestFuture;
//          setState(() {
//            _isLoadMore = false;
//          });
//          _easyRefreshKey.currentState.callRefreshFinish();
        },
        loadMore: () async {
          if (_mainPageViewModel.nextUrl == null) {
            _easyRefreshKey.currentState.callLoadMoreFinish();
            return;
          }
          _mainPageViewModel.getData(true);
//          await _requestFuture;
//          setState(() {
//            _isLoadMore = true;
//          });
        },
      );
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }
}
