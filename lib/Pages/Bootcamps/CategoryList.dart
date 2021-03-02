import 'package:bootcamps/Providers/BootcampCategory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context).categoryList;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: category
              .map<Widget>((element) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                          color: element.color,
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          element.icon,
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            element.type,
                            style: Theme.of(context).textTheme.button,
                          )
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
