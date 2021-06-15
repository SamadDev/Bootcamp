import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppTheme.black2,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            setState(() {
              course.searchCourse(value);
            });
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: LineIcon.search(
                size: 30,
                color: AppTheme.black4,
              ),
              hintText: 'Search to ..',
              hintStyle: Theme.of(context).textTheme.headline6),
        ),
      ),
    );
  }
}
