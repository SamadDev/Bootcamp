import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'file:///C:/Users/FENGS/AndroidStudioProjects/bootcamps/lib/Pages/Courses/CourseEnrollScreen.dart';

Widget dropDownWidget(
    {List list, Function function, String label, String valueIni}) {
  return DropdownButtonFormField(
    decoration: textFormField(label, label),
    onChanged: function,
    value: valueIni,
    items: list
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList(),
  );
}

Widget dropDownButton({List list, Function function, String select}) {
  return Container(
    width: 150,
    child: DropdownButton(
      elevation: 0,
      underline: SizedBox.shrink(),
      onChanged: function,
      value: select,
      items: list
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
    ),
  );
}

//text info of courseDetailScreen
Widget courseInfoText(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 1, top: 3),
    child: Text(
      text,
      style: GoogleFonts.adventPro(fontSize: 20, color: Colors.black87),
    ),
  );
}

Widget topTextOfCourseDetailScreen(text) {
  return Padding(
    padding: const EdgeInsets.only(
      right: 10,
      left: 10,
      top: 15,
    ),
    child: Text(text,
        style: GoogleFonts.adventPro(
          backgroundColor: Colors.black12,
          fontSize: 19,
        )),
  );
}

//text info of courseDetailScreen
Widget courseText(String text) {
  return Text(
    text,
    style: GoogleFonts.adventPro(fontSize: 15, color: Colors.black87),
  );
}

//CourseDetailScreen button
Widget gestureDetectorWidget({Function function, String text, double width}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 15),
    child: GestureDetector(
      onTap: function,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          text,
          style: GoogleFonts.sourceSerifPro(
              fontWeight: FontWeight.bold, fontSize: 20),
        )),
      ),
    ),
  );
}

//EnrollDialog
void enrollDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text(
              "Pleas fill info",
              style: Theme.of(context).textTheme.subtitle1,
            )),
            actions: [
              FlatButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.send),
                color: Colors.lightBlueAccent,
                label: Text("Send"),
              )
            ],
            content: Container(height: 220, width: 300, child: EnrollScreen()),
          ));
}

InputDecoration textFormField(String text, String label) {
  return InputDecoration(
    hintText: text,
    labelText: label,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );
}

//Icons design
class IconsWidget extends StatelessWidget {
  final IconData iconImg;
  final Color iconColor;
  final Color conBackColor;
  final Function() onBtnTap;

  IconsWidget({
    @required this.iconImg,
    @required this.iconColor,
    this.conBackColor,
    this.onBtnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onBtnTap();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: conBackColor,
          border: Border.all(
            color: Colors.grey[200],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          iconImg,
          color: iconColor,
        ),
      ),
    );
  }
}

//FloatingWidget
class FloatingWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String txt;
  final Function onTab;

  FloatingWidget({this.leadingIcon, this.txt, this.onTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      child: FloatingActionButton(
        elevation: 5,
        onPressed: onTab,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.0),
        ),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 300.0,
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  leadingIcon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
