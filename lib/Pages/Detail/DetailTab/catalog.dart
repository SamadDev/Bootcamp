import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, i) => Card(
                        elevation: 0,
                        color: AppTheme.black2.withOpacity(0.5),
                        child: ListTile(
                          leading: i == 0
                              ? Icon(Icons.play_circle_filled_sharp)
                              : LineIcon.lock(),
                          title: Text(
                            'introduction to flutter and dart',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          trailing: Text('10.5',
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      )),
            ),
            Container(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 160,
                      child: FlatButton(
                        color: AppTheme.green,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          "Enroll Now",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 160,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: AppTheme.green, width: 2)),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 25,
                              color: AppTheme.green,
                            ),
                            Text(
                              "Favorite",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
