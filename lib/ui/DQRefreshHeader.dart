import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/config/const_config.dart';

class DQRefreshHeader extends RefreshHeader {
  // 提示刷新文字
  final String refreshText;

  // 准备刷新文字
  final String refreshReadyText;

  // 正在刷新文字
  final String refreshingText;

  // 刷新完成文字
  final String refreshedText;

  // 背景颜色
  final Color bgColor;

  // 字体颜色
  final Color textColor;

  // 触发刷新的高度
  final double refreshHeight;

  // 是否浮动
  final bool isFloat;

  // 显示额外信息(默认为时间)
  final bool showMore;

  // 更多信息
  final String moreInfo;

  // 更多信息文字颜色
  final Color moreInfoColor;

  // 构造函数
  DQRefreshHeader(
      {@required GlobalKey<RefreshHeaderState> key,
      this.refreshText: "下拉可以刷新",
      this.refreshReadyText: "松开立即刷新",
      this.refreshingText: "上篮正在刷新",
      this.refreshedText: "完成刷新",
      this.bgColor: Colors.white,
      this.textColor: const Color(0x82000000),
      this.moreInfoColor: const Color(0x82000000),
      this.refreshHeight: 70.0,
      this.isFloat: false,
      this.showMore: false,
      this.moreInfo: "最后更新 %T"})
      : super(key: key, refreshHeight: refreshHeight, isFloat: isFloat);

  @override
  DQRefreshHeaderState createState() => DQRefreshHeaderState();
}

class DQRefreshHeaderState extends RefreshHeaderState<DQRefreshHeader> {
  // 显示的文字
  String _showText;

  // 更新时间
  DateTime _dateTime;

  // 初始化操作
  @override
  void initState() {
    super.initState();
    _showText = widget.refreshText;
    _dateTime = DateTime.now();
  }

  // 准备刷新回调
  @override
  Future onRefreshReady() async {
    super.onRefreshReady();
    setState(() {
      _showText = widget.refreshReadyText;
    });
  }

  // 正在刷新回调
  @override
  Future onRefreshing() async {
    super.onRefreshing();
    setState(() {
      _showText = widget.refreshingText;
    });
  }

  // 完成刷新回调
  @override
  Future onRefreshed() async {
    super.onRefreshed();
    setState(() {
      _dateTime = DateTime.now();
      _showText = widget.refreshedText;
    });
  }

  // 刷新恢复回调
  @override
  Future onRefreshRestore() async {
    super.onRefreshRestore();
    setState(() {
      _showText = widget.refreshText;
    });
  }

  // 刷新结束回调
  @override
  Future onRefreshEnd() async {
    super.onRefreshEnd();
    setState(() {
      _showText = widget.refreshText;
    });
  }

  // 获取更多信息
  String _getMoreInfo() {
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return widget.moreInfo
        .replaceAll("%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  // 下拉刷新布局
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: widget.bgColor,
      height: this.height,
      child: ListView(
        children: <Widget>[
          Container(
            height: this.height > 45.0 ? this.height : 45.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        this.refreshHeaderStatus ==
                                RefreshHeaderStatus.NO_REFRESH
                            ? Icon(
                                Icons.arrow_downward,
                                color: widget.textColor,
                              )
                            : Container(),
                        this.refreshHeaderStatus ==
                                RefreshHeaderStatus.REFRESHING
                            ? new Align(
                                alignment: Alignment.centerLeft,
                                child: new Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation(
                                        widget.textColor),
                                  ),
                                ),
                              )
                            : new Container(),
                        this.refreshHeaderStatus ==
                                RefreshHeaderStatus.REFRESH_READY
                            ? Icon(
                                Icons.arrow_upward,
                                color: widget.textColor,
                              )
                            : Container(),
                        this.refreshHeaderStatus ==
                                RefreshHeaderStatus.REFRESHED
                            ? Icon(
                                Icons.done,
                                color: widget.textColor,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Container(
                    width: 150.0,
                    height: double.infinity,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          _showText,
                          style: new TextStyle(
                            color: widget.textColor,
                            fontSize: FontSize2.refresh_size,
                          ),
                        ),
                        Container(
                          height: 2.0,
                        ),
                        widget.showMore
                            ? new Text(
                                _getMoreInfo(),
                                style: new TextStyle(
                                  color: widget.moreInfoColor,
                                  fontSize: FontSize2.refresh_size,
                                ),
                              )
                            : Container(),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Container(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
