//业务请求封装
import 'dart:async';
import 'package:flutter/services.dart';
import 'net_request.dart';
import '../config/service_url.dart';

var nativeRequestHeader;

//获取系统消息
Future getSystemMessage() async {
  if(nativeRequestHeader != null) { //判断是否已经有了header
    return getRequestAddNativeHeader(servicePath['getSystemInfo'], nativeRequestHeader);
  } else {
    //****************flutter主动调用原生方法****************//
    const communicateChannel =  MethodChannel('system_message');
    //异步执行调用原生方法，保持页面不卡住，因为调用原生的方法可能没实现会抛出异常，所以trycatch包住
    Future<void> _communicateFunction(flutterPara) async {
      print('Flutter Test Start');
      dynamic result;
      try {
        result = await communicateChannel.invokeMethod('getNativeRequestHeader');
      } on PlatformException {
        result = "error";
      }
      print('Flutter Test:' + result.toString());
      return getRequestAddNativeHeader(servicePath['getSystemInfo'], result);
    }
    return _communicateFunction('hahha');
  }
}


//获取系统消息
Future getSystemMessage2() async {

  //****************flutter主动调用原生方法****************//
  String _nativeCallBackValue = '等待原生传值';
  const communicateChannel =  MethodChannel('system_message');

  //异步执行调用原生方法，保持页面不卡住，因为调用原生的方法可能没实现会抛出异常，所以trycatch包住
  Future<void> _communicateFunction(flutterPara) async {

    var nativeHeaderMap = new Map();
    nativeHeaderMap = {
      'Authorization' : 'RSsBee8TJQoxTfBIrqnL765tffMjAKTlhdAKtHXafnuWTmCyXayWSyebXmMTZ6tR',
      'IDFA' : 'E1E9C3B8-9A6B-46CD-BA28-55F10F33F7A0',
      'IDFV' : '64F4671E-4141-4F3F-B6C8-DC634CA79B98',
      'UUID' : '@L/UV9EYdOnFC7O7c3ZXE10XKeq1JFjKes8zdu2UR96SeuIrN0wtOIehLKklP0JuH8FzGrhqfdVY=',
      '"User-Agent' : 'Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 NewsApp/1.3.3 NetType/NA Technology/Wifi (iPhone; iOS 12.2; Scale/3.00) (modelIdentifier/iPhone8,2 )',
      'action' : 'click',
      'api-key' : 'dongqiudi.com',
      'device-tag' : '',
      'dqd_referer' : '',
      'encrypt-id' : 'dQ==',
      'fingerprint-shumei' : '20180312185514d09b68c147df7fdf325a8f0ea2ea3a90019e5a3c878e49f6',
      'lang' : 'zh-cn',
      'page' : '',
      'positon' : '',
      'sign' : 'bhM6UB0rvJwLWPWnH0HkUfZlWDjoHN+FKDGe348bgxs=',
      'time' : '1553657912',
    };

    return getRequestAddNativeHeader(servicePath['getSystemInfo'], nativeHeaderMap);

//    try {
//      //原生方法名为callNativeMethond,flutterPara为flutter调用原生方法传入的参数，await等待方法执行
//      final result = await communicateChannel.invokeMethod(
//          'getNativeRequestHeader', flutterPara);
//      //如果原生方法执行回调传值给flutter，那下面的代码才会被执行
//      _nativeCallBackValue = result;
//      return getRequestAddNativeHeader(servicePath['getSystemInfo'], _nativeCallBackValue);
//    } on PlatformException catch (e) {
//      //抛出异常
//      //flutter: PlatformException(001, 进入异常处理, 进入flutter的trycatch方法的catch方法)
//      print(e);
//    }

  }

  return _communicateFunction('hahha');
}


//获取更多系统消息
Future loadMoreSystemMessage(url) async {
  if(url == null) {
    return '';
  }

  if(nativeRequestHeader != null) { //判断是否已经有了header
    return getRequestAddNativeHeader(url, nativeRequestHeader);
  } else {
    //****************flutter主动调用原生方法****************//
    const communicateChannel =  MethodChannel('system_message');
    //异步执行调用原生方法，保持页面不卡住，因为调用原生的方法可能没实现会抛出异常，所以trycatch包住
    Future<void> _communicateFunction(flutterPara) async {
      print('Flutter Test Start');
      dynamic result;
      try {
        result = await communicateChannel.invokeMethod('getNativeRequestHeader');
      } on PlatformException {
        result = "error";
      }
      print('Flutter Test:' + result.toString());
      return getRequestAddNativeHeader(url, result);
    }
    return _communicateFunction('hahha');
  }
}