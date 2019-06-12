


class GlobalModel {

  /**
   * default_splash_img : "http://ptw.youyuan.com/resize/photo/n/n/n/y/600/600/201807/23/23/23/1532359424664AB73473_c.jpg"
   * contacts_wx : "微信号1:15313433271"
   * server_path : "http://wlong800.s1.natapp.cc/"
   * splash_time : 1
   * is_jump : 0
   */

  String default_splash_img;
  String contacts_wx;
  String server_path;
  int splash_time;
  int is_jump;


  static GlobalModel fromMap(Map<String, dynamic> map) {
    GlobalModel globalModel = new GlobalModel();
    globalModel.default_splash_img = map['default_splash_img'];
    globalModel.contacts_wx = map['contacts_wx'];
    globalModel.server_path = map['server_path'];
    globalModel.splash_time = map['splash_time'];
    globalModel.is_jump = map['is_jump'];
    return globalModel;
  }

  static List<GlobalModel> fromMapList(dynamic mapList) {
    List<GlobalModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
