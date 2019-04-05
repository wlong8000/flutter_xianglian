import 'package:flutter/material.dart';

class TouchCallBack extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isfeed;
  final Color background;

  TouchCallBack({Key key,
    @required this.child,
    @required this.onPressed,
    this.isfeed: true,
    this.background,
  }) :super(key: key);

  @override
  TouchState createState() => TouchState();
}


class TouchState extends State<TouchCallBack> {
  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        color: color,
        child: widget.child,
      ),
      onTap: widget.onPressed,
      onPanDown: (d) {
        print("onPanDown");
        if (widget.isfeed == false) return;
        setState(() {
          color = widget.background;
        });
      },
      onPanCancel: () {
        print("onPanCancel");
        setState(() {
          color = Colors.transparent;
        });
      },
    );
  }

}