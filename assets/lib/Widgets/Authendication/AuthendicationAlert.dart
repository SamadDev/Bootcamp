import 'package:bootcamps/Providers/state.dart';
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
        style: Theme.of(context).textTheme.headline3,
      ),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () {
            Provider.of<StateChange>(context, listen: false).changeIsLoading();
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}

//show if field is empty
void showEmpty(context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text('error occur'),
            content: Text('all fields required pleas provider'),
            contentTextStyle: Theme.of(context).textTheme.bodyText1,
            titleTextStyle: Theme.of(context).textTheme.headline3,
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('ok'))
            ],
          ));
}
