import 'package:flutter/material.dart';

class ListTileAddScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final DropdownButton? trailing;

  const ListTileAddScreen({
    Key? key,
    required this.title,
    required this.subtitle,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.blueGrey),
      ),
      trailing: trailing,
    );
  }
}
