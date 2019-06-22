import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:xianglian_fluter/config/service_url.dart';
import 'package:xianglian_fluter/model/main_page_model.dart';
import 'package:xianglian_fluter/services/business_request.dart';
import 'package:xianglian_fluter/common/data_callback.dart';

class MainPageViewModel {
  final DataCallback dataCallBack;
  bool loadMore;
  String nextUrl;

  MainPageViewModel(this.dataCallBack);

  Future getData(bool loadMore, {bool showLoading = false}) async {
    this.loadMore = loadMore;
    if (showLoading) dataCallBack(ConnectionState.waiting, null);
    String url = loadMore ? nextUrl : servicePath['getUsers'];
    Future future = getUsers(url);
    future.then((result) {
      var resultString = result.toString();
      debugPrint(resultString);
      var data = json.decode(resultString);

      MainPageModel newModel = MainPageModel.fromMap(data);
      List<ResultsListBean> list = newModel.results;

      this.nextUrl = newModel.next;
      print(">>> next... $nextUrl");
      dataCallBack(ConnectionState.done, list);
    });
  }
}
