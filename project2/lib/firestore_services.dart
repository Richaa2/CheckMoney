import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project2/models/account.dart';

import 'models/account_for_firebase.dart';

class FirestoreServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var random = Random();

  Stream<List<AccountFirebase>> getAccount() {
    return _db
        .collection('account')
        .orderBy('name', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) =>
                AccountFirebase.fromMap(document.data(), document.id))
            .toList());
  }

  Future<void> addAccount() {
    var money = next(-15, 5);
    var dataMap = Map<String, dynamic>();
    dataMap['money'] = money;

    return _db.collection('account').add(dataMap);
  }

  int next(int min, int max) => min + random.nextInt(max - min);
}
