import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/CourseModule.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoScree extends StatelessWidget {
  final CourseData data;
  InfoScree({this.data});
  @override
  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen:false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          _caption(
              text: language.words['about'],
              icon: Icons.error_outline_outlined,
              context: context),
          _textBody(
              text:
              language.languageCode == 'en'
                  ? data.description
                  : language.languageCode == 'ar'
                  ? data.descriptionAr
                  : data.descriptionKr,
              context: context),
          _caption(
              text: language.words['duration'],
              icon: Icons.access_time_rounded,
              context: context),
          _textBody(text: '${data.weeks} ${language.words['hours']}', context: context),
          _caption(text: language.words['language'], icon: Icons.language, context: context),
          _textBody(text: data.language, context: context),

          _caption(text: language.words['create at'], icon: Icons.access_time_outlined, context: context),
          _textBody(text: "2020-22-2", context: context),
          _caption(text: language.words['update at'], icon: Icons.access_time_outlined, context: context),
          _textBody(text: '2021-12-12', context: context),

        ],
      ),
    );
  }
}

Widget _caption({icon, text, context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 7, right: 7.0, top: 15),
    child: Wrap(
      spacing: 5,
      direction: Axis.horizontal,
      children: [
        Icon(
          icon,
          size: 20,
          color:Theme.of(context).buttonColor.withOpacity(0.5),
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
      right: 15,
      bottom: 5
    ),
    child: Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    ),
  );
}
