import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language with ChangeNotifier {
  // language dir
  String languageDirection = 'ltr';

  // language code
  String languageCode = 'en';

  void setLanguage(code, direction) async {
    languageCode = code;
    languageDirection = direction;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('languageCode', languageCode);
    sharedPreferences.setString('languageDirection', languageDirection);
    notifyListeners();
  }

  Future<void> getLanguageDataInLocal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    languageCode = sharedPreferences.getString('languageCode') ?? 'en';
    languageDirection =
        sharedPreferences.getString('languageDirection') ?? 'ltr';
    print(languageCode);
    notifyListeners();
  }

  Map<String, dynamic> get words => _words[languageCode];

// language words
  Map _words = {
    'kr': {
      'top': 'مالەو',
      'populate': 'دلخوازەکان',
      'recent': 'نوێترینەکان',
      'seeAll': 'بینینی هەموو',
      'courses': 'کۆرسەکان',
      'view': 'بینین',
      'technology': 'تێکنەلۆجی',
      'business': 'بزنز',
      "language": 'زمان',
      'sport': 'وەرزش',
      'art': 'هونەر',
      'fitness': 'لەشجوانی',
      'search': 'گەڕان ...',
      'home': 'ماڵەوە',
      'search1': "گەڕان",
      'notification': 'ئاگەداری',
      'more': 'زیاتر',
      'retry': 'هەوڵدانەوە',
      'welcome back': 'بەخێر بێیتەوە',
      'email': 'ئیمێل',
      'password': 'وشەی نهێنی',
      'log in': 'چونە ژورەوە',
      'no account': 'هەژمارت نیە؟',
      'sign up': 'خۆتۆمارکردن',
      'role': 'رۆڵ',
      'teacher': 'مامۆستا',
      'user': 'بەکارهێنەر',
//sign up
      'name': 'ناو',
      'user name': 'نازناوێک',
      'have account': 'هەژمارت هەیە؟',
      'are you': 'ئایە توو؟',
      'error occur': 'هەڵەیەک هەیە',
      "ok": "باشە",
      "sure": "تکایە دڵنیابەوە لە راستی زانیاریەکانت",
      'empty': " تکایە نابێت هیچ بۆشایەک بەتاڵبێت.",
      //filter
      "search to": "گەران بۆ ...",
      'filter': 'فلتەر',
      'price': 'نرخ',
      'rating': "رەتینگ گەورەتربێ لە",
      'category': "پۆلێن",
      'certificate': "شەهادە لەکۆتایدا",
      'course state': "جۆری خول",
      'skill': 'شارەزای داواکراو',
      'sort': "ریزکردن بەپێی",
      "clear": 'لادانی هەموو',
      "apply": "ئەنجامدان",
      //filter list
      'kurdish': 'کوردی',
      'english': 'ئینگلێزی',
      'arabic': 'عەربی',
      'beginner': 'سەرەتای',
      'intermediate': 'ناوەند',
      'expert': 'شارەزا',
      'have': 'هەیە',
      'not': 'نیە',
      'incamp': 'لە سەنتەر',
      'online': 'ئۆنڵاین',
      'popular': 'بەناوبانگترین',
      'new': 'تازە',

      'hours': 'کاتژمێر',
      'enroll now': 'خۆتتۆمار بکە',
      'profile': 'پرۆفایل',
      //info
      'about': 'دەربارە',
      'duration': 'ماوە',
      'create at': 'دروستکراوە لە',
      'update at': 'ئەپدەیتکراوە لە',
      //detail tab
      'info': 'زانیاری',
      'video': 'ڤدیۆ',
      'review': 'هەڵسەنگاندن',
      'have other course': 'کۆرسەکانیترم',
      //review
      'filter review': 'فلتەر ی هەلسەنگاندن',
      'feedback': 'هەلسەنگاندن',
      'old': 'کۆن',
      'height rate': 'زۆرترین رەیتینگ',
      'low rate': 'نزمترین رەیتینگ',
      'review now': 'هەڵسەنگاند',
      'validate': 'تکایە داتاداخلکە.',
      'your feedback': 'هەڵسەنگاندەکەت',
      //alert
      'true': 'تۆ خۆت تۆمارکردەوە ئێستا دەتوانی چێژلەفێربون ببینی',
      'pending': 'تکایە چاوەروانبە تاوەردەگرێیت لە لایەن بڵاوکەرەوە',
      'false': 'تکایە خۆت تۆمارکە لەمکۆرسە تۆ خۆت تۆمارنەکردوە',
      'enroll': 'خۆتۆمارکردن',
      //favorite
      'favorite': 'دڵخوازەکان',
      //enroll
      'full name':'ناوی تەواو',
      'full address':'ناونیشانی تەواو',
      'phone':'ژمارە موبایل',
      'way of payment':'رێگەی پارەدان(چالاک نیە لەئێستادا)'
      , 'submit':'ناردن',
      //drawer
      'Change Mode':'گۆرینی دۆخ',
      'dark Mode':'دۆخی تاریک',
      'log out':'چونە دەرەوە',
      'My Enrolled course':'کۆرسەکانم بەژداریم کردەوە'
  ,'setting':'رێکخستنەکان',
      'contact me with':'پەیوەندیم پێوەبەکە لەرێگەی',
      'learn with my other course':"لەگەڵکۆرسەکانیترم فێرمە"
    },
    'en': {
      //home page
      'top': 'Home',
      'populate': 'Most Populate',
      'recent': 'Most Recent',
      'seeAll': 'See All',
      'courses': 'courses',
      'view': 'view',
      'technology': 'Technology',
      'business': 'Business',
      "language": 'Language',
      'sport': 'sport',
      'fitness': 'Fitness',
      'art': 'Art',
      'search': 'Search ...',
      'home': 'Home',
      'search1': 'search',
      'notification': 'Notification',
      'more': 'More',
      'retry': 'retry',
//log in
      'email': 'Email',
      'password': 'password',
      'log in': 'Log In',
      'no account': 'you don\'t have account?',
      'sign up': 'Sign Up',
      'role': 'role',
      'teacher': 'teacher',
      'user': 'user',
      'welcome back': 'welcome back',
//sign up
      'name': 'name',
      'user name': 'User Name',
      'have account': 'you have account?',
      'are you': 'are you?',
      'error occur': 'An Error Occurred',
      "ok": "ok",
      "sure": "Please make sure your data is correct",
      'empty': "please No field should be empty.",
//filter
      "search to": "Search to ...",
      'filter': 'Filter',
      'price': 'Prise',
      'rating': "Rating Greater than",
      'category': "category",
      'certificate': "Certificate in the end",
      'course state': "Course State",
      'skill': 'Skill Required',
      'sort': "Sort by",
      "clear": 'Clear all',
      "apply": "Apply Filter",
      //filter list
      'kurdish': 'Kurdish',
      'english': 'English',
      'arabic': 'Arabic',
      'beginner': 'Beginner',
      'intermediate': 'Intermediate',
      'expert': 'Expert',
      'have': 'have',
      'not': 'not',
      'incamp': 'inCampus',
      'online': 'online',
      'popular': 'Most popular',
      'new': 'new',
      //detail screen
      'hours': 'hours',
      'enroll now': 'Enroll Now',
      'profile': 'profile',
      //info
      'about': 'about',
      'duration': 'duration',
      'create at': 'create at',
      'update at': 'update at',
      //tab detail
      'info': 'Info',
      'video': 'video',
      'review': 'reviews',
      'have other course': 'Have Other Course',
      //review
      'filter review': 'filter review',
      'feedback': 'Feedback',
      'old': 'Old',
      'height rate': 'Height rate',
      'low rate': 'Low rate',
      'review now': 'Review Now',
      'validate': 'please provide value.',
      'your feedback': 'Your Feedback',
      //alert
      'true': 'You enrolled now you can enjoy learning',
      'pending': 'Please wait until the publisher accept',
      'false': 'You are not enroll to this course please enroll first',
      'enroll': 'enroll',
      //favorite
      'favorite': 'Favorite',
      //enroll
      'full name':'Full name',
      'full address':'Full address',
      'phone':'Phone number',
      'way of payment':'way of payment',
      'submit':'submit',
      //drawer
      'Change Mode':'Change Mode',
      'dark Mode':'dark Mode',
      'log out':'log out',
      'My Enrolled course':'My Enrolled course',
      'setting':'settings',
      'contact me with':'contact me with',
      'learn with my other course':"learn with my other course"



    },
    'ar': {

      //home page
      'top': 'اعلی',
      'populate': 'لأكثر ملء',
      'recent': 'جدید',
      'seeAll': 'نظر كل',
      'courses': 'الدورات',
      'view': 'عرض',
      'technology': 'لتكنولوجيا',
      'business': 'لتجارية',
      "language": 'اللغة',
      'sport': 'الرياضة',
      'fitness': 'اللياقة البدنية',
      'art': 'الفن',
      'search': ' ... البحث',
      'home': 'الصفحة الرئيسية',
      'search1': "بحث",
      'notification': 'اشعارات',
      'more': 'المزيد',
      'retry': 'إعادة المحاولة',
//log in
      'email': 'البريد الإلكتروني',
      'password': 'كلمة السر',
      'log in': 'تسجيل الدخول',
      'no account': 'لا حساب" : "أنت لا\" ليس لديك حساب؟',
      'sign up': 'الاشتراك',
      'role': 'دور',
      'teacher': 'المعلم',
      'user': 'المستخدم',
      'welcome back': 'مرحبا بكم مرة أخرى',

//
      'name': "اسم",
      "user name" : "اسم المستخدم",
      "have account" : "لديك حساب؟",
      "are you" : "هل أنت؟",
      "error occur" : "حدث خطأ" ,
      "ok" : "موافق",
      "sure" : "الرجاء التأكد من صحة بياناتك",
      "empty" : "من فضلك لا ينبغي أن يكون الحقل فارغا.",

//filter
      "search to": "Search to ...",
      'filter': 'Filter',
      'price': 'Prise',
      'rating': "Rating Greater than",
      'category': "category",
      'certificate': "Certificate in the end",
      'course state': "Course State",
      'skill': 'Skill Required',
      'sort': "Sort by",
      "clear": 'Clear all',
      "apply": "Apply Filter",
      //filter list
      'kurdish': 'Kurdish',
      'english': 'English',
      'arabic': 'Arabic',
      'beginner': 'Beginner',
      'intermediate': 'Intermediate',
      'expert': 'Expert',
      'have': 'have',
      'not': 'not',
      'incamp': 'inCampus',
      'online': 'online',
      'popular': 'Most popular',
      'new': 'new',
      //detail screen
      'hours': 'hours',
      'enroll now': 'Enroll Now',
      'profile': 'profile',
      //info
      'about': 'about',
      'duration': 'duration',
      'create at': 'create at',
      'update at': 'update at',
      //tab detail
      'info': 'Info',
      'video': 'video',
      'review': 'reviews',
      'have other course': 'Have Other Course',
      //review
      'filter review': 'filter review',
      'feedback': 'Feedback',
      'old': 'Old',
      'height rate': 'Height rate',
      'low rate': 'Low rate',
      'review now': 'Review Now',
      'validate': 'please provide value.',
      'your feedback': 'Your Feedback',
      //alert
      'true': 'You enrolled now you can enjoy learning',
      'pending': 'Please wait until the publisher accept',
      'false': 'You are not enroll to this course please enroll first',
      'enroll': 'enroll',
      //favorite
      'favorite': 'Favorite',
      //enroll
      'full name':'Full name',
      'full address':'Full address',
      'phone':'Phone number',
      'way of payment':'way of payment',
      'submit':'submit',
      //drawer
      'Change Mode':'Change Mode',
      'dark Mode':'dark Mode',
      'log out':'log out',
      'My Enrolled course':'My Enrolled course',
      'setting':'settings',
      'contact me with':'contact me with',
      'learn with my other course':"learn with my other course"


    }
  };
}
