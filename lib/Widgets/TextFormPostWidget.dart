import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';


class TextFormPostWidget extends StatelessWidget {
  TextFormPostWidget(
      {this.controller,
      this.validation,
        this.pText,
      this.keyBoard,
      this.hinText,
      this.labelText,
      this.textInputAction});

  final keyBoard;
  final validation;
  final pText;
  final controller;
  final hinText;
  final labelText;
  final textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(

          textInputAction: textInputAction,
          keyboardType: keyBoard,
          controller: controller,
          decoration: InputDecoration(
            suffixText: pText,
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.deleteButton)),
              hintText: hinText,
              hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).buttonColor.withOpacity(0.5)),
              labelText: labelText,
              contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              // isDense: true,

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: Theme.of(context).buttonColor))),
          validator: validation),
    );
  }
}

// class TextDropDownWidget extends StatelessWidget {
//   TextDropDownWidget(
//       {this.hinText,
//       this.labelText,
//       this.validation,
//       this.items,
//       this.function,
//       this.value,
//       this.onTap});
//
//   final List<DropdownMenuItem>? items;
//   final function;
//   final value;
//   final validation;
//   final hinText;
//   final labelText;
//   final onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: DropdownButtonFormField(
//         validator: validation,
//         onTap: onTap,
//         value: value,
//         onChanged: function,
//         items: items,
//         decoration: InputDecoration(
//             errorBorder:
//                 OutlineInputBorder(borderSide: BorderSide(color: AppTheme.red)),
//             hintText: hinText,
//             hintStyle:
//                 textTheme(context).subtitle2!.copyWith(color: AppTheme.grey700),
//             labelText: labelText,
//             contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(3),
//                 borderSide: BorderSide(color: AppTheme.grey700))),
//       ),
//     );
//   }
// }

// class TextFormAuthWidget extends StatelessWidget {
//   TextFormAuthWidget(
//       {this.controller,
//       this.icon,
//       this.validation,
//       this.keyBoard,
//       this.hinText,
//       this.labelText,
//       this.textInputAction});
//
//   final keyBoard;
//   final icon;
//   final validation;
//   final controller;
//   final hinText;
//   final labelText;
//   final textInputAction;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: TextFormField(
//           textInputAction: textInputAction,
//           keyboardType: keyBoard,
//           controller: controller,
//           decoration: InputDecoration(
//               prefixIcon: Icon(icon),
//               errorBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppTheme.red)),
//               hintText: hinText,
//               hintStyle: textTheme(context)
//                   .subtitle2!
//                   .copyWith(color: AppTheme.grey700),
//               labelText: labelText,
//               contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
//               // isDense: true,
//
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(3),
//                   borderSide: BorderSide(color: AppTheme.grey700))),
//           validator: validation),
//     );
//   }
// }
