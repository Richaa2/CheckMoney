class UserInfo {
  late String name;
  late String email;
  late int amount;
  UserInfo({required this.name, required this.email, required this.amount});

  void sum(int sum) {
    amount = sum;
  }

  void updateName(String newName) {
    name = newName;
  }

  void plusSum(int newAmount) {
    amount = amount + newAmount;
  }
}
