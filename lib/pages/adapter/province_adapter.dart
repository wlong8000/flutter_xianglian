import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_picker/Picker.dart';

const bool __printDebug = false;

class ProvinceAdapter<T> extends PickerAdapter<T> {
  List<PickerItem<T>> data;
  List<PickerItem<dynamic>> _datas;
  int _maxLevel = -1;
  final bool isArray;

  ProvinceAdapter({List pickerData, this.data, this.isArray = false}) {
    _parseData(pickerData);
  }

  @override
  bool getIsLinkage() {
    return !isArray;
  }

  void _parseData(final List pickerData) {
    if (pickerData != null &&
        pickerData.length > 0 &&
        (data == null || data.length == 0)) {
      if (data == null) data = new List<PickerItem<T>>();
      if (isArray) {
        _parseArrayPickerDataItem(pickerData, data);
      } else {
        _parsePickerDataItem(pickerData, data);
      }
    }
  }

  _parseArrayPickerDataItem(List pickerData, List<PickerItem> data) {
    if (pickerData == null) return;
    for (int i = 0; i < pickerData.length; i++) {
      var v = pickerData[i];
      if (!(v is List)) continue;
      List lv = v;
      if (lv.length == 0) continue;

      PickerItem item = new PickerItem<T>(children: List<PickerItem<T>>());
      data.add(item);

      for (int j = 0; j < lv.length; j++) {
        var o = lv[j];
        if (o is T) {
          item.children.add(new PickerItem<T>(value: o));
        } else if (T == String) {
          String _v = o.toString();
          item.children.add(new PickerItem<T>(value: _v as T));
        }
      }
    }
    if (__printDebug) print("data.length: ${data.length}");
  }

  _parsePickerDataItem(List pickerData, List<PickerItem> data) {
    if (pickerData == null) return;
    for (int i = 0; i < pickerData.length; i++) {
      var item = pickerData[i];
      if (item is T) {
        data.add(new PickerItem<T>(value: item));
      } else if (item is Map) {
        final Map map = item;
        if (map.length == 0) continue;

        List<T> _mapList = map.keys.toList();
        for (int j = 0; j < _mapList.length; j++) {
          var _o = map[_mapList[j]];
          if (_o is List && _o.length > 0) {
            List<PickerItem> _children = new List<PickerItem<T>>();
            //print('add: ${data.runtimeType.toString()}');
            data.add(
                new PickerItem<T>(value: map[_mapList[0]] + "-" + map[_mapList[1]], children: _children));
            _parsePickerDataItem(_o, _children);
          }
        }
      } else if (T == String && !(item is List)) {
        String _v = item.toString();
        //print('add: $_v');
        data.add(new PickerItem<T>(value: _v as T));
      }
    }
  }

  void setColumn(int index) {
    if (isArray) {
      if (__printDebug) print("index: $index");
      if (index + 1 < data.length)
        _datas = data[index + 1].children;
      else
        _datas = null;
      return;
    }
    if (index < 0)
      _datas = data;
    else {
      int select = picker.selecteds[index];
      if (_datas != null && _datas.length > select)
        _datas = _datas[select].children;
      else
        _datas = null;
    }
  }

  @override
  int getLength() {
    return _datas == null ? 0 : _datas.length;
  }

  @override
  getMaxLevel() {
    if (_maxLevel == -1) _checkPickerDataLevel(data, 1);
    return _maxLevel;
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    final PickerItem item = _datas[index];
    if (item.text != null) {
      return item.text;
    }
    String text = item.value.toString();
    return makeText(
        item.text, item.text != null ? null : text.substring(text.indexOf('-') + 1));
  }

  @override
  void initSelects() {
    if (picker.selecteds == null || picker.selecteds.length == 0) {
      if (picker.selecteds == null) picker.selecteds = new List<int>();
      for (int i = 0; i < _maxLevel; i++) picker.selecteds.add(0);
    }
  }

  @override
  List<T> getSelectedValues() {
    List<T> _items = [];
    if (picker.selecteds != null) {
      if (isArray) {
        for (int i = 0; i < picker.selecteds.length; i++) {
          int j = picker.selecteds[i];
          if (j < 0 || data[i].children == null || j >= data[i].children.length)
            break;
          _items.add(data[i].children[j].value);
        }
      } else {
        List<PickerItem<dynamic>> datas = data;
        for (int i = 0; i < picker.selecteds.length; i++) {
          int j = picker.selecteds[i];
          if (j < 0 || j >= datas.length) break;
          _items.add(datas[j].value);
          datas = datas[j].children;
          if (datas == null || datas.length == 0) break;
        }
      }
    }
    return _items;
  }

  _checkPickerDataLevel(List<PickerItem> data, int level) {
    if (data == null) return;
    if (isArray) {
      _maxLevel = data.length;
      return;
    }
    for (int i = 0; i < data.length; i++) {
      if (data[i].children != null && data[i].children.length > 0)
        _checkPickerDataLevel(data[i].children, level + 1);
    }
    if (_maxLevel < level) _maxLevel = level;
  }
}
