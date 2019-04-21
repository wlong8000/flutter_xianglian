import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:xianglian_fluter/config/color_config.dart';
import 'package:xianglian_fluter/common/touch_callback.dart';
import 'package:xianglian_fluter/common/toaster.dart';
import 'package:xianglian_fluter/model/search_page_model.dart';
import 'package:xianglian_fluter/common/string_utils.dart';

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
    heightModel.name = '身高';
    _data.add(heightModel);

    SearchPageModel workPlaceModel = SearchPageModel();
    workPlaceModel.type = typeWorkPlace;
    workPlaceModel.name = '居住地';
    _data.add(workPlaceModel);

    SearchPageModel homeTownModel = SearchPageModel();
    homeTownModel.type = typeHomeTown;
    homeTownModel.name = '家乡';
    _data.add(homeTownModel);

    SearchPageModel calModel = SearchPageModel();
    calModel.type = typeCal;
    calModel.name = '学历';
    _data.add(calModel);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        centerTitle: true,
        actions: <Widget>[
          TouchCallBack(
              child: Container(
                padding: EdgeInsets.only(right: 12),
                child: Text(
                  '确定',
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.center,
              ),
              onPressed: () {
                print('确定');
                Navigator.of(context)
                    .pop({"lat": 43.821757, "long": -79.226392});
              }),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _getItemCell(_data[index]);
        },
        itemCount: _data.length,
      ),
    );
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
                  style: TextStyle(fontSize: 16, color: Colors2.color_6),
                )),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    getText(model.content),
                    style: TextStyle(fontSize: 14, color: Colors2.color_6),
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
              break;
            case typeHeight:
              showPickerNumber(context, model.type);
              break;
            case typeWorkPlace:
              break;
            case typeHomeTown:
              break;
            case typeCal:
              break;
          }
        });
  }

  showPickerNumber(BuildContext context, int type) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 140, end: 210),
          NumberPickerColumn(begin: 141, end: 210),
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
        title: new Text("身高(cm)"),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          List<int> list = picker.getSelectedValues();
          print(value.toString());
          print(list);
          if (list[0] > list[1]) {
            showToast('选择的区间不正确');
            return;
          }
          String s = list[0].toString() + ' - ' + list[1].toString();
          updateItem(type, s);
          setState(() {});
        }).showDialog(context);
  }

  void updateItem(int type, String content) {
    for (int i = 0; i < _data.length; i++) {
      SearchPageModel pageModel = _data[i];
      if (pageModel.type == type) {
        pageModel.content = content;
        break;
      }
    }
  }
}
