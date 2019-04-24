import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/model/detail_page_model.dart';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/common/string_utils.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/pages/cell/detail_cell.dart';

class DetailRoute extends StatefulWidget {
  final int id;

  const DetailRoute({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailPage();
  }
}

class _DetailPage extends State<DetailRoute> {
  Detail_page_model _detailPageModel;
  List<Detail_page_model> _data = [];
  bool _isFirstRequest = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: FutureBuilder(
        builder: _buildRefreshFuture,
        future: _getData(),
      ),
    );
  }

  CustomScrollView _buildCustomScrollView(Detail_page_model model) {
    return CustomScrollView(
      slivers: <Widget>[
        //AppBar，包含一个导航栏
        SliverAppBar(
          pinned: true,
          expandedHeight: 260,
          flexibleSpace: PreferredSize(
              child: FlexibleSpaceBar(
                title: Text(
                  getText(_detailPageModel.username),
                  style: TextStyle(fontSize: FontSize2.app_bar_title_size),
                ),
                background: Container(
                  color: Colors.black,
                  child: Image.network(
                    model.pic1,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(Size2.app_bar_height_size)),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: new SliverGrid(
            //Grid
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //Grid按两列显示
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                //创建子widget
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: new Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
        ),
//List
        _buildSliverFixedExtentList(),
      ],
    );
  }

  Widget _buildSliverFixedExtentList() {
    return new SliverFixedExtentList(
        itemExtent: 50.0,
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          //创建列表项
          return DetailCell(detailPageModel: _detailPageModel,);
        }, childCount: 1 //50个列表项
                ),
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
          return _buildLoadingView();
        }
        return _buildListView(context, snapshot);
      case ConnectionState.done:
        print('>>> & done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        return _buildListView(context, snapshot);
      default:
        return Text('还没有开始网络请求');
    }
  }

  Future _getData() async {
    print('怀疑没执行到这');
    return getUser(id: widget.id);
  }

  Center _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot snapshot) {
    bool hasData = snapshot.hasData;
    print(">>> _buildRefreshFuture... $hasData");
    if (hasData) {
      var resultString = snapshot.data.toString();
      var data = json.decode(resultString);
      _detailPageModel = Detail_page_model.fromMap(data);
      return _buildCustomScrollView(_detailPageModel);
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }
}
