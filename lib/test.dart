// import 'package:bootcamps/Pages/Authendication/LoginScreen.dart';
// import 'package:bootcamps/Pages/Authendication/SignUPScreen.dart';
// import 'package:bootcamps/Style/style.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class Test extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Expanded(
//                   child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => SingUPScreen(
//                             userRole: "user",
//                           )));
//                 },
//                 child: Container(
//                   child: Center(
//                     child: RotatedBox(
//                       quarterTurns: 1,
//                       child: Text(
//                         'User',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700,
//                             color: Colors.teal,
//                             fontFamily: GoogleFonts.roboto().fontFamily,
//                             fontSize: 50),
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//               Expanded(
//                   child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) =>
//                           LoginScreen(userRole: "publisher")));
//                 },
//                 child: Container(
//                     color: AppTheme.green,
//                     child: RotatedBox(
//                       quarterTurns: 1,
//                       child: Center(
//                         child: Text(
//                           'Publisher',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                               color: AppTheme.white,
//                               fontFamily: GoogleFonts.roboto().fontFamily,
//                               fontSize: 50),
//                         ),
//                       ),
//                     )),
//               ))
//             ],
//           ),
//           Card(
//             margin: EdgeInsets.zero,
//             child: Text(
//               'ARE YOU',
//               style: TextStyle(
//                   color: AppTheme.green,
//                   fontWeight: FontWeight.w500,
//                   fontFamily: GoogleFonts.roboto().fontFamily,
//                   fontSize: 25),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
