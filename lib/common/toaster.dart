import 'package:fluttertoast/fluttertoast.dart';
import 'package:xianglian_fluter/config/const_config.dart';

void showToast(String toast) {
  Fluttertoast.showToast(
    msg: toast,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIos: 1,
    backgroundColor: Colors2.color_toaster,
  );
}
