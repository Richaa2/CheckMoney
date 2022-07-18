import 'package:flutter/material.dart';

class ContainerForNumPad extends StatelessWidget {
  bool? rightOrLeft;
  final String name;
  final String icon;
  bool? editOrTransfer;
  ContainerForNumPad({
    Key? key,
    this.rightOrLeft,
    required this.name,
    required this.icon,
    this.editOrTransfer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget text;
    if (rightOrLeft == false) {
      text = Text(
        'From category',
      );
    } else if (rightOrLeft == true) {
      text = Text('To account');
    }
    if (editOrTransfer == true) {
      text = Text('Account balance');
    } else if (rightOrLeft == false && editOrTransfer == false) {
      text = Text('From account');
    }
    return Container(
        height: 100,
        color: rightOrLeft == false ? Colors.teal[700] : Colors.teal,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, child: text),
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 2,
                    child: Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Flexible(
                flex: 5,
                child: rightOrLeft == false
                    ? CircleAvatar(
                        minRadius: 17.0,
                        maxRadius: 23.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          IconData(int.parse(icon),
                              fontFamily: 'MaterialIcons'),
                          color: Colors.teal[600],
                        ),
                      )
                    : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        child: Icon(
                          IconData(int.parse(icon),
                              fontFamily: 'MaterialIcons'),
                          color: Colors.teal[600],
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
