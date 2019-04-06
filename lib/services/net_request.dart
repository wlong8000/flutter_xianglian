//网络请求基础封装
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import '../config/service_url.dart';

//Post请求
//Dart中的可选参数，直接使用“{}”(大括号)就可以了。可选参数在调用的时候必须使用paramName:value的形式。
Future postRequest(url, {formData}) async {
  try {
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    Response response;
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('LeeGof : 后端接口出现异常，请检测代码和服务器情况');
    }
  } catch (e) {
    return print('LeeGof : ERROR:======>${e}');
  }
}

//Get请求
Future getRequest(url, {String header, Map<String, String> params}) async {
  try {
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/json, text/javascript");
    Response response;
    if (params == null) {
      response = await dio.get(url);
    } else {
      response = await dio.get(url, queryParameters: params);
    }
    if (response.statusCode == 200) {
      return json.encode(response.data);
    } else {
      throw Exception('LeeGof : 后端接口出现异常，请检测代码和服务器情况');
    }
  } catch (e) {
    return print('LeeGof : ERROR:======>${e}');
  }
}
