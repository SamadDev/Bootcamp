import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/modul/Test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class MostFilterWidget extends StatelessWidget {
  final CourseModule data;

  MostFilterWidget({this.data});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => DetailHomeScreen(id: data.id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.black2,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 250,
          width: 180,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(2),
                        bottomLeft: Radius.circular(2)),
                    child: CachedNetworkImage(
                      imageUrl: data.photo,
                      fit: BoxFit.fill,
                      placeholder: (ctx, snap) => Center(
                        child: Image.asset('assets/images/load.gif'),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      data.title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      '${data.tuition.toString()} \$',
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 1,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Text(
                            data.view == null ? "0" : "${data.view}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Icon(
                            Icons.visibility,
                            color: AppTheme.black4,
                            size: 18,
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
                            color: AppTheme.black4,
                            size: 18,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
