import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/color_config.dart';
import 'package:xianglian_fluter/model/party_page_model.dart';
import 'package:xianglian_fluter/common/string_utils.dart';

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
            child: Container(
              height: 95,
              padding: EdgeInsets.only(
                left: 6,
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getText(resultsListBean.title),
                    style: TextStyle(fontSize: 16, color: Colors2.color_6),
                  ),
                  Padding(padding: EdgeInsets.only(top: 8.0)),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _buildDecoratedBox(
                                  resultsListBean.tag1, Colors2.color_7),
                              Padding(padding: EdgeInsets.only(left: 4.0)),
                              _buildDecoratedBox(
                                  resultsListBean.tag2, Colors2.color_8),
                              Padding(padding: EdgeInsets.only(left: 4.0)),
                              _buildDecoratedBox(
                                  resultsListBean.tag3, Colors2.color_9),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 8.0)),
                          Text(
                            getText(resultsListBean.sub_describe),
                            style: TextStyle(
                                fontSize: 12, color: Colors2.color_10),
                          )
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          getText(resultsListBean.price),
                          style:
                              TextStyle(fontSize: 18, color: Colors2.color_6),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecoratedBox(String text, Color color) {
    if (text == null) {
      return Text('');
    } else {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(2.0, 1.0, 2.0, 1.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ),
      );
    }
  }
}
