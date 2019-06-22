import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/const_config.dart';

/// 标题栏
class XLPreferredSize extends PreferredSize {
  final String title;
  final bool leading;

  XLPreferredSize(this.title, {this.leading = false});

  @override
  Size get preferredSize => Size.fromHeight(Size2.app_bar_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: FontSize2.app_bar_title_size),
      ),
      centerTitle: true,
      leading: _buildLeadingButton(context),
    );
  }

  Widget _buildLeadingButton(BuildContext context) {
    if (!leading) return Text('');
    return IconButton(
      icon: new Image.asset('images/icon_back_white.png'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class LoadMoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
                width: 23,
                height: 23,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                '加载中...',
                style: TextStyle(fontSize: 14),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
      color: Colors.white70,
    );
  }
}

class LoadingKit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ErrorKit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('网络错误，请重试'),
    );
  }
}
