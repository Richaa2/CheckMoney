class UserInfo {
  final String? name;
  final String? email;
  late int? amount;
  UserInfo({this.name, this.email, this.amount});

  void plusSum(int newAmount) {
    if (amount == null) {
      amount = newAmount;
    } else {
      amount = amount! + newAmount;
    }
  }
}
