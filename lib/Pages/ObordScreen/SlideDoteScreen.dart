import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;

  SlideDots(this.isActive);

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 30),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 3,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.green : AppTheme.black4,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
