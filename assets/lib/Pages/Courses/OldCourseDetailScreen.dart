// import 'package:bootcamps/Pages/Bootcamps/BootcampDetailScreen.dart';
// import 'package:bootcamps/Pages/Reviews/ReviewsScreen.dart';
// import 'package:bootcamps/Providers/Course.dart';
// import 'package:bootcamps/Providers/Reviews.dart';
// import 'package:bootcamps/Providers/View&like.dart';
// import 'package:bootcamps/Providers/profile.dart';
// import 'package:bootcamps/constant.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// class CourseDetailScreen extends StatefulWidget {
//   static const route = "/CourseDetailScreen";
//
//   @override
//   _CourseDetailScreenState createState() => _CourseDetailScreenState();
// }
//
// class _CourseDetailScreenState extends State<CourseDetailScreen> {
//   initState() {
//     super.initState();
//     Provider.of<View>(context, listen: false)
//         .postView(context: context, newView: 1);
//   }
//
//   Widget build(BuildContext context) {
//     final role = Profile.userRole;
//     final courseId = ModalRoute.of(context).settings.arguments as String;
//     final data =
//         Provider.of<Course>(context, listen: false).findCourseById(courseId);
//     Provider.of<Review>(context, listen: false)
//         .fitchReviewsReferCourse(courseId);
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Text(
//           data.title,
//         )),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                       width: double.infinity,
//                       height: 200,
//                       child: CachedNetworkImage(
//                         imageUrl: data.photo,
//                         fit: BoxFit.fill,
//                         placeholder: (_, index) =>
//                             Center(child: CircularProgressIndicator()),
//                       )),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Text(
//                           data.title,
//                           style: Theme.of(context).textTheme.headline1,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       topTextOfCourseDetailScreen('What you will learn'),
//                       courseInfoText(data.description),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       topTextOfCourseDetailScreen('Information'),
//                       Container(
//                         height: 230,
//                         width: MediaQuery.of(context).size.width,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             courseInfoText(
//                                 'minimum skill: ${data.minimumSkill}'),
//                             courseInfoText(
//                                 'duration: ${data.weeks.toString()} weeks'),
//                             courseInfoText(
//                                 'tuition: ${data.tuition.toString()} \$'),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).pushNamed(
//                                     BootcampDetailScreen.route,
//                                     arguments: data.bootcampId);
//                               },
//                               child: Row(
//                                 children: [
//                                   courseInfoText('bootcamp:'),
//                                   Text(
//                                     '${data.bootcampName}',
//                                     style: GoogleFonts.adventPro(
//                                         decoration: TextDecoration.underline,
//                                         color: Colors.blue,
//                                         fontSize: 20),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 20, right: 8, left: 8),
//                               child: SizedBox(
//                                 child: CupertinoButton(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: Container(
//                                     color: Colors.lightBlueAccent,
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       children: <Widget>[
//                                         Text(
//                                           'Course Reviews',
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         Expanded(child: SizedBox()),
//                                         RotatedBox(
//                                           quarterTurns: 3,
//                                           child: Icon(
//                                             CupertinoIcons.down_arrow,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   color: Colors.lightBlueAccent,
//                                   onPressed: () {
//                                     Navigator.of(context).pushNamed(
//                                         ReviewsScreen.route,
//                                         arguments: data.id);
//                                   },
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   topTextOfCourseDetailScreen(
//                       'Some courses related to that bootcamp'),
//                   Container(
//                     height: 280,
//                     child: CourseDetailRelateWidget(
//                       bootcampId: data.bootcampId,
//                     ),
//                   ),
//                   role == 'publisher'
//                       ? SizedBox.shrink()
//                       : SizedBox(
//                           height: 70,
//                         )
//                 ],
//               ),
//             ),
//             role != 'publisher'
//                 ? Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       width: double.infinity,
//                       height: 70,
//                       child: gestureDetectorWidget(
//                           function: () {
//                             enrollDialog(context);
//                           },
//                           width: 180,
//                           text: "Enroll Now"),
//                     ))
//                 : SizedBox.shrink()
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CourseDetailRelateWidget extends StatelessWidget {
//   final bootcampId;
//   CourseDetailRelateWidget({this.bootcampId});
//
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Provider.of<Course>(context, listen: false)
//             .fitchCoursesRefBootcamp(bootcampId),
//         builder: (context, snap) {
//           if (snap.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Consumer<Course>(
//                 builder: (ctx, course, _) => ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: course.bootcampCourse.length,
//                     itemBuilder: (cxt, index) => Card(
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(color: Colors.white, width: 1),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           elevation: 2,
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.of(context).pushNamed(
//                                   CourseDetailScreen.route,
//                                   arguments: course.bootcampCourse[index].id);
//                             },
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Card(
//                                   // shape: RoundedRectangleBorder(
//                                   //     borderRadius: BorderRadius.only(
//                                   //         topRight: Radius.circular(15),
//                                   //         topLeft: Radius.circular(15))),
//                                   child: Container(
//                                       width: 270,
//                                       height: 200,
//                                       child: CachedNetworkImage(
//                                         imageUrl:
//                                             course.bootcampCourse[index].photo,
//                                         fit: BoxFit.fill,
//                                         placeholder: (_, index) => Center(
//                                             child: CircularProgressIndicator()),
//                                       )),
//                                 ),
//                                 courseText(
//                                     'title: ${course.courseList[index].title} '),
//                                 courseText(
//                                     'tuition: ${course.courseList[index].tuition} \$'),
//                                 courseText(
//                                     'minim skills: ${course.courseList[index].minimumSkill}'),
//                               ],
//                             ),
//                           ),
//                         )));
//           }
//         });
//   }
// }
// // courseText(
// // 'title: ${course.courseList[index].title} '),
// // courseText(
// // 'tuition: ${course.courseList[index].tuition} \$'),
// // courseText(
// // 'minim skills: ${course.courseList[index].minimumSkill}'),
