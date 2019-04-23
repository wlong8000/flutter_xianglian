class Detail_page_model {
  /**
   * username : "root2"
   * last_login : "2018-07-02T20:55:34.126515+08:00"
   * date_joined : "2018-07-02T20:48:19.603424+08:00"
   * nickname : "Dodd's"
   * birthday : "1973-04-04"
   * gender : "female"
   * nationality : ""
   * work_area_name : "通州区"
   * born_area_name : "正蓝旗"
   * relationship_desc : "有过一段失败的感情，所以希望找一个可以托付终身的人1"
   * mate_preference : "身高170以上 不抽烟不喝酒的男生"
   * person_intro : "大家好我是新同学 大家多多关照"
   * pic1 : "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554775498845&di=febc70635cf4ff321fae4b27d4c33d91&imgtype=0&src=http%3A%2F%2Fimg.taian.com%2Fforum%2F201405%2F24%2F094327h2tl3zkyz2imo2z2.jpg"
   * mobile : "15313433279"
   * is_staff : true
   * is_active : true
   * height : 173.0
   * weight : 39.0
   * income : 5.0
   * marriage_status : 3
   * career : 11
   * brother_state : 2
   * has_children : 1
   * has_car : 1
   * has_house : 1
   * id : 2
   * education : 4
   * black_user : 0
   * member_level : 0
   * constellation : 3
   * parent_work : 4
   * expect_marry_time : 2
   * images : [{"image_url":"http://ptw.youyuan.com/resize/photo/n/n/n/y/600/600/201807/21/19/00/1532170840448A422FD1.jpg"},{"image_url":"http://ptw.youyuan.com/resize/photo/n/n/n/y/600/600/201807/23/23/23/1532359424664AB73473_c.jpg"},{"image_url":"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1532607630269&di=1cdf6fef4764b13169e37a6cc223f547&imgtype=0&src=http%3A%2F%2Fs7.sinaimg.cn%2Fmw690%2F006LDoUHzy7auXtxWOG16%26690"}]
   */

  String username;
  String last_login;
  String date_joined;
  String nickname;
  String birthday;
  String gender;
  dynamic nationality;
  String work_area_name;
  String born_area_name;
  String relationship_desc;
  String mate_preference;
  String person_intro;
  String pic1;
  String mobile;
  bool is_staff;
  bool is_active;
  double height;
  double weight;
  double income;
  int marriage_status;
  dynamic career;
  int brother_state;
  int has_children;
  int has_car;
  int has_house;
  int id;
  int education;
  int black_user;
  int member_level;
  dynamic constellation;
  int parent_work;
  int expect_marry_time;
  List<ImagesListBean> images;

  static Detail_page_model fromMap(Map<String, dynamic> map) {
    Detail_page_model detail_page_model = new Detail_page_model();
    detail_page_model.username = map['username'];
    detail_page_model.last_login = map['last_login'];
    detail_page_model.date_joined = map['date_joined'];
    detail_page_model.nickname = map['nickname'];
    detail_page_model.birthday = map['birthday'];
    detail_page_model.gender = map['gender'];
    detail_page_model.nationality = map['nationality'];
    detail_page_model.work_area_name = map['work_area_name'];
    detail_page_model.born_area_name = map['born_area_name'];
    detail_page_model.relationship_desc = map['relationship_desc'];
    detail_page_model.mate_preference = map['mate_preference'];
    detail_page_model.person_intro = map['person_intro'];
    detail_page_model.pic1 = map['pic1'];
    detail_page_model.mobile = map['mobile'];
    detail_page_model.is_staff = map['is_staff'];
    detail_page_model.is_active = map['is_active'];
    detail_page_model.height = map['height'];
    detail_page_model.weight = map['weight'];
    detail_page_model.income = map['income'];
    detail_page_model.marriage_status = map['marriage_status'];
    detail_page_model.career = map['career'];
    detail_page_model.brother_state = map['brother_state'];
    detail_page_model.has_children = map['has_children'];
    detail_page_model.has_car = map['has_car'];
    detail_page_model.has_house = map['has_house'];
    detail_page_model.id = map['id'];
    detail_page_model.education = map['education'];
    detail_page_model.black_user = map['black_user'];
    detail_page_model.member_level = map['member_level'];
    detail_page_model.constellation = map['constellation'];
    detail_page_model.parent_work = map['parent_work'];
    detail_page_model.expect_marry_time = map['expect_marry_time'];
    detail_page_model.images = ImagesListBean.fromMapList(map['images']);
    return detail_page_model;
  }

  static List<Detail_page_model> fromMapList(dynamic mapList) {
    List<Detail_page_model> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ImagesListBean {
  /**
   * image_url : "http://ptw.youyuan.com/resize/photo/n/n/n/y/600/600/201807/21/19/00/1532170840448A422FD1.jpg"
   */

  String image_url;

  static ImagesListBean fromMap(Map<String, dynamic> map) {
    ImagesListBean imagesListBean = new ImagesListBean();
    imagesListBean.image_url = map['image_url'];
    return imagesListBean;
  }

  static List<ImagesListBean> fromMapList(dynamic mapList) {
    List<ImagesListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
