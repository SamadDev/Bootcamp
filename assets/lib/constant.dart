import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

//EnrollDialog
void enrollDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            title: Center(
                child: Text(
              "Pleas fill info",
              style: Theme.of(context).textTheme.headline4,
            )),
            content: Container(height: 350, width: 300),
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
      height: 45,
      width: 135,
      child: FloatingActionButton(
        elevation: 5,
        onPressed: onTab,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.0),
        ),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
            color: AppTheme.green,
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
                  color: AppTheme.white,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.white,
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
