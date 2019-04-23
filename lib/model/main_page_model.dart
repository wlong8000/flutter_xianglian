class Main_page_model {
  /**
   * next : "http://127.0.0.1:8000/users/?format=json&page=2"
   * count : 11
   * results : [{"nickname":null,"birthday":"1988-06-01","gender":"male","height":159,"weight":39,"nationality":0,"marriage_status":0,"work_area_name":"巴彦淖尔市","born_area_name":"黄冈市","career":3,"income":-1,"brother_state":0,"person_intro":null,"pic1":"http://pbja57owd.bkt.clouddn.com/2018/08/04/22/18/59/d6f6b0e7d1b236c9c5e00e7a4d8bd755","id":49,"education":1,"username":"西安民工","is_top":0,"position":0,"black_user":0,"member_level":0,"member_end_date":null,"mobile":"15863985652","constellation":4,"parent_work":4,"expect_marry_time":1},{"nickname":null,"birthday":"1972-01-01","gender":"female","height":155,"weight":50,"nationality":0,"marriage_status":1,"work_area_name":"北京市","born_area_name":"广元市","career":11,"income":5,"brother_state":0,"person_intro":null,"pic1":"http://pbja57owd.bkt.clouddn.com/2018/08/04/11/59/55/79bb445526ebb14bb28389a71babdf4f","id":45,"education":4,"username":"admin1232","is_top":0,"position":0,"black_user":0,"member_level":0,"member_end_date":null,"mobile":"15313433552","constellation":11,"parent_work":0,"expect_marry_time":1},{"nickname":null,"birthday":"1973-03-01","gender":"female","height":171,"weight":49,"nationality":1,"marriage_status":2,"work_area_name":"海南","born_area_name":"鄂州市","career":3,"income":5,"brother_state":0,"person_intro":null,"pic1":"http://pbja57owd.bkt.clouddn.com/2018/08/03/23/04/42/c4a7bfd85bd41efcc0ec4850d0470a75","id":44,"education":4,"username":"rootfgd","is_top":0,"position":0,"black_user":0,"member_level":0,"member_end_date":null,"mobile":"15313433558","constellation":11,"parent_work":1,"expect_marry_time":2},{"nickname":null,"birthday":"1985-01-01","gender":"female","height":164,"weight":49,"nationality":1,"marriage_status":0,"work_area_name":"黄冈市","born_area_name":"北京市","career":1,"income":3,"brother_state":1,"person_intro":null,"pic1":"http://pbja57owd.bkt.clouddn.com/2018/08/03/22/52/56/e6c35b8d40d1708153400943a8682b92","id":43,"education":2,"username":"rootg","is_top":0,"position":0,"black_user":0,"member_level":0,"member_end_date":null,"mobile":"15313433555","constellation":2,"parent_work":2,"expect_marry_time":1},{"nickname":null,"birthday":"1986-01-01","gender":"female","height":182,"weight":38,"nationality":1,"marriage_status":1,"work_area_name":"北京市","born_area_name":"大同市","career":1,"income":2,"brother_state":2,"person_intro":null,"pic1":"http://pbja57owd.bkt.clouddn.com/2018/08/03/10/30/50/145e192914647f88d4934211881d9458","id":36,"education":3,"username":"roota","is_top":0,"position":0,"black_user":0,"member_level":0,"member_end_date":null,"mobile":"15313433594","constellation":10,"parent_work":1,"expect_marry_time":1}]
   */

  String next;
  int count;
  List<ResultsListBean> results;

  static Main_page_model fromMap(Map<String, dynamic> map) {
    Main_page_model main_page_model = new Main_page_model();
    main_page_model.next = map['next'];
    main_page_model.count = map['count'];
    main_page_model.results = ResultsListBean.fromMapList(map['results']);
    return main_page_model;
  }

  static List<Main_page_model> fromMapList(dynamic mapList) {
    List<Main_page_model> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ResultsListBean {
  /**
   * birthday : "1988-06-01"
   * gender : "male"
   * work_area_name : "巴彦淖尔市"
   * born_area_name : "黄冈市"
   * pic1 : "http://pbja57owd.bkt.clouddn.com/2018/08/04/22/18/59/d6f6b0e7d1b236c9c5e00e7a4d8bd755"
   * username : "西安民工"
   * mobile : "15863985652"
   * height : 159
   * weight : 39
   * nationality : 0
   * marriage_status : 0
   * career : 3
   * income : -1
   * brother_state : 0
   * id : 49
   * education : 1
   * is_top : 0
   * position : 0
   * black_user : 0
   * member_level : 0
   * constellation : 4
   * parent_work : 4
   * expect_marry_time : 1
   */

  String birthday;
  String gender;
  String work_area_name;
  String born_area_name;
  String pic1;
  String username;
  String mobile;
  double height;
  double weight;
  dynamic nationality;
  int marriage_status;
  dynamic career;
  double income;
  int brother_state;
  int id;
  int education;
  int is_top;
  int position;
  int black_user;
  int member_level;
  dynamic constellation;
  int parent_work;
  int expect_marry_time;
  String person_intro;

  static ResultsListBean fromMap(Map<String, dynamic> map) {
    ResultsListBean resultsListBean = new ResultsListBean();
    resultsListBean.birthday = map['birthday'];
    resultsListBean.gender = map['gender'];
    resultsListBean.work_area_name = map['work_area_name'];
    resultsListBean.born_area_name = map['born_area_name'];
    resultsListBean.pic1 = map['pic1'];
    resultsListBean.username = map['username'];
    resultsListBean.mobile = map['mobile'];
    resultsListBean.height = map['height'];
    resultsListBean.weight = map['weight'];
    resultsListBean.nationality = map['nationality'];
    resultsListBean.marriage_status = map['marriage_status'];
    resultsListBean.career = map['career'];
    resultsListBean.income = map['income'];
    resultsListBean.brother_state = map['brother_state'];
    resultsListBean.id = map['id'];
    resultsListBean.education = map['education'];
    resultsListBean.is_top = map['is_top'];
    resultsListBean.position = map['position'];
    resultsListBean.black_user = map['black_user'];
    resultsListBean.member_level = map['member_level'];
    resultsListBean.constellation = map['constellation'];
    resultsListBean.parent_work = map['parent_work'];
    resultsListBean.expect_marry_time = map['expect_marry_time'];
    resultsListBean.person_intro = map['person_intro'];
    return resultsListBean;
  }

  static List<ResultsListBean> fromMapList(dynamic mapList) {
    List<ResultsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
