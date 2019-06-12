

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:xianglian_fluter/config/const_config.dart';

/// 经典(默认)底部视图
class DQRefreshFooter extends RefreshFooter {
  // 提示加载文字
  final String loadText;
  // 准备加载文字
  final String loadReadyText;
  // 正在加载文字
  final String loadingText;
  // 没有更多文字
  final String noMoreText;
  // 刷新完成文字
  final String loadedText;
  // 背景颜色
  final Color bgColor;
  // 字体颜色
  final Color textColor;
  // 触发加载的高度
  final double loadHeight;
  // 是否浮动
  final bool isFloat;
  // 显示额外信息(默认为时间)
  final bool showMore;
  // 更多信息
  final String moreInfo;
  // 更多信息文字颜色
  final Color moreInfoColor;

  // 构造函数
  DQRefreshFooter({
    GlobalKey<RefreshFooterState> key,
    this.loadText: "下拉加载更多",
    this.loadReadyText: "松开立即加载",
    this.loadingText: "加载中...",
    this.loadedText: "加载完毕",
    this.noMoreText: "没有更多数据了",
    this.bgColor: Colors.white,
    this.textColor: const Color(0x82000000),
    this.moreInfoColor: const Color(0x82000000),
    this.loadHeight: 70.0,
    this.isFloat: false,
    this.showMore: false,
    this.moreInfo: "Loaded at %T"
  }):super(
      key: key,
      loadHeight: loadHeight,
      isFloat: isFloat
  );

  @override
  DQRefreshFooterState createState() => DQRefreshFooterState();
}
class DQRefreshFooterState extends RefreshFooterState<DQRefreshFooter> {
  // 显示的文字
  String _showText;
  // 更新时间
  DateTime _dateTime;

  // 初始化操作
  @override
  void initState() {
    super.initState();
    _showText = widget.loadText;
    _dateTime = DateTime.now();
  }

  // 准备加载回调
  @override
  Future onLoadReady() async {
    super.onLoadReady();
    setState(() {
      _showText = widget.loadReadyText;
    });
  }
  // 正在加载回调
  @override
  Future onLoading() async {
    super.onLoading();
    setState(() {
      _showText = widget.loadingText;
    });
  }
  // 加载完成回调
  @override
  Future onLoaded() async {
    super.onLoaded();
    setState(() {
      _dateTime = DateTime.now();
      _showText = widget.loadedText;
    });
  }
  // 没有更多数据回调
  @override
  Future onNoMore() async {
    super.onNoMore();
    setState(() {
      _dateTime = DateTime.now();
      _showText = widget.noMoreText;
    });
  }
  // 加载恢复回调
  @override
  Future onLoadRestore() async {
    super.onLoadRestore();
    setState(() {
      _showText = widget.loadText;
    });
  }
  // 加载结束回调
  @override
  Future onLoadEnd() async {
    super.onLoadEnd();
    setState(() {
      _showText = widget.loadText;
    });
  }

  // 获取更多信息
  String _getMoreInfo() {
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return widget.moreInfo.replaceAll("%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  @override
  Widget build(BuildContext context) {
    return new Container( //上拉加载布局
      color: widget.bgColor,
      height: this.height,
      child: ListView(
        children: <Widget>[
          Container(
            height: this.height > 45.0 ? this.height : 45.0,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded (
                  flex: 1,
                  child: new Container(
                    alignment: Alignment.centerRight,
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        this.refreshFooterStatus == RefreshFooterStatus.NO_LOAD ? Icon(
                          Icons.arrow_upward,
                          color: widget.textColor,
                        ): Container(),
                        this.refreshFooterStatus == RefreshFooterStatus.LOADING ? new Align(
                          alignment: Alignment.centerLeft,
                          child: new Container(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation(widget.textColor),
                            ),
                          ),
                        ): Container(),
                        this.refreshFooterStatus == RefreshFooterStatus.LOAD_READY ? Icon(
                          Icons.arrow_downward,
                          color: widget.textColor,
                        ): Container(),
                        this.refreshFooterStatus == RefreshFooterStatus.LOADED ? Icon(
                          Icons.done,
                          color: widget.textColor,
                        ): Container(),
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
                        new Text(_showText,
                          style: new TextStyle(
                              color: widget.textColor,
                              fontSize: FontSize2.refresh_size,
                          ),
                        ),
                        Container(
                          height: 2.0,
                        ),
                        widget.showMore ? new Text(_getMoreInfo(),
                          style: new TextStyle(
                              color: widget.moreInfoColor,
                              fontSize: FontSize2.refresh_size,
                          ),
                        ) : Container(),
                      ],
                    )
                ),
                Expanded (
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