import 'package:bootcamps/Pages/ObordScreen/slidedata.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 300,
          width: double.infinity,
          child: Image.asset(
            onBoardList[index].imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          height: 200,
        ),
        Text(
          onBoardList[index].title,
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          onBoardList[index].description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
