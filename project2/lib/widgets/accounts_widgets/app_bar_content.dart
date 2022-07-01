import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  final void Function() done;
  // String inputName = 'without name';
  // int inputMoney = 0;
  final Widget textField;

  const AppBarContent({
    Key? key,
    required this.done,
    required this.textField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 20,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                'New account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Spacer(),
              IconButton(
                  icon: const Icon(
                    Icons.check,
                    size: 20,
                  ),
                  color: Colors.white,
                  onPressed: done),
            ],
          ),
        ),
        Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 15,
              child: SizedBox(child: textField),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }
}
