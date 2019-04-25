import 'package:flutter/material.dart';
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
  List<ResultsListBean> _data = [];
  bool _isLoadMore = false;
  String _nextUrl;
  bool _isFirstRequest = true;
  ScrollController _scrollController = ScrollController();

  Future _getData() async {
    return getUsers(
        loadMore: _isLoadMore, nextUrl: _nextUrl, params: widget._params);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print('=========> pixels  ' +
          _scrollController.position.pixels.toString() +
          ", maxScrollExtent" +
          _scrollController.position.maxScrollExtent.toString());
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("------------加载更多-------------");
//        _getMoreData();
        _pullToRefresh2(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstRequest) {
      return FutureBuilder(
        builder: _buildRefreshFuture,
        future: _getData(),
      );
    } else {
      return _buildRefreshIndicator();
    }
  }

  ///下拉回调方法,方法需要有async和await关键字，没有await，刷新图标立马消失，没有async，刷新图标不会消失
  Future<Null> _pullToRefresh({bool isLoadMore = false}) async {
    _isLoadMore = isLoadMore;
    Future future = await _getData();
    future.then((value) {
      setState(() {
        _setData(value);
        return null;
      });
    });
  }

  ///没找到为啥，loadMore的时候，加上await，回不来数据了
  Future<Null> _pullToRefresh2({bool isLoadMore = false}) async {
    _isLoadMore = isLoadMore;
    //todo 不知道啥原因，先todo
//    Future future = await _getData();
    Future future = _getData();
    future.then((value) {
      setState(() {
        _setData(value);
        return null;
      });
    });
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
          return _buildLoadingView();
        }

        ///只有第一次会进来，按理走不到这个地方，所以返回null
        return null;
      case ConnectionState.done:
        print('>>> & done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildListView(context, snapshot);
      default:
        return Text('还没有开始网络请求');
    }
  }

  Center _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot) {
    bool hasData = snapshot.hasData;
    if (hasData) {
      _handleData(snapshot.data.toString());
      return _buildRefreshIndicator();
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }

  void _handleData(String resultString) {
    var data = json.decode(resultString);
    Main_page_model model = Main_page_model.fromMap(data);
    _nextUrl = model.next;
    print(">>> next... $_nextUrl");
    List<ResultsListBean> results = model.results;
    if (!_isLoadMore) {
      _data.clear();
      _data.addAll(results);
    } else {
      _data.addAll(results);
    }
  }

  _setData(String value) {
    if (value != null && value.isNotEmpty) {
      _handleData(value);
    }
  }

  Widget _buildRefreshIndicator() {
    if (_data == null || _data.isEmpty) {
      return null;
    }
    return RefreshIndicator(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == _data.length) {
              //是否滑动到底部
              return LoadMoreView();
            } else {
              return MainCell(
                mainPageModel: _data[index],
              );
            }
          },
          itemCount: _data.length + 1,
          controller: _scrollController,
        ),
        onRefresh: _pullToRefresh);
  }
}

class LoadMoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                width: 23,
                height: 23,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                '加载中...',
                style: TextStyle(fontSize: 14),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      color: Colors.white70,
    );
  }
}
