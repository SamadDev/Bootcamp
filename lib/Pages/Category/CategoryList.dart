import 'package:bootcamps/Pages/Category/CategoryScreen.dart';
import 'package:bootcamps/Providers/Category.dart';
import 'package:flutter/material.dart';


class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: category(context)
              .map<Widget>((element) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => CategoryScreen(
                                title: element['title'],
                                id: element['id'],
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: element['color'],
                            borderRadius: BorderRadius.circular(10)),
                        height: 100,
                        width: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              child: element['icon'],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              element['title'],
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
