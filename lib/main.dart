import 'package:bootcamps/Pages/Authendication/SplashScreen.dart';
import 'package:bootcamps/Pages/Authendication/UserOrPublisher.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampCoursess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './Localization/language.dart';
import './Pages/Authendication/LoginScreen.dart';
import './Pages/Authendication/ProfileEdit.dart';
import './Pages/Authendication/SignUPScreen.dart';
import './Pages/Bootcamps/BootcampDetailScreen.dart';
import './Pages/Bootcamps/BootcampMe.dart';
import './Pages/Bootcamps/BootcampPostScreen.dart';
import './Pages/Bootcamps/BootcampsScreen.dart';
import './Pages/Courses/CourseDetailScreen.dart';
import './Pages/Courses/CourseFilterScreen.dart';
import './Pages/Courses/CourseMy.dart';
import './Pages/Courses/CoursePostScreen.dart';
import './Pages/Courses/CourseScreen.dart';
import './Pages/Reviews/ReviewPostScreen.dart';
import './Pages/Reviews/ReviewsScreen.dart';
import './Providers/Bootcamp.dart';
import './Providers/Course.dart';
import './Providers/Reviews.dart';
import './Providers/View&like.dart';
import './Providers/category.dart';
import './Providers/profile.dart';
import './Style/style.dart';
import 'Providers/LogIn.dart';

void main() {
  runApp(ProviderWidget());
}

class ProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: BootCamp()),
        ChangeNotifierProvider.value(value: Profile()),
        ChangeNotifierProvider.value(value: Profile()),
        ChangeNotifierProvider.value(value: User()),
        ChangeNotifierProvider.value(value: BootcampData()),
        ChangeNotifierProvider.value(value: Course()),
        ChangeNotifierProvider.value(value: CourseData()),
        ChangeNotifierProvider.value(value: Review()),
        ChangeNotifierProvider.value(value: ReviewData()),
        ChangeNotifierProvider.value(value: ViewData()),
        ChangeNotifierProvider.value(value: View()),
        ChangeNotifierProvider.value(value: Language()),
        ChangeNotifierProvider.value(value: Category()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  Future<void> loadingData(BuildContext context) async {
    Provider.of<Profile>(context, listen: false);
    await Provider.of<Language>(context, listen: false)
        .getLanguageDataInLocal();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffeeeeee),
      statusBarColor: Color(0xffeeeeee), // status bar color
    ));
    return MaterialApp(
      builder: (ctx, child) {
        return Directionality(
          textDirection: language.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: language.words['bootcamp'],
      theme: AppTheme.lightTheme,
      home: BootcampCourses(),
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        SingUPScreen.route: (context) => SingUPScreen(),
        ProfileEdit.route: (context) => ProfileEdit(),
        BootcampsScreen.route: (context) => BootcampsScreen(),
        BootcampDetailScreen.route: (context) => BootcampDetailScreen(),
        BootcampPostScreen.route: (context) => BootcampPostScreen(),
        MyBootcamp.route: (context) => MyBootcamp(),
        CourseScreen.route: (context) => CourseScreen(),
        CourseFilterScreen.route: (context) => CourseFilterScreen(),
        CourseDetailScreen.route: (context) => CourseDetailScreen(),
        CoursePostScreen.route: (context) => CoursePostScreen(),
        MyCourse.route: (context) => MyCourse(),
        ReviewsScreen.route: (context) => ReviewsScreen(),
        ReviewPostScreen.route: (context) => ReviewPostScreen()
      },
    );
  }
}

class CheckScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Auth>(context).fetchTokenInLocal(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator()))
                : Auth.token == null
                    ? UserOrPublisher()
                    : SplashScreen());
  }
}
