import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrollScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
      child: Column(
        children: [
          textFieldWidget("Full Name"),
          textFieldWidget("Full address"),
          textFieldWidget("Phone Number")
        ],
      ),
    ));
  }

  Widget textFieldWidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: text,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.5),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
        ),
      ),
    );
  }
}
