class Record {
  String name;
  num amount;
  int action;
  int dateTime;
  Record({
    required this.name,
    required this.amount,
    this.action = 1,
    required this.dateTime,
  });

  // void minAmount() {
  //   action = false;
  // }
}
