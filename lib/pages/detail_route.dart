import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/model/detail_page_model.dart';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/common/string_utils.dart';
import 'package:xianglian_fluter/pages/cell/detail_cell.dart';
import 'package:xianglian_fluter/file/user_data.dart';
import 'package:xianglian_fluter/common/touch_callback.dart';
import 'package:xianglian_fluter/common/gallery_route.dart';

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
        _buildSliverAppBar(model),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          sliver: _buildSliverGrid(),
        ),
        _buildSliverFixedExtentList(),
      ],
    );
  }

  SliverGrid _buildSliverGrid() {
    if (isImageEmpty()) {
      return null;
    }
    return SliverGrid(
      //Grid
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          //创建子widget
          return TouchCallBack(
              child: Image.network(
                _detailPageModel.images[index].image_url,
                fit: BoxFit.cover,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GalleryRoute(
                    imagesData: _detailPageModel.images,
                    index: index,
                  );
                }));
              });
        },
        childCount: _detailPageModel.images.length,
      ),
    );
  }

  bool isImageEmpty() =>
      _detailPageModel == null ||
      _detailPageModel.images == null ||
      _detailPageModel.images.isEmpty;

  SliverAppBar _buildSliverAppBar(Detail_page_model model) {
    return SliverAppBar(
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
    );
  }

  Widget _buildSliverFixedExtentList() {
    return new SliverFixedExtentList(
      itemExtent: 46.0,
      delegate:
          new SliverChildBuilderDelegate((BuildContext context, int index) {
        Detail_page_model model = _data[index];
        switch (model.type) {
          case 0:
            return DetailTitleCell(
              detailPageModel: model,
            );
            break;
          case 1:
            //创建列表项
            return DetailTextCell(
              detailPageModel: model,
            );
            break;
          default:
            //创建列表项
            return DetailTextCell(
              detailPageModel: _data[index],
            );
            break;
        }
      }, childCount: _data.length),
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
      handleData();
      return Container(
        color: Colors.white,
        child: _buildCustomScrollView(_detailPageModel),
      );
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }

  handleData() {
    _data.clear();
    if (_detailPageModel == null) return;
    bool hasDivider = false;
    if (_detailPageModel.images != null && _detailPageModel.images.isNotEmpty) {
      hasDivider = true;
    }

    Detail_page_model model = Detail_page_model();
    model.key = '基本资料';
    model.hasDivider = hasDivider;
    model.type = 0;
    _data.add(model);

    final int constellationInt =
        int.parse(getText(_detailPageModel.constellation.toString(), defaultString: '0'));
    if (constellationInt >= 0) {
      Detail_page_model constellation = Detail_page_model();
      constellation.key = '星座';
      constellation.value = constellationData[constellationInt];
      constellation.type = 1;
      _data.add(constellation);
    }

    final int educationInt = int.parse(getText(_detailPageModel.education.toString(), defaultString: '0'));
    if (educationInt >= 0) {
      Detail_page_model education = Detail_page_model();
      education.key = '教育程度';
      education.value = educationData[educationInt];
      education.type = 1;
      _data.add(education);
    }

    if (_detailPageModel.work_area_name != null &&
        _detailPageModel.work_area_name.isNotEmpty) {
      Detail_page_model workPlace = Detail_page_model();
      workPlace.key = '工作地';
      workPlace.value = _detailPageModel.work_area_name;
      workPlace.type = 1;
      _data.add(workPlace);
    }

    if (_detailPageModel.born_area_name != null &&
        _detailPageModel.born_area_name.isNotEmpty) {
      Detail_page_model model = Detail_page_model();
      model.key = '出生地(籍贯)';
      model.value = _detailPageModel.born_area_name;
      model.type = 1;
      _data.add(model);
    }

    if (_detailPageModel.marriage_status >= 0) {
      Detail_page_model model = Detail_page_model();
      model.key = '婚姻状况';
      model.value = marryState[_detailPageModel.marriage_status];
      model.type = 1;
      _data.add(model);
    }

    final int nationality = int.parse(
        getText(_detailPageModel.nationality.toString(), defaultString: '0'));
    if (nationality >= 0) {
      Detail_page_model model = Detail_page_model();
      model.key = '民族';
      model.value = nationState[nationality];
      model.type = 1;
      _data.add(model);
    }

    if (_detailPageModel.brother_state >= 0) {
      Detail_page_model model = Detail_page_model();
      model.key = '姊妹情况';
      model.value = brotherState[_detailPageModel.brother_state];
      model.type = 1;
      _data.add(model);
    }
  }
}
