class Record {
  String name;
  int amount;
  bool action;
  Record({
    required this.name,
    required this.amount,
    this.action = false,
  });

  // void minAmount() {
  //   action = false;
  // }
}
