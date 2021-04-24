// import 'package:flutter/material.dart';
//
// class SortDropDown extends StatefulWidget {
//   String state;
//   SortDropDown({this.state});
//   _SortDropDownState createState() => _SortDropDownState();
// }
//
// class _SortDropDownState extends State<SortDropDown> {
//   Widget build(BuildContext context) {
//     final List _sort = [
//       {"title": "most popular", 'value': 'averageView'},
//       {"title": "recent courses", 'value': 'createdAt'},
//       {"title": "highest rating", 'value': 'averageRating'},
//     ];
//     _short() {
//       return DropdownButton(
//           underline: SizedBox.shrink(),
//           value: widget.state,
//           items: _sort
//               .map((e) => DropdownMenuItem(
//                     child: Text(e['title']),
//                     value: e['value'],
//                   ))
//               .toList(),
//           onChanged: (value) {
//             setState(() {
//               widget.state = value;
//             });
//           });
//     }
//
//     return _short();
//   }
// }
