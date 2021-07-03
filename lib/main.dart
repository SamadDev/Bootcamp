import 'package:bootcamps/Pages/Authendication/UserOrPublisher.dart';
import 'package:bootcamps/Pages/Category/CategoryScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseMy.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Pages/Courses/Detail/VideoPlayer.dart';
import 'package:bootcamps/Pages/Courses/love.dart';
import 'package:bootcamps/Pages/Enroll/EnrollScree.dart';
import 'package:bootcamps/Pages/Enroll/ErnollMenPost.dart';
import 'package:bootcamps/Providers/CategoryC.dart';
import 'package:bootcamps/Providers/DarkMode.dart';
import 'package:bootcamps/Providers/Follow.dart';
import 'package:bootcamps/Providers/enroll%20message.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/love.dart';
import 'package:bootcamps/Providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './Localization/language.dart';
import './Pages/Authendication/LoginScreen.dart';
import './Pages/Authendication/ProfileEdit.dart';
import './Pages/Authendication/SignUPScreen.dart';
import './Pages/Bootcamps/BootcampsHomeScreen.dart';
import './Pages/Courses/CoursePostScreen.dart';
import './Pages/Courses/CourseScreen.dart';
import './Pages/Reviews/ReviewPostScreen.dart';
import './Pages/Reviews/ReviewsScreen.dart';
import './Providers/Bootcamp.dart';
import './Providers/Category.dart';
import './Providers/Course.dart';
import './Providers/Reviews.dart';
import './Providers/View&like.dart';
import './Providers/profile.dart';
import './Style/style.dart';
import 'Pages/Authendication/SplashScreen.dart';
import 'Pages/Courses/CourseFilter/CourseFilterHome.dart';
import 'Pages/Courses/CourseFilter/CourseFilterScreen.dart';
import 'Pages/drewer1.dart';
import 'Providers/Auth.dart';
import 'Widgets/ButtomBar.dart';
import 'package:bootcamps/Pages/Enroll/EnrollmessageScreen.dart';

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
        ChangeNotifierProvider.value(value: CourseC()),
        ChangeNotifierProvider.value(value: SLocalStorage()),
        ChangeNotifierProvider.value(value: StateChange()),
        ChangeNotifierProvider.value(value: Follow()),
        ChangeNotifierProvider.value(value: Enroll()),
        ChangeNotifierProvider.value(value: EnrollData()),
        ChangeNotifierProvider.value(value: MessageEnroll()),
        ChangeNotifierProvider<DarkThemePreference>(
          create: (_) => DarkThemePreference(),
        ),
        ChangeNotifierProvider<Language>(
          create: (_) => Language(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initState() {
    super.initState();
    Provider.of<Language>(context,listen: false).getLanguageDataInLocal();
  }
  Widget build(BuildContext context) {

    final language = Provider.of<Language>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xffeeeeee),
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent, // status bar color
    ));

    return Consumer<DarkThemePreference>(builder: (context, theme, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (ctx, child) {
          return Directionality(
            textDirection:
            // language.languageCode == 'en'
            //     ?
            TextDirection.ltr,
                // : TextDirection.rtl,
            child: child,
          );
        },
        theme:
            theme.darkTheme == true ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: CheckScreens(),
        routes: {
          LoginScreen.route: (context) => LoginScreen(),
          SingUPScreen.route: (context) => SingUPScreen(),
          ProfileEdit.route: (context) => ProfileEdit(),
          BootcampsScreen.route: (context) => BootcampsScreen(),
          CourseScreen.route: (context) => CourseScreen(),
          CourseFilterScreen.route: (context) => CourseFilterScreen(),
          CoursePostScreen.route: (context) => CoursePostScreen(),
          ReviewsScreen.route: (context) => ReviewsScreen(),
          ReviewPostScreen.route: (context) => ReviewPostScreen(),
          CategoryScreen.route: (context) => CategoryScreen(),
          DetailHomeScreen.route: (context) => DetailHomeScreen(),
          CourseSearch.route: (context) => CourseSearch(),
          HomeScreen.route: (context) => HomeScreen(),
          CourseFilterHome.router: (context) => CourseFilterHome(),
          MyCourse.route: (context) => MyCourse(),
          VideoPlayerScreen.route: (context) => VideoPlayerScreen(),
          LoveScreen.route: (context) => LoveScreen(),
          EnrollMenScreen.route: (context) => EnrollMenScreen(),
          EnrollPostScreen.route: (context) => EnrollPostScreen(),
          EnrollMessageScreen.route: (context) => EnrollMessageScreen()
        },
      );
    });
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
