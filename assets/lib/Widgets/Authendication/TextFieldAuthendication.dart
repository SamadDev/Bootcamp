import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

Widget textAuthendication({text, context}) {
  return Text(
    text,
    style: Theme.of(context).textTheme.headline1,
  );
}

// Widget textField(
//     BuildContext context, controller, String hintText, Icon icon, keyboardInput,
//     {suffixIcon}) {
//   return Padding(
//     padding:
//         const EdgeInsets.only(left: 20, right: 20, top: 12.0, bottom: 12.0),
//     child: Container(
//       height: 60,
//       decoration: BoxDecoration(
//           color: AppTheme.black2, borderRadius: BorderRadius.circular(60)),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextField(
//           maxLines: 2,
//           controller: controller,
//           keyboardType: keyboardInput,
//           decoration: InputDecoration(
//               border: InputBorder.none,
//               icon: icon,
//               hintText: hintText,
//               hintStyle: Theme.of(context).textTheme.headline6,
//               suffixIcon: suffixIcon),
//         ),
//       ),
//     ),
//   );
// }

Widget textField(context, hintText, icon, keyboardInput,
    {textCont, iconButton, isObscure}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 60,
      padding: EdgeInsets.only(top: 6, left: 20, right: 10, bottom: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppTheme.black2,
          boxShadow: [BoxShadow(color: AppTheme.black3, blurRadius: 1)]),
      child: TextField(
        obscureText: isObscure,
        style: Theme.of(context).textTheme.headline4,
        maxLines: 1,
        keyboardType: keyboardInput,
        controller: textCont,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.headline6,
          suffixIcon: iconButton,
          border: InputBorder.none,
          icon: Icon(
            icon,
            size: 20,
          ),
          hintText: hintText,
        ),
      ),
    ),
  );
}
