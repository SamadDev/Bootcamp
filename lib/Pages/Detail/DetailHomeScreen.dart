import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

import 'DetailTab/DetailTabScree.dart';

class DetailHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 280,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: AppTheme.green.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(60)),
                  child: Icon(
                    Icons.play_arrow,
                    size: 30,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 5, left: 15.0, top: 15, bottom: 10),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 10,
                children: [
                  Text(
                    'The Complete 2021 Flutter Development Bootcamp with Dart',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    children: [
                      Text(
                        '21 hours',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        width: 10,
                        child: Text(
                          '|',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Text(
                        '2k view',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  Text(
                    '\$15.00',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 10,
              children: [
                Divider(
                  thickness: 2,
                ),
                Container(
                  color: AppTheme.black2,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.zero,
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              'https://pbs.twimg.com/profile_images/1213052345606639616/SWxoF4Rm_400x400.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Samad Shukr',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              '1.2K Followers',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          height: 30,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppTheme.green),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 15,
                                color: AppTheme.green,
                              ),
                              Text(
                                'Follow',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 400, child: DetailTabScree()),
          ],
        ),
      ),
    );
  }
}
