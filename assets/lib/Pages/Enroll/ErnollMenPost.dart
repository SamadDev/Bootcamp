import 'package:bootcamps/Providers/enrollment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:provider/provider.dart';

class EnrollPostScreen extends StatelessWidget {
  static const String route = "/EnrollPostScreen";
  final courseId;

  EnrollPostScreen({this.courseId});

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var address = TextEditingController();
    var phone = TextEditingController();
    final enroll = Provider.of<Enroll>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textFieldWidget("Full Name", context, name, 1),
            textFieldWidget("Full address", context, address, 1),
            textFieldWidget("Phone Number", context, phone, 1),
            textFieldWidget("Phone Number", context, phone, 10, enable: false),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: enroll.enrollState
                  ? CircularProgressIndicator()
                  : FlatButton(
                      color: AppTheme.green,
                      height: 50,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      onPressed: () {
                        enroll.changeState();
                        enroll.postEnroll(
                            context: context,
                            courseId: courseId,
                            address: address.text,
                            name: name.text,
                            phone: phone.text);
                        enroll.changeState();
                      },
                      child: Text(
                        'submit',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget textFieldWidget(String text, context, controller, maxLine,
      {enable = true}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        enabled: enable,
        maxLines: maxLine,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          labelStyle: Theme.of(context).textTheme.headline4,
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.green, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.green, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
