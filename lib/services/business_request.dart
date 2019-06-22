//业务请求封装
import 'dart:async';
import 'net_request.dart';
import '../config/service_url.dart';

Future getGlobal() async {
  return getRequest(servicePath['getConfig']);
}

Future getUsers(String url, {Map<String, dynamic> params}) async {
  return getRequest(url, params: params);
}

Future getUser({bool loadMore, String nextUrl, int id}) async {
  var url = servicePath['getUsers'] + "$id/";
  print('url is $id --------------- ' + url);
  return getRequest(url);
}

Future getParty([bool loadMore, String nextUrl]) async {
  var url;
  if (loadMore) {
    url = nextUrl;
  } else {
    url = servicePath['getParty'];
  }
  return getRequest(url);
}
