import 'package:bootcamps/Localization/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//show authentication alert

void showErrorDialog(String message, context) {
  final language=Provider.of<Language>(context,listen:false);
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        language.words['error occur'],
        style: Theme.of(context).textTheme.headline3,
      ),
      content: Text(
       language.words['sure'],
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(language.words['ok']),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}

//show if field is empty
void showEmpty(context) {
  final language=Provider.of<Language>(context,listen:false);
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(backgroundColor: Theme.of(context).cardColor,
            title: Text(language.words['error occur']),
            content: Text(language.words['empty']),
            contentTextStyle: Theme.of(context).textTheme.bodyText1,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(language.words['ok']))
            ],
          ));
}
