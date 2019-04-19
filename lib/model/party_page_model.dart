class Party_page_model {
  /**
   * count : 7
   * results : [{"id":2,"title":"第二次相亲大会","theme":"相亲","content":"TI青年","url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":"上海","nick_name":"大虫","place_detail":"恒大路11号","meet_time":null,"mobile":"15313344323","sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null},{"id":3,"title":"【北京场】享恋第一次相亲聚会报名现在开始","theme":"【北京场】享恋第一次相亲聚会报名现在开始","content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":"北京","nick_name":"大虫","place_detail":"大望路","meet_time":null,"mobile":"15313433271","sub_describe":"08/22 周一 北京海淀","price":"￥ 50","tag1":"推荐","tag2":"认证","tag3":"免费","expire_time":null},{"id":4,"title":null,"theme":null,"content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":null,"nick_name":null,"place_detail":null,"meet_time":null,"mobile":null,"sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null},{"id":5,"title":null,"theme":null,"content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":null,"nick_name":null,"place_detail":null,"meet_time":null,"mobile":null,"sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null},{"id":6,"title":null,"theme":null,"content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":null,"nick_name":null,"place_detail":null,"meet_time":null,"mobile":null,"sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null},{"id":7,"title":null,"theme":null,"content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":null,"nick_name":null,"place_detail":null,"meet_time":null,"mobile":null,"sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null},{"id":8,"title":null,"theme":null,"content":null,"url":"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg","city":null,"nick_name":null,"place_detail":null,"meet_time":null,"mobile":null,"sub_describe":null,"price":null,"tag1":null,"tag2":null,"tag3":null,"expire_time":null}]
   */

  int count;
  List<ResultsListBean> results;

  static Party_page_model fromMap(Map<String, dynamic> map) {
    Party_page_model party_page_model = new Party_page_model();
    party_page_model.count = map['count'];
    party_page_model.results = ResultsListBean.fromMapList(map['results']);
    return party_page_model;
  }

  static List<Party_page_model> fromMapList(dynamic mapList) {
    List<Party_page_model> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ResultsListBean {
  /**
   * title : "第二次相亲大会"
   * theme : "相亲"
   * content : "TI青年"
   * url : "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2449732359,3642718510&fm=27&gp=0.jpg"
   * city : "上海"
   * nick_name : "大虫"
   * place_detail : "恒大路11号"
   * mobile : "15313344323"
   * id : 2
   */

  String title;
  String theme;
  String content;
  String url;
  String city;
  String nick_name;
  String place_detail;
  String mobile;
  int id;
  String tag1;
  String tag2;
  String tag3;
  String expire_time;
  String sub_describe;

  static ResultsListBean fromMap(Map<String, dynamic> map) {
    ResultsListBean resultsListBean = new ResultsListBean();
    resultsListBean.title = map['title'];
    resultsListBean.theme = map['theme'];
    resultsListBean.content = map['content'];
    resultsListBean.url = map['url'];
    resultsListBean.city = map['city'];
    resultsListBean.nick_name = map['nick_name'];
    resultsListBean.place_detail = map['place_detail'];
    resultsListBean.mobile = map['mobile'];
    resultsListBean.id = map['id'];
    resultsListBean.tag1 = map['tag1'];
    resultsListBean.tag2 = map['tag2'];
    resultsListBean.tag3 = map['tag3'];
    resultsListBean.expire_time = map['expire_time'];
    resultsListBean.sub_describe = map['sub_describe'];
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
