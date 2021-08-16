import 'package:bootcamps/Providers/enrollment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Localization/language.dart';

class EnrollPostScreen extends StatelessWidget {
  static const String route = "/EnrollPostScreen";
  final courseId;

  EnrollPostScreen({this.courseId});

  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false).words;

    final enroll = Provider.of<Enroll>(context, listen: false);
    final isLoading = Provider.of<Enroll>(context);
    return isLoading.isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).cardColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  textFieldWidget(language['full name'],language['full name'], context, name, 1,TextInputType.name),
                  textFieldWidget(
                      language['full address'],language['full address'],context, address, 1,TextInputType.streetAddress),
                  textFieldWidget(language['phone'], language['phone'],context, phone, 1,TextInputType.phone),
                  textFieldWidget(
                      language['way of payment'],language['way of payment'],context, phone, 10,TextInputType.name,
                      enable: false),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlatButton(
                      color: AppTheme.green,
                      height: 50,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                      onPressed: () {
                        enroll.postEnroll(
                            context: context,
                            courseId: courseId,
                            address: address.text,
                            name: name.text,
                            phone: phone.text);
                      },
                      child: Text(
                        language['submit'],
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget textFieldWidget(String text, label,context, controller, maxLine,type,
      {enable = true}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        enabled: enable,
        maxLines: maxLine,
        textInputAction: TextInputAction.next,
        controller: controller,keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          hintText: text,
          hintStyle: Theme.of(context).textTheme.headline4,
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
          disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).cardColor, width: 1.0),
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
