// import 'package:flutter/material.dart';

// class RecordsListTile extends StatelessWidget {
//   final String nameTitle;
//   final int amount;
//   bool min = false;

//   RecordsListTile({
//     Key? key,
//     required this.nameTitle,
//     required this.amount,
//     required this.min,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       trailing: min
//           ? Text(
//               '-\$$amount',
//               style: TextStyle(
//                   color: Colors.red, fontSize: 20, fontWeight: FontWeight.w700),
//             )
//           : Text(
//               '+\$$amount',
//               style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700),
//             ),
//       leading: CircleAvatar(
//         child: Icon(
//           Icons.shopping_basket,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       title: Text(
//         '$nameTitle',
//       ),
//     );
//   }
// }
