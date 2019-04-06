import 'package:shared_preferences/shared_preferences.dart';

add(String key, String modelStr) async {
  Future<SharedPreferences> spFuture = SharedPreferences.getInstance();
  spFuture.then((value) {
    value.setString(key, modelStr);
    print("save 数据成功");
  });
}

search(String key, Function callback(v)) async {
  Future<SharedPreferences> spFuture = SharedPreferences.getInstance();
  spFuture.then((value) {
    print("search 数据成功");
    String j = value.getString(key);
    callback(j);
  });
}
