///根据生日，计算年龄
int getAge(String b) {
  if (b == null) return -1;
  DateTime dateTime = DateTime.parse(b);
  var age = DateTime.now().year - dateTime.year;
  print('age is $age');
  return age;
}
