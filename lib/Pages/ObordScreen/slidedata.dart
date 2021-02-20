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

final slideList = [
  Slide(
    imageUrl: 'assets/images/course2.svg',
    title: 'If you want to learn',
    description:
        'Learners’ ideas about their own competence, their values, and the preexisting interests they bring to a particular learning situation all influence motivation.',
  ),
  Slide(
    imageUrl: 'assets/images/course1.svg',
    title: 'why you have to choose us',
    description:
        'Learners’ interest is an important consideration for educators because they can accommodate those interests as they design curricula and select learning resources.',
  ),
  Slide(
    imageUrl: 'assets/images/bootcamp.svg',
    title: 'You have a Course',
    description:
        'You have a course but have not place to put up take it easy you are in the right place.',
  ),
];
