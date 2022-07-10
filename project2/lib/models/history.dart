class Record {
  String name;
  num amount;
  int action;
  int dateTime;
  String id;
  Record(
      {required this.name,
      required this.amount,
      this.action = 1,
      required this.dateTime,
      this.id = '5'});
}
