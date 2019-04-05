//业务请求封装
import 'dart:async';
import 'net_request.dart';
import '../config/service_url.dart';

var nativeRequestHeader;

Future getGlobal() async {
  return getRequest(servicePath['getConfig']);
}
