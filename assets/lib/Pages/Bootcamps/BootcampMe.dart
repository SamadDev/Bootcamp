// import 'package:bootcamps/Pages/Bootcamps/BootcampDetailScreen.dart';
// import 'package:bootcamps/Providers/Bootcamp.dart';
// import 'package:bootcamps/Style/style.dart';
// import 'package:bootcamps/Widgets/Drawer.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:bootcamps/Providers/profile.dart';
//
// class MyBootcamp extends StatefulWidget {
//   static const route = '/MyBootcamp';
//
//   static String bootcampId;
//   @override
//   _MyBootcampState createState() => _MyBootcampState();
// }
//
// class _MyBootcampState extends State<MyBootcamp> {
//   Widget build(BuildContext context) {
//     final userId = Profile.userId;
//     final data = Provider.of<BootCamp>(context).findBootWithUserId(userId);
//     return Scaffold(
//       drawer: MainDrawer(),
//       appBar: AppBar(
//         title: Center(
//             child: Text(
//           data.name,
//         )),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 5, bottom: 5, right: 18, left: 18),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.of(context)
//                 .pushNamed(BootcampDetailScreen.route, arguments: data.id);
//           },
//           child: Container(
//             height: 290,
//             child: Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: double.infinity,
//                   child: Card(
//                     margin: EdgeInsets.zero,
//                     color: AppTheme.bg,
//                     elevation: 3,
//                     shadowColor: AppTheme.secondaryBg2,
//                     clipBehavior: Clip.antiAlias,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(20),
//                             topLeft: Radius.circular(20),
//                             bottomLeft: Radius.circular(10),
//                             bottomRight: Radius.circular(10))),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 1.6,
//                           child: Card(
//                             margin: EdgeInsets.zero,
//                             elevation: 0,
//                             clipBehavior: Clip.antiAlias,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     topLeft: Radius.circular(20))),
//                             child: Container(
//                               width: double.infinity,
//                               height: double.infinity,
//                               child: CachedNetworkImage(
//                                 imageUrl: data.photo,
//                                 fit: BoxFit.fill,
//                                 placeholder: (context, url) =>
//                                     Center(child: CircularProgressIndicator()),
//                                 errorWidget: (context, url, error) =>
//                                     Icon(Icons.error),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 25,
//                           child: Container(
//                             width: double.infinity,
//                             height: double.infinity,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 4, right: 4, top: 4, bottom: 4),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     flex: 8,
//                                     child: Text(
//                                       data.name,
//                                       style:
//                                           Theme.of(context).textTheme.headline2,
//                                     ),
//                                   ),
//                                   Expanded(
//                                       flex: 13,
//                                       child: Text(
//                                         "We have ${data.careers} course",
//                                         maxLines: 2,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .headline4,
//                                       )),
//                                   Expanded(
//                                       flex: 4,
//                                       child: Text(
//                                         data.address,
//                                         maxLines: 1,
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
