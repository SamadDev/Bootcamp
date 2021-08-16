import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/enrollment.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/NotFound.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnrollMyCourse extends StatelessWidget {
  static const route = "/EnrollMyCourse";

  Widget build(BuildContext context) {
    Future<void> getEnroll() async {
      final enroll = Provider.of<Enroll>(context, listen: false);
      await enroll.fitchEnroll(context: context);
      enroll.myEnroll(userId: Profile.userId);

    }
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
      ),
      body: FutureBuilder(
          future: getEnroll(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: circleProgress());
            } else
              return Consumer<Enroll>(
                  builder: (context, enroll, _) =>enroll.myEnrollList.isEmpty? NotFoundScreen():GridView.builder(
                      itemCount: enroll.myEnrollList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => DetailHomeScreen(
                                        id: enroll.myEnrollList[i].course.sId,
                                      )));
                            },
                            child: GridTile(
                                footer: GridTileBar(
                                  backgroundColor: AppTheme.black2,
                                  title: Text(
                                    enroll.myEnrollList[i].course.title,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: enroll.myEnrollList[i].course.photo,fit: BoxFit.cover,
                                  placeholder: (ctx, snap) =>
                                      Image.asset('assets/images/load.gif'),
                                )),
                          )));
          }),
    );
  }
}
