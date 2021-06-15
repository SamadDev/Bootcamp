import 'package:bootcamps/Providers/CategoryC.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCategory extends StatelessWidget {
  Widget build(BuildContext context) {
    final category = Provider.of<CourseC>(context).categoryList;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: category
              .map<Widget>((element) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 180,
                      width: 300,
                      decoration: BoxDecoration(
                          color: element.color,
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 30,
                            left: 10,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'GROWUP SKILLS IN',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 12, top: 4),
                                  child: Text(
                                    element.type,
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                                Container(
                                    height: 30,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.play_arrow_sharp,
                                            color: AppTheme.green,
                                          ),
                                          Text(
                                            'View',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Positioned(
                            height: 180,
                            width: 180,
                            right: 0,
                            bottom: 0,
                            child: Image.asset('assets/images/vector2.png'),
                          )
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
