import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//show authentication alert
void showErrorDialog(String message, context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'An Error Occurred!',
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Provider.of<BootCamp>(context, listen: false).changeIsLoading();
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
