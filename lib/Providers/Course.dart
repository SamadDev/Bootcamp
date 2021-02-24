import 'dart:convert';

import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CourseData with ChangeNotifier {
  final id;
  final bootcampId;
  final bootcampName;
  final certificate;
  final housing;
  final state;
  final typeSkill;
  final courseLink;
  final title;
  final description;
  final weeks;
  final tuition;
  final minimumSkill;
  final scholarshipAvailable;
  final photo;
  final averageRating;
  final view;
  final user;

  CourseData(
      {this.certificate,
      this.housing,
      this.state,
      this.typeSkill,
      this.courseLink,
      this.id,
      this.user,
      this.bootcampName,
      this.bootcampId,
      this.view,
      this.averageRating,
      this.photo,
      this.title,
      this.description,
      this.weeks,
      this.tuition,
      this.minimumSkill,
      this.scholarshipAvailable});
}

class Course with ChangeNotifier {
  List<CourseData> _course = [];

  List<CourseData> get courseList => _course;

  List<CourseData> _bootcampCourse = [];

  List<CourseData> get bootcampCourse => _bootcampCourse;

  static String error;
  static bool isSuccess;

  // to get the whole course
  Future<void> fitchAllCourse(String state) async {
    if (_course.isNotEmpty) return;
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses?sort=-createdAt",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      print(state);
      final jsonData = jsonDecode(res.body)['data'];
      final List<CourseData> loadCourse = [];
      jsonData.forEach((element) {
        loadCourse.add(
          CourseData(
              id: element['_id'],
              user: element['user'],
              bootcampName: element['bootcamp']['name'],
              bootcampId: element['bootcamp']['_id'],
              photo: element['photo'],
              description: element['description'],
              title: element['title'],
              minimumSkill: element['minimumSkill'],
              scholarshipAvailable: element['scholarshipAvailable'],
              tuition: element['tuition'],
              weeks: element['weeks'],
              view: element['averageView'],
              averageRating: element['averageRating'],
              housing: element['housing'],
              certificate: element['certificate'],
              courseLink: element['courseLink'],
              state: element['state'],
              typeSkill: element['typeSkill']),
        );
      });
      _course = loadCourse;
      notifyListeners();
    } catch (error) {
      print("get all courses error is $error");
    }
  }

  // to get the courses that referring to bootcamp
  Future<void> fitchCoursesRefBootcamp(String bootcampId) async {
    try {
      var res = await http.get(
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses/$bootcampId/courses",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          });
      final jsonData = jsonDecode(res.body)['data'];
      final List<CourseData> loadCourse = [];

      jsonData.forEach((element) {
        loadCourse.add(CourseData(
            bootcampName: element['bootcamp']['name'],
            bootcampId: element['bootcamp']['_id'],
            id: element['_id'],
            photo: element['photo'],
            description: element['description'],
            title: element['title'],
            minimumSkill: element['minimumSkill'],
            scholarshipAvailable: element['scholarshipAvailable'],
            tuition: element['tuition'],
            weeks: element['weeks'],
            view: element['averageView'],
            averageRating: element['averageRating'],
            housing: element['housing'],
            certificate: element['certificate'],
            courseLink: element['courseLink'],
            state: element['state'],
            typeSkill: element['typeSkill']));
      });
      _bootcampCourse = loadCourse;
      notifyListeners();
    } catch (error) {
      print("get course by refer to bootcamp error is $error");
    }
  }

  //to post Course to the to the bootcamp
  Future<void> postCourse(
      {CourseData course, String bootcampId, BuildContext context}) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/courses/$bootcampId/courses',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'title': course.title,
          'photo': course.photo,
          'description': course.description,
          'weeks': course.weeks,
          'tuition': course.tuition,
          'minimumSkill': course.minimumSkill,
          'scholarshipAvailable': course.scholarshipAvailable,
          'housing': course.housing,
          'certificate': course.certificate,
          'courseLink': course.courseLink,
          'state': course.state,
          'typeSkill': course.typeSkill
        }),
      );

      final source = jsonDecode(res.body);
      // print(source);
      print(source['data']);
      error = source['error'];
      isSuccess = source['success'];

      _course.add(CourseData(
          title: source['title'],
          description: source['description'],
          photo: source['photo'],
          tuition: source['tuition'],
          weeks: source['weeks'],
          scholarshipAvailable: source['scholarshipAvailable'],
          minimumSkill: source['minimumSkill'],
          housing: source['housing'],
          certificate: source['certificate'],
          courseLink: source['courseLink'],
          state: source['state'],
          typeSkill: source['typeSkill']));

      if (isSuccess) {
        Navigator.of(context).pushNamed(CourseScreen.route);
      } else {
        showErrorDialog(error, context);
      }
    } catch (error) {
      showErrorDialog(error, context);
    }
    notifyListeners();
  }

  //update Course
  Future<void> updateCourse(
      String courseId, CourseData newCourse, BuildContext context) async {
    try {
      await http.put(
          "https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          },
          body: jsonEncode({
            'title': newCourse.title,
            'photo': newCourse.photo,
            'housing': newCourse.description,
            'jobAssistance': newCourse.weeks,
            'acceptGi': newCourse.tuition,
            'name': newCourse.minimumSkill,
            'description': newCourse.description,
            'scholarshipAvailable': newCourse.scholarshipAvailable,
            'housing': newCourse.housing,
            'certificate': newCourse.certificate,
            'courseLink': newCourse.courseLink,
            'state': newCourse.state,
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
        "https://bootcamp-training-training.herokuapp.com/api/v1/courses/$courseId",
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

  //find course with user id
  List courseWithUserId(String userId) {
    return _course
        .where((element) => element.bootcampId.contains(userId))
        .toList();
  }

  //find course by User Id
  List findC(String id) {
    return _course.where((element) => element.user.contains(id)).toList();
  }

  CourseData findCourseById(String courseId) {
    return _course.firstWhere((element) => element.id == courseId);
  }
}
