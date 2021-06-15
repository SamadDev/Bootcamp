import 'dart:convert';

import 'package:bootcamps/Pages/Courses/CourseMy.dart';
import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/modul/Test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseData with ChangeNotifier {
  final id;
  final certificate;
  final housing;
  final state;
  final typeSkill;
  final link;
  final title;
  final description;
  final weeks;
  final tuition;
  final minimumSkill;
  final photo;
  final averageRating;
  final view;
  final user;
  final videoPath;
  final language;
  final videos;

  CourseData(
      {this.certificate,
      this.housing,
      this.state,
      this.typeSkill,
      this.link,
      this.id,
      this.user,
      this.view,
      this.averageRating,
      this.photo,
      this.title,
      this.description,
      this.weeks,
      this.tuition,
      this.minimumSkill,
      this.videos,
      this.videoPath,
      this.language});
}

class Course with ChangeNotifier {
  String url =
      'https://bootcamp-training-training.herokuapp.com/api/v1/courses';
  List<CourseData> _course = [];

  List<CourseData> get courseList => _course;

  List<CourseData> _bootcampCourse = [];

  List<CourseData> get bootcampCourse => _bootcampCourse;

  static String error;
  static bool isSuccess;
  List filterProList = [];

  // to get the whole course
  Future<void> fetchFilter(
      {category,
      pMin,
      pMax,
      sort,
      rating,
      state,
      certificate,
      language}) async {
    try {
      var res = await http.get(
          "$url?sort=-$sort&tuition[gte]=$pMin&tuition[lte]=$pMax&typeSkill=$category&certificate=${certificate == false ? '' : certificate}&state=$state",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];
      List jsonList = jsonData.map((e) => Test.fromJson(e)).toList();
      filterProList = jsonList;
      notifyListeners();
    } catch (error) {
      print("get filter courses error is $error");
    }
  }

  //______________________________________________________
  Future<void> fitchAllCourse({reload = false}) async {
    if (_course.isNotEmpty) {
      if (reload == false) return;
    }

    try {
      var res = await http.get(url, headers: {
        "Content-Type": "Application/json",
      });
      final jsonData = jsonDecode(res.body)['data'];
      final List<CourseData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          CourseData(
              id: element['_id'],
              user: element['user'],
              photo: element['photo'],
              description: element['description'],
              title: element['title'],
              minimumSkill: element['minimumSkill'],
              tuition: element['tuition'],
              weeks: element['weeks'].toString(),
              view: element['averageView'],
              averageRating: element['averageRating'],
              housing: element['housing'],
              certificate: element['certificate'],
              state: element['state'],
              typeSkill: element['typeSkill'],
              language: element['language'],
              videoPath: element['videoPath'],
              videos: element['cVideos']),
        );
      });
      _course = loadCourse;
      notifyListeners();
    } catch (error) {
      print("get all courses error is $error");
    }
  }

  Future<void> postCourse(
      {CourseData course,
      userId,
      title,
      photo,
      weeks,
      tuition,
      minimumSkill,
      housing,
      certificate,
      link,
      state,
      category,
      description,
      videoPath,
      language,
      videos,
      BuildContext context}) async {
    print(description);
    print(videos);
    try {
      var res = await http.post(
        '$url/$userId/courses',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'title': title,
          'photo': photo,
          'description': description,
          'weeks': weeks,
          'tuition': tuition,
          'minimumSkill': minimumSkill,
          'housing': housing,
          'certificate': certificate,
          'link': "course.link",
          'state': "online",
          'typeSkill': category,
          "language": language,
          "cVideos": videos,
          "videoPath": videoPath
        }),
      );
      final source = jsonDecode(res.body);
      print(source);
      print(source['data']);
      error = source['error'];
      isSuccess = source['success'];

      _course.add(CourseData(
          title: source['title'],
          description: source['description'],
          photo: source['photo'],
          videos: source['cVideos'],
          videoPath: source['videoPath'],
          tuition: source['tuition'],
          weeks: source['weeks'],
          minimumSkill: source['minimumSkill'],
          housing: source['housing'],
          certificate: source['certificate'],
          link: source['link'],
          language: source['language'],
          state: source['state'],
          typeSkill: source['typeSkill']));

      if (isSuccess) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MyCourse()));
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      showErrorDialog(error, context);
      print(error);
    }
    notifyListeners();
  }

  //update Course
  Future<void> updateCourse(
      String courseId, CourseData newCourse, BuildContext context) async {
    try {
      await http.put("$url/$courseId",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          },
          body: jsonEncode({
            'title': newCourse.title,
            'photo': newCourse.photo,
            'housing': newCourse.housing,
            'weeks': newCourse.weeks,
            'tuition': newCourse.tuition,
            'minimumSkill': newCourse.minimumSkill,
            'description': newCourse.description,
            'certificate': newCourse.certificate,
            'link': newCourse.link,
            'state': newCourse.state,
            'videoPath': newCourse.videoPath,
            'typeSkill': newCourse.typeSkill
          }));
      final bootcampIndex =
          _course.indexWhere((element) => element.id == courseId);
      _course[bootcampIndex] = newCourse;

      if (isSuccess) {
        Navigator.of(context).pushNamed(CourseScreen.route);
      } else {
        showErrorDialog(error, context);
      }
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
    }
  }

  //delete Course
  Future<void> deleteCourse(String courseId, BuildContext context) async {
    try {
      await http.delete(
        "$url/$courseId",
        headers: {
          "Content-Type": "Application/json",
          "Authorization": "Bearer ${Auth.token}",
        },
      );
      final bootcampIndex = _course
          .indexWhere((element) => element.id == courseId); //to find index
      _course.removeAt(bootcampIndex);

      if (isSuccess) {
        Navigator.of(context).pushNamed(CourseScreen.route);
      } else {
        showErrorDialog(error, context);
      }
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
    }
  }

  List<CourseData> userCourse = [];

  //find course with user id
  List<CourseData> courseWithUserId(String userId) {
    userCourse = _course.where((element) => element.user == userId).toList();
    return userCourse;
  }

  //find course by the course Id
  CourseData findCourseById(String courseId) {
    return _course.firstWhere((element) => element.id == courseId);
  }

  //make category a group by title
  List findCategory(String title) {
    return _course.where((element) => element.typeSkill == title).toList();
  }

  //search to course
  List<CourseData> search = [];

  void searchCourse(String value) {
    search = _course.where((course) {
      return course.title.contains(value);
    }).toList();
    notifyListeners();
  }

  List<CourseData> filterSearch = [];

  void filterSearchFunction(String value) {
    filterSearch = filterProList.where((course) {
      return course.title.contains(value);
    }).toList();
    notifyListeners();
  }

  //search to category course
  List<CourseData> cateSearch = [];

  void cateSearchCourse(String value, List search) {
    cateSearch = search.where((course) {
      return course.title.contains(value);
    }).toList();
    if (cateSearch.isEmpty) cateSearch = [];
    notifyListeners();
  }
}
