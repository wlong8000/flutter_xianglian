class SearchPageModel {
  String name;
  String content;
  int type;

  int minAge;
  int maxAge;

  int minHeight;
  int maxHeight;

  int minWorkPlace;
  int maxWorkPlace;

  int minHomeTown;
  int maxHomeTown;

  int minCal;
  int maxCal;

  Map<String, dynamic> toJson() => {
        'minAge': minAge,
        'maxAge': maxAge,
        'min_height': minHeight,
        'max_height': maxHeight,
        'minWorkPlace': minWorkPlace,
        'maxWorkPlace': maxWorkPlace,
        'minHomeTown': minHomeTown,
        'maxHomeTown': maxHomeTown,
        'minCal': minCal,
        'maxCal': maxCal,
      };
}
