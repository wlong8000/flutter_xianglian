import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/common/touch_callback.dart';
import 'package:xianglian_fluter/model/search_page_model.dart';
import 'package:xianglian_fluter/common/string_utils.dart';
import 'package:xianglian_fluter/common/utils.dart';
import 'package:xianglian_fluter/file/picker_data.dart';
import 'package:xianglian_fluter/file/province_data.dart';
import 'package:xianglian_fluter/pages/adapter/province_adapter.dart';

class SearchRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchRoute> {
  static const int typeAge = 0;
  static const int typeHeight = 1;
  static const int typeWorkPlace = 2;
  static const int typeHomeTown = 3;
  static const int typeCal = 4;
  List<SearchPageModel> _data = [];
  SearchPageModel _model = SearchPageModel();

  @override
  void initState() {
    super.initState();
    _data.clear();
    SearchPageModel ageModel = SearchPageModel();
    ageModel.type = typeAge;
    ageModel.name = '年龄';
    _data.add(ageModel);

    SearchPageModel heightModel = SearchPageModel();
    heightModel.type = typeHeight;
    heightModel.name = '身高(单位:cm)';
    _data.add(heightModel);

    SearchPageModel workPlaceModel = SearchPageModel();
    workPlaceModel.type = typeWorkPlace;
    workPlaceModel.name = '居住地(工作所在地)';
    _data.add(workPlaceModel);

//    SearchPageModel homeTownModel = SearchPageModel();
//    homeTownModel.type = typeHomeTown;
//    homeTownModel.name = '出生地(籍贯)';
//    _data.add(homeTownModel);

    SearchPageModel calModel = SearchPageModel();
    calModel.type = typeCal;
    calModel.name = '学历';
    _data.add(calModel);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text(String2.search, style: TextStyle(fontSize: FontSize2.app_bar_title_size)),
            centerTitle: true,
          ),
          preferredSize: Size.fromHeight(Size2.app_bar_height_size)),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _getItemCell(_data[index]);
            },
            itemCount: _data.length,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TouchCallBack(
                  child: _buildDecoratedBox(String2.reset, Colors2.color_1),
                  onPressed: () {
                    //todo
                  }),
              Padding(padding: EdgeInsets.only(left: 12)),
              TouchCallBack(
                  child: _buildDecoratedBox(String2.save, Colors.white,
                      bgColor: Colors2.color_1),
                  onPressed: () {
                    //todo
                    Navigator.of(context).pop(_model.toJson());
                  }),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 12))
        ],
      ),
    );
  }

  Widget _buildDecoratedBox(String text, Color color, {Color bgColor}) {
    if (text == null) {
      return Text('');
    } else {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(2.0),
          color: bgColor == null ? null : bgColor,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(getScreenWidth(context) / 6, 8.0,
              getScreenWidth(context) / 6, 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: color),
          ),
        ),
      );
    }
  }

  Widget _getItemCell(SearchPageModel model) {
    return TouchCallBack(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  model.name,
                  style: TextStyle(fontSize: 15, color: Colors2.color_6),
                )),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    getText(model.content, defaultString: '不限'),
                    style: TextStyle(fontSize: 14, color: Colors2.color_11),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Image.asset(
                  'images/icon_choose.png',
                  width: 10,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          switch (model.type) {
            case typeAge:
              showPickerNumber(context,
                  title: '年龄', type: model.type, begin: 18, end: 60);
              break;
            case typeHeight:
              showPickerNumber(context,
                  title: '身高(cm)', type: model.type, begin: 140, end: 210);
              break;
            case typeWorkPlace:
              showPickerModal(context, model.type);
              break;
            case typeHomeTown:
              showPickerModal(context, model.type);
              break;
            case typeCal:
              showPickerArray(context, model.type);
              break;
          }
        });
  }

  showPickerModal(BuildContext context, int type) {
    Picker(
        adapter: ProvinceAdapter<String>(
            pickerData: JsonDecoder().convert(ProvinceData)),
        changeToFirst: true,
        hideHeader: false,
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          List<String> list = picker.adapter.getSelectedValues();
          print(list);
          updateItem2(type, list[0], list[1]);
          String text = list[1].toString();
          text = text.substring(0,text.indexOf('-')-2);
          if (type == typeWorkPlace) {
            _model.workPlace = text;
          } else {
            _model.homeTown = text;
          }
          setState(() {});
        }).showModal(this.context); //_scaffoldKey.currentState);
  }

  showPickerNumber(BuildContext context,
      {int type, String title, int begin, int end}) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: begin, end: end),
          NumberPickerColumn(begin: begin + 1, end: end),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text(getText(title)),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          List<int> list = picker.getSelectedValues();
          print(value.toString());
          print(list);
          if (list[0] > list[1]) {
//            showToast('选择的区间不正确');
            return;
          }
          updateItem(type, list[0], list[1]);
          setState(() {});
        }).showDialog(context);
  }

  showPickerArray(BuildContext context, int type) {
    new Picker(
        adapter: PickerDataAdapter<String>(
            pickerdata: new JsonDecoder().convert(PickerData2), isArray: true),
        hideHeader: true,
        title: new Text("学历"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          _model.minCal = value[0];
          _model.maxCal = value[1];
          List<String> list = picker.getSelectedValues();
          print(list);
          updateItem(type, list[0], list[1], needSetData: false);
          setState(() {});
        }).showDialog(context);
  }

  updateItem(int type, min, max, {bool needSetData = true}) {
    for (int i = 0; i < _data.length; i++) {
      SearchPageModel pageModel = _data[i];
      if (pageModel.type == type) {
        pageModel.content = min.toString() + " - " + max.toString();
        if (needSetData) setData(type, min, max);
        break;
      }
    }
  }

  updateItem2(int type, l1, l2, {bool needSetData = true}) {
    for (int i = 0; i < _data.length; i++) {
      SearchPageModel pageModel = _data[i];
      if (pageModel.type == type) {
        String s1 = l1.substring(l1.indexOf('-') + 1);
        String s2 = l2.substring(l2.indexOf('-') + 1);
        pageModel.content = s1.toString() + "/" + s2.toString();
        break;
      }
    }
  }

  setData(int type, int min, int max) {
    switch (type) {
      case typeAge:
        _model.minAge = min;
        _model.maxAge = max;
        break;
      case typeHeight:
        _model.minHeight = min;
        _model.maxHeight = max;
        break;
      case typeWorkPlace:
        break;
      case typeHomeTown:
        break;
      case typeCal:
        break;
    }
  }
}
