import 'package:flutter/material.dart';

import 'package:project2/models/account.dart';
import 'package:project2/widgets/show_modal_buttom_sheet_metod.dart';

class InkControllButton extends StatelessWidget {
  final Widget screen;
  final Color color;
  final IconData icon;
  final Account Function()? removeAcc;

  const InkControllButton({
    Key? key,
    required this.screen,
    required this.color,
    required this.icon,
    this.removeAcc,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: color.withOpacity(0.4),
        shape: const CircleBorder(),
      ),
      child: IconButton(
          color: color,
          hoverColor: color,
          onPressed: () {
            removeAcc;
            showModalBottomSheetMetod(context, screen);
          },
          icon: Icon(
            icon,
            color: color,
          )),
    );
  }
}
