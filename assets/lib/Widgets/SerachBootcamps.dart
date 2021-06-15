// import 'package:bootcamps/Style/style.dart';
// import 'package:flutter/material.dart';
//
// class SearchBootcamps extends StatefulWidget {
//   @override
//   _SearchBootcampsState createState() => _SearchBootcampsState();
// }
//
// class _SearchBootcampsState extends State<SearchBootcamps> {
//   bool isClick = false;
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Search for the bootcamps',
//             style: Theme.of(context).textTheme.headline2,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 16, left: 16),
//             child: Container(
//               height: 100,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 children: [
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     width: MediaQuery.of(context).size.width * 0.90,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(32),
//                       color: AppTheme.secondaryBg2,
//                       boxShadow: kElevationToShadow[2],
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                               padding: EdgeInsets.only(left: 16),
//                               child: TextField(
//                                 textCapitalization:
//                                     TextCapitalization.sentences,
//                                 onChanged: (value) {},
//                                 decoration: InputDecoration(
//                                     hintText: 'Search',
//                                     hintStyle: TextStyle(
//                                         color: AppTheme.headlineTextColor),
//                                     border: InputBorder.none),
//                               )),
//                         ),
//                         Container(
//                           child: Material(
//                             type: MaterialType.transparency,
//                             child: InkWell(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(32),
//                                 topRight: Radius.circular(32),
//                                 bottomLeft: Radius.circular(32),
//                                 bottomRight: Radius.circular(32),
//                               ),
//                               child: GestureDetector(
//                                 onTap: () {},
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(16.0),
//                                   child: Icon(
//                                     isClick ? Icons.dangerous : Icons.search,
//                                     color: AppTheme.headlineTextColor,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
