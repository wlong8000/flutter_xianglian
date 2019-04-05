


class Global_model {

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

  static Global_model fromMap(Map<String, dynamic> map) {
    Global_model global_model = new Global_model();
    global_model.default_splash_img = map['default_splash_img'];
    global_model.contacts_wx = map['contacts_wx'];
    global_model.server_path = map['server_path'];
    global_model.splash_time = map['splash_time'];
    global_model.is_jump = map['is_jump'];
    return global_model;
  }

  static List<Global_model> fromMapList(dynamic mapList) {
    List<Global_model> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

}
