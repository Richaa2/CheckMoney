class Record {
  String name;
  num amount;
  bool action;
  int dateTime;
  Record({
    required this.name,
    required this.amount,
    this.action = false,
    required this.dateTime,
  });

  // void minAmount() {
  //   action = false;
  // }
}
