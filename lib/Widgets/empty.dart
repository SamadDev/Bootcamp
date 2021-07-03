import "package:flutter/material.dart";

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(
        "assets/images/empty.gif",
        fit: BoxFit.fill,
      ),
    );
  }
}
