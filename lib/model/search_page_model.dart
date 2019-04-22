import 'package:xianglian_fluter/common/utils.dart';

class SearchPageModel {
  String name;
  String content;
  int type;

  int minAge = 0;
  int maxAge = 99;

  int minHeight = 0;
  int maxHeight = 999;

  int minWorkPlace;
  int maxWorkPlace;

  int minHomeTown;
  int maxHomeTown;

  int minCal = 0;
  int maxCal = 99;

  Map<String, dynamic> toJson() => {
        'min_height': minHeight,
        'max_height': maxHeight,
//        'minWorkPlace': minWorkPlace,
//        'maxWorkPlace': maxWorkPlace,
//        'minHomeTown': minHomeTown,
//        'maxHomeTown': maxHomeTown,
        'min_education': minCal,
        'max_education': maxCal,
        'min_age': getBirthday(maxAge),
        'max_age': getBirthday(minAge),
      };

}
