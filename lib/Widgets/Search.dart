import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/AllCourses.dart';
import 'package:bootcamps/Pages/Courses/CourseSearch.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen:false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CourseSearch.route);
      },
      child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)),
          height: 45,
          child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                enabled: false,
                disabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: AppTheme.black3.withOpacity(0.3))),
                contentPadding: EdgeInsets.only(top: 7, right: 7),
                hintText: language.words['search to'],
                hintStyle: Theme.of(context).textTheme.subtitle2,
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: Theme.of(context).buttonColor,
                ),
              ))),
    );
  }
}
