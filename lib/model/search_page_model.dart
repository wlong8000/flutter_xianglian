import 'package:xianglian_fluter/common/utils.dart';

class SearchPageModel {
  String name;
  String content;
  int type;

  int minAge = 0;
  int maxAge = 99;

  int minHeight = 0;
  int maxHeight = 999;

  String workPlace;
  String homeTown;

  int minCal = 0;
  int maxCal = 99;

  Map<String, dynamic> toJson() => {
        'min_height': minHeight,
        'max_height': maxHeight,
        'work_area_code': workPlace,
        'born_area_code': homeTown,
        'min_education': minCal,
        'max_education': maxCal,
        'min_age': getBirthday(maxAge),
        'max_age': getBirthday(minAge),
      };

}
