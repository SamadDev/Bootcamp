import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

class InfoScree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          _caption(
              text: 'about',
              icon: Icons.error_outline_outlined,
              context: context),
          _textBody(
              text:
                  "Welcome to the Complete Flutter App Development Bootcamp with Dart - created in collaboration with the Google Flutter team.Covering all the fundamental concepts for Flutter development,We built this course over months,",
              context: context),
          _caption(
              text: 'duration',
              icon: Icons.access_time_rounded,
              context: context),
          _textBody(text: '10 Hoarse', context: context),
          _caption(text: 'Language', icon: Icons.language, context: context),
          _textBody(text: 'English', context: context),
        ],
      ),
    );
  }
}

Widget _caption({icon, text, context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 5.0, top: 15),
    child: Wrap(
      spacing: 5,
      direction: Axis.horizontal,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.black1.withOpacity(0.5),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        )
      ],
    ),
  );
}

Widget _textBody({text, context}) {
  return Padding(
    padding: EdgeInsets.only(
      top: 5,
      left: 37,
      right: 10,
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    ),
  );
}
