import 'package:flutter/material.dart';
import 'package:xianglian_fluter/config/const_config.dart';
import 'package:xianglian_fluter/model/images_model.dart';
import 'package:xianglian_fluter/common/widget_utils.dart';

class GalleryRoute extends StatefulWidget {
  final List<ImagesListBean> imagesData;
  final int index;

  const GalleryRoute({Key key, this.imagesData, this.index}) : super(key: key);

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GalleryPage();
  }
}

class _GalleryPage extends State<GalleryRoute> {
  int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Stack(
        ///方式一:(double dx, double dy) 0.5代码x轴居中，1代表在屏幕最下边，0.95靠上一点
        alignment: const FractionalOffset(0.5, 0.95),
        children: <Widget>[
          PageView.builder(
            controller: PageController(initialPage: widget.index),
            onPageChanged: (int index) {
              print('===========> $index');
              setState(() {
                _pageIndex = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return _buildImage(widget.imagesData[index]);
            },
            itemCount: widget.imagesData.length,
          ),
          Positioned(
              child: buildDecoratedBox(
                  text: String2.save,
                  textSize: 15,
                  textColor: Colors.white,
                  borderColor: Colors2.color_1,
                  radius: 2.0,
                  plr: 16.0,
                  ptm: 8.0,
                  solidColor: Colors2.color_1)),
          Positioned(
              right: 12,
              bottom: 12,
              child: Text(
                (_pageIndex + 1).toString() +
                    "/" +
                    widget.imagesData.length.toString(),
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  Image _buildImage(ImagesListBean model) => Image.network(model.image_url);
}
