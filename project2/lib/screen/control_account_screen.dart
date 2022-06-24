import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';
import 'package:provider/provider.dart';

import '../models/account_data.dart';
import 'add_amount.dart';

class ControlAccountScreen extends StatelessWidget {
  ControlAccountScreen({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                Ink(
                  decoration: ShapeDecoration(
                    color: Color.fromARGB(97, 76, 175, 79),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      color: Colors.green,
                      hoverColor: Colors.green,
                      onPressed: () {
                        showModalBottomSheetMetod(
                            context,
                            AddAmount(
                              index: index,
                            ));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      )),
                )
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(Provider.of<AccountData>(context, listen: false)
                          .accountsMoney[index]);
                    },
                    child: Text('Check'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
