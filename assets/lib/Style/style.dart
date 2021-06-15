import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
// class SizeConfig {
//   static double _blockWidth = 0;
//   static double _blockHeight = 0;
//
//   static double textMultiplier;
//   static double imageSizeMultiplier;
//   static double heightMultiplier;
//   static double widthMultiplier;
//   static bool isPortrait = true;
//   static bool isMobilePortrait = false;
//   static double screenWidth;
//   static double screenHeight;
//
//   void init(BoxConstraints constraints, Orientation orientation) {
//     if (orientation == Orientation.portrait) {
//       screenWidth = constraints.maxWidth;
//       screenHeight = constraints.maxHeight;
//       isPortrait = true;
//       if (screenWidth < 450) {
//         isMobilePortrait = true;
//       }
//     } else {
//       screenWidth = constraints.maxHeight;
//       screenHeight = constraints.maxWidth;
//       isPortrait = false;
//       isMobilePortrait = false;
//     }
//
//     _blockWidth = screenWidth / 100;
//     _blockHeight = screenHeight / 100;
//
//     textMultiplier = _blockHeight;
//     imageSizeMultiplier = _blockWidth;
//
//     heightMultiplier = _blockHeight;
//     widthMultiplier = _blockWidth;
//
//     print(screenWidth);
//   }
// }

  //Colors of the whole application

  static const Color green = Colors.teal;
  static const Color orange = Color(0xfffea41b);
  static const Color navy = Color(0xff736ff4);
  static const Color black1 = Color(0xff3e3e3e);
  static const Color black2 = Color(0xffe4e8eb);
  static const Color black3 = Color(0xffd2d2d2);
  static const Color white = Colors.white;
  static Color black4 = Color(0xff3e3e3e).withOpacity(0.2);
  static Color lightBlueAccent = Colors.lightBlueAccent;

  static const Color button = Colors.lightBlueAccent;
  static const Color secondaryBg = Colors.lightBlueAccent;
  static const Color primary = Colors.black54;
  static Color secondary = Color(0xFFeeeee).withOpacity(0.3);
  static const Color headlineTextColor = Colors.black;
  static const Color subTitleTextColor = Color(0xFF242424);
  static const Color body = Colors.grey;
  static const Color bg = Color(0xFFeeeeee);
  static const Color secondaryBg2 = Colors.white;
  static Color shadow = Colors.white;
  static const deleteButton = Colors.red;
  static const editButton = Colors.blue;

  //light theme of the application
  static final ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: AppTheme.bg,
      backgroundColor: AppTheme.bg,
      brightness: Brightness.light,
      primaryColor: AppTheme.headlineTextColor,
      textTheme: lightTextTheme,
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        color: Color(0xffeeeeee),
        textTheme: TextTheme(title: _headline2),
        elevation: 5,
        // shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ));

  //dark theme of the whole application
  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black12,
      shadowColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: AppTheme.bg,
      textTheme: darkTextTheme,
      accentColorBrightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.white10,
          textTheme:
              TextTheme(title: _headline2.copyWith(color: Colors.white))));

  //Dark Text theme of the application
  static final TextTheme darkTextTheme = TextTheme(
    headline1: _headline1.copyWith(color: Colors.white),
    headline2: _headline2.copyWith(color: Colors.white),
    headline3: _headline3.copyWith(color: Colors.white),
    headline4: _headline4.copyWith(color: Colors.white),
    headline5: _headline5.copyWith(color: Colors.white),
    headline6: _headline6.copyWith(color: Colors.white),
    button: _button.copyWith(color: AppTheme.headlineTextColor),
    subtitle1: _subtitle1.copyWith(color: Colors.white),
    subtitle2: _subtitle2.copyWith(color: Colors.white),
    bodyText1: _bodyText1.copyWith(color: AppTheme.primary),
    bodyText2: _bodyText2.copyWith(color: AppTheme.secondaryBg),
  );

  //Light dark theme of the application
  static final TextTheme lightTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _headline2,
    headline3: _headline3,
    headline4: _headline4,
    headline5: _headline5,
    headline6: _headline6,
    caption: _caption,
    button: _button,
    subtitle1: _subtitle1,
    subtitle2: _subtitle2,
    bodyText1: _bodyText1,
    bodyText2: _bodyText2,
  );

  static final TextStyle _headline1 = TextStyle(
    color: AppTheme.green,
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 30,
  );

  static final TextStyle _headline2 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1,
    fontWeight: FontWeight.w700,
    fontSize: 30,
  );
  static final TextStyle _headline3 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static final TextStyle _headline4 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static final TextStyle _headline5 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.green,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
  static final TextStyle _headline6 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1.withOpacity(0.25),
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );

  static final TextStyle _caption = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.orange,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle _button = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );

  static final TextStyle _subtitle1 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.green,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static final TextStyle _subtitle2 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    fontWeight: FontWeight.w500,
    color: AppTheme.black1.withOpacity(0.5),
    fontSize: 14,
  );

  static final TextStyle _bodyText1 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static final TextStyle _bodyText2 = TextStyle(
    fontFamily: GoogleFonts.roboto().fontFamily,
    color: AppTheme.black1.withOpacity(0.7),
    height: 1.3,
    wordSpacing: 1.2,
    fontWeight: FontWeight.w500,
    fontSize: 15,
  );
}
