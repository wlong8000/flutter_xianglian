import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/color_config.dart';
import 'package:xianglian_fluter/model/party_page_model.dart';

class PartyCell extends StatelessWidget {
  final ResultsListBean resultsListBean;

  const PartyCell({Key key, this.resultsListBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border(bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
      ),
      child: new Row(
        children: [
          Image.network(
            resultsListBean.url,
            width: 130,
            height: 90,
            fit: BoxFit.cover,
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  resultsListBean.title,
                  style: TextStyle(fontSize: 15, color: Colors2.color_6),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('推荐'),
                            Text('认证'),
                            Text('免费'),
                          ],
                        ),
                        Text('08/22 周一 北京')
                      ],
                    ),
                    Text(
                      '50',
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
