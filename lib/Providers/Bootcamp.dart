import 'dart:convert';

import 'package:bootcamps/Pages/Bootcamps/BootcampsScreen.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BootcampData with ChangeNotifier {
  final careers;
  final county;
  final photo;
  final image;
  final name;
  final description;
  final website;
  final phone;
  final email;
  final address;
  final user;
  final createdAt;
  final slug;
  final version;
  final averageCost;
  final courses;
  final lat;
  final log;
  final id;

  BootcampData({
    this.county,
    this.careers,
    this.photo,
    this.image,
    this.name,
    this.description,
    this.website,
    this.phone,
    this.email,
    this.address,
    this.user,
    this.createdAt,
    this.slug,
    this.version,
    this.averageCost,
    this.courses,
    this.lat,
    this.log,
    this.id,
  });
}

class BootCamp with ChangeNotifier {
  List<BootcampData> _bootcamp = [];

  List<BootcampData> get bootcampList => _bootcamp;

  static bool isSuccess = true;
  static int bootcampCount;
  static String error;
  static String bootcampId;

  //to get BootCamps from the database
  Future<void> fitchBootcamp() async {
    if (_bootcamp.isNotEmpty) return;
    try {
      var res = await http.get(
        "https://bootcamp-training-training.herokuapp.com/api/v1/bootcamps",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
      );

      bootcampCount = jsonDecode(res.body)['count'];
      isSuccess = jsonDecode(res.body)['success'];
      final List jsonData = jsonDecode(res.body)['data'];

      final List<BootcampData> loadData = [];

      jsonData.forEach((index) {
        loadData.add(
          BootcampData(
              careers: index['careers'],
              photo: index['photo'],
              name: index['name'],
              description: index['description'],
              website: index['website'],
              phone: index['phone'],
              email: index['email'],
              address: index['address'],
              user: index['user'],
              createdAt: index['createdAt'],
              slug: index['slug'],
              version: index['__v'],
              averageCost: index["averageCost"],
              courses: index["courses"],
              county: index['county'],
              lat: index['lat'],
              log: index['log'],
              id: index['_id']),
        );
      });
      _bootcamp = loadData;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //to post BootCamps to the database
  Future<void> postBootcamp(BootcampData bootcamp, BuildContext context) async {
    try {
      var res = await http.post(
        'https://bootcamp-training-training.herokuapp.com/api/v1/bootcamps',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${Auth.token}"
        },
        body: jsonEncode({
          'careers': bootcamp.careers,
          'photo': bootcamp.photo,
          'name': bootcamp.name,
          'description': bootcamp.description,
          'website': bootcamp.website,
          'phone': bootcamp.phone,
          'email': bootcamp.email,
          'address': bootcamp.address,
          'county': bootcamp.county,
          'lat': bootcamp.lat,
          'log': bootcamp.log
        }),
      );

      final source = jsonDecode(res.body);
      error = source['error'];
      isSuccess = source['success'];

      _bootcamp.add(BootcampData(
          phone: source['phone'],
          careers: source['careers'],
          name: source['name'],
          address: source['address'],
          averageCost: source['averageCost'],
          description: source['description'],
          county: source['county'],
          email: source['email'],
          photo: source['photo'],
          website: source['website'],
          lat: source['lat'],
          log: source['log']));

      if (isSuccess) {
        Navigator.of(context).pushNamed(BootcampsScreen.route);
      } else {
        showErrorDialog(error, context);
      }
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
    }
    changeIsLoading();
  }

  //update bootcamp
  Future<void> updateBootcamp(
      String bootcampId, BootcampData newBootcamp, BuildContext context) async {
    try {
      await http.patch(
          "https://bootcamp-training-training.herokuapp.com/api/v1/bootcamps/$bootcampId",
          headers: {
            "Content-Type": "Application/json",
            "Authorization": "Bearer ${Auth.token}"
          },
          body: jsonEncode({
            'careers': newBootcamp.careers,
            'photo': newBootcamp.photo,
            'name': newBootcamp.name,
            'description': newBootcamp.description,
            'website': newBootcamp.website,
            'phone': newBootcamp.phone,
            'email': newBootcamp.email,
            'county': newBootcamp.county,
            'address': newBootcamp.address,
            'lat': newBootcamp.lat,
            'log': newBootcamp.log
          }));
      final bootcampIndex =
          _bootcamp.indexWhere((element) => element.id == bootcampId);
      _bootcamp[bootcampIndex] = newBootcamp;
      if (isSuccess) {
        Navigator.of(context).pushNamed(BootcampsScreen.route);
      } else {
        showErrorDialog(error, context);
      }
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
    }
  }

  //delete bootcamp
  Future<void> deleteBootcamp(String id, BuildContext context) async {
    try {
      await http.delete(
        "https://bootcamp-training-training.herokuapp.com/api/v1/bootcamps/$id",
        headers: {
          "Content-Type": "Application/json",
          "Authorization": "Bearer ${Auth.token}",
        },
      );
      final bootcampIndex =
          _bootcamp.indexWhere((element) => element.id == id); //to find index
      _bootcamp.removeAt(bootcampIndex);

      if (isSuccess) {
        Navigator.of(context).pushNamed(BootcampsScreen.route);
      } else {
        showErrorDialog(error, context);
      }
      notifyListeners();
    } catch (error) {
      showErrorDialog(error, context);
    }
  }

//find bootcamp by user id
  BootcampData findBootWithUserId(String userId) {
    var bootcampIndex =
        _bootcamp.indexWhere((element) => element.user == userId);
    return _bootcamp.elementAt(bootcampIndex);
    // return _bootcamp.indexWhere((element) => element.id==bootcampId);
  }

  //find by bootcampId
  BootcampData findById(String bootcampId) {
    var bootcampIndex =
        _bootcamp.indexWhere((element) => element.id == bootcampId);
    return _bootcamp.elementAt(bootcampIndex);

    // return _bootcamp.indexWhere((element) => element.id==bootcampId);
  }

  //loading state
  bool isLoading = false;

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }
}
