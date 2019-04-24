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
