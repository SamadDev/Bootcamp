import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/View.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Providers/CourseModule.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MostFilterWidget extends StatelessWidget {
  final CourseModule data;

  MostFilterWidget({this.data});

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    Future<void> getView() async {
      final view = Provider.of<View>(context, listen: false);
      await view.getViews();
      view.getViewCourseFront(courseId: data.id);
      print(view.viewList.length);
    }
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => DetailHomeScreen(id: data.id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(3),
          ),
          height: 260,
          width: 180,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0, right: 2, left: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(2),
                      bottomLeft: Radius.circular(2)),
                  child: CachedNetworkImage(
                    imageUrl: data.photo,height: 145,
                    fit: BoxFit.fill,
                    placeholder: (ctx, snap) => Center(
                      child: Image.asset('assets/images/load.gif'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:3.0,left:3,top:3),
                  child: Text(
                    language.languageCode == 'en'
                        ? data.title
                        : language.languageCode == 'ar'
                            ? data.titleAr
                            : data.titleKr,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 3.0, right: 5, left: 2, ),
                  child: Text(
                    '${data.tuition.toString()} \$',
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0, right: 3, left: 3),
                  child: Row(
                children: [
                  FutureBuilder(
                    future: getView(),
                    builder: (ctx, snap) =>
                        snap.connectionState == ConnectionState.waiting
                            ? Shimmer.fromColors(
                                baseColor: AppTheme.black2,
                                highlightColor: AppTheme.green,
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/view.png',
                                  height: 20,
                                  width: 20,
                                )),
                              )
                            : Row(
                                children: [
                                  Text(
                                    data.view.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2,
                                  ),
                                  Image.asset(
                                    'assets/images/view.png',
                                    color: Theme.of(context).buttonColor,
                                    height: 21,
                                    width: 21,
                                  )
                                ],
                              ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.averageRating == null
                        ? "0"
                        : "${data.averageRating.toStringAsFixed(1)}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(
                    Icons.star,
                    color: Theme.of(context).buttonColor,
                    size: 18,
                  ),
                ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
