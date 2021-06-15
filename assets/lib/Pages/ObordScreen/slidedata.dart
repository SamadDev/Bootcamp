import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final onBoardList = [
  Slide(
    imageUrl: 'assets/images/student.png',
    title: 'Learn anywhere anytime',
    description: 'Take any course anytime anywhere as much as you like.',
  ),
  Slide(
    imageUrl: 'assets/images/students.png',
    title: 'make happy with learn',
    description: 'make happy learn special see new technics',
  ),
  Slide(
      imageUrl: 'assets/images/teachers.png',
      title: 'make students happy',
      description: "Make student happy by building new and best courses"),
];
