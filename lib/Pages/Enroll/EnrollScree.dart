import 'package:bootcamps/Providers/enroll%20message.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Style/style.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrollMenScreen extends StatelessWidget {
  static const String route = 'enrollScreen';

  Widget build(BuildContext context) {
    final enroll = Provider.of<Enroll>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: enroll.fitchEnroll(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else
            return Consumer<Enroll>(
                builder: (context, enroll, _) => ListView.builder(
                    itemCount: enroll.enrollList.length,
                    itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                        value: enroll.enrollList[index],
                        child: EnrollWidget(
                          data: enroll.enrollList[index],
                        ))));
        },
      ),
    );
  }
}

class EnrollWidget extends StatelessWidget {
  final EnrollData data;

  EnrollWidget({this.data});

  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    final update = Provider.of<Enroll>(context, listen: false);
    final message = Provider.of<MessageEnroll>(context, listen: false);
    return Card(
      child: Container(
        height: 100,
        child: ListTile(
          title: Text(
            data.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          subtitle: Text(
            '${data.name} enroll to ${data.courseTitle} can you accepted',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          trailing: data.isVerify
              ? Container(
                  height: 28,
                  width: 95,
                  decoration: BoxDecoration(
                      color: AppTheme.black2,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: Text(
                      'accepted ✔',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(
                              text: 'accept',
                              context: context,
                              title: "are you sure",
                              child: Text(
                                'Are you sure you want to let ${data.name} to enroll ${data.courseTitle}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              onPress: () {
                                message.postMessageEnroll(
                                    context: context,
                                    enrollId: data.id,
                                    message:
                                        'congratulation,you enrolled to ${data.courseTitle}');
                                update.updateEnroll(
                                    newIsVerify: true, enrollId: data.id);
                                Navigator.of(context).pop();
                              });
                        },
                        child: Icon(
                          Icons.check,
                          color: AppTheme.green,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(
                              text: "send",
                              context: context,
                              title:
                                  "kindly let ${data.name} know why didn\'n accept",
                              child: TextField(
                                controller: messageController,
                              ),
                              onPress: () {
                                update.deleteEnroll(data.id, context);
                                message.postMessageEnroll(
                                    context: context,
                                    enrollId: data.id,
                                    message: messageController.text);
                                Navigator.of(context).pop();
                              });
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: AppTheme.deleteButton,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

// ShowDialog of Delete and update
void _showDialog({context, String title, child, Function onPress, text}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppTheme.black2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: new Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        content: child,
        actions: <Widget>[
          FlatButton(
            child: new Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            onPressed: onPress,
            child: Text(text),
          )
        ],
      );
    },
  );
}

//edit and delete button of
class _ChipButtonWidget extends StatelessWidget {
  final Function onPress1;
  final Function onPress2;
  final String text1;
  final String text2;
  final Color color1;
  final Color color2;

  const _ChipButtonWidget(
      {this.onPress1,
      this.onPress2,
      this.text1,
      this.text2,
      this.color1,
      this.color2});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15),
      child: Container(
        width: 280,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
                backgroundColor: color1,
                label: Text(text1),
                labelStyle: TextStyle(color: Colors.white),
                onPressed: onPress1),
            Spacer(),
            ActionChip(
                backgroundColor: color2,
                label: Text(text2),
                labelStyle: TextStyle(color: Colors.white),
                onPressed: onPress2),
          ],
        ),
      ),
    );
  }
}
