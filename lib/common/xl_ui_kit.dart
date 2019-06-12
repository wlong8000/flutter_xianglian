import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
