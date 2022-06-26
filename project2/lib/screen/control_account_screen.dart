import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project2/control_amount/edit_amount.dart';
import 'package:project2/control_amount/min_account.dart';
import 'package:project2/control_amount/transfer_amount.dart';
import 'package:project2/screen/select_account_screen.dart';
import 'package:provider/provider.dart';

import 'package:project2/screen/add_account_screen.dart';
import 'package:project2/widgets/showModalBottomSheetMetod.dart';

import '../control_amount/add_amount.dart';
import '../control_amount/control_amount.dart';
import '../models/account_data.dart';
import '../widgets/ink_controll_button.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkControllButton(
                  index: index,
                  color: Colors.green,
                  icon: Icons.add,
                  screen: AddAmount(
                    index: index,
                  ),
                ),
                InkControllButton(
                  index: index,
                  color: Colors.red,
                  icon: Icons.remove,
                  screen: MinAmount(
                    index: index,
                  ),
                ),
                InkControllButton(
                  index: index,
                  color: Colors.yellow,
                  icon: Icons.edit,
                  screen: EditAmount(
                    index: index,
                  ),
                ),
                InkControllButton(
                  index: index,
                  color: Colors.grey,
                  icon: Icons.arrow_forward,
                  screen: SelectAccount(),
                ),
              ],
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
