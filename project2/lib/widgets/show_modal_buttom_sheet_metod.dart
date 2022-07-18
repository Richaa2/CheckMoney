import 'package:flutter/material.dart';
import 'package:project2/models/account_data.dart';
import 'package:provider/provider.dart';

Future<dynamic> showModalBottomSheetMetod(BuildContext context, Widget child) {
  return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      context: context,
      builder: (context) => SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child));
}
