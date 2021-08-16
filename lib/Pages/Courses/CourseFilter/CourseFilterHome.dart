import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/View.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CourseFilterHome extends StatelessWidget {
  static const router = '/CourseFilterHome';
  final selectedSort;
  final selectedLanguage;
  final selectedSkill;
  final selectedCategory;
  final selectedMax;
  final selectedMin;
  final selectedCertificate;
  final selectedState;
  final selectedRating;

  CourseFilterHome(
      {this.selectedSort,
      this.selectedRating,
      this.selectedCategory,
      this.selectedSkill,
      this.selectedCertificate,
      this.selectedLanguage,
      this.selectedMax,
      this.selectedMin,
      this.selectedState});

  @override
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: AppTheme.black2,
                    borderRadius: BorderRadius.circular(60)),
                child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            SearchWidget(),
            Expanded(
              child: FutureBuilder(
                  future: course.fetchFilter(
                      category: selectedCategory,
                      language: selectedLanguage,
                      state: selectedState,
                      skill: selectedSkill,
                      pMin: selectedMin,
                      pMax: selectedMax,
                      sort: selectedSort,
                      certificate: selectedCertificate,
                      rating: selectedRating),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.orange,
                          strokeWidth: 1,
                        ),
                      );
                    } else
                      return Consumer<Course>(
                          builder: (context, filter, _) => GridView.builder(
                                itemCount: course.filterSearch.isEmpty
                                    ? filter.filterProList.length
                                    : course.filterSearch.length,
                                itemBuilder: (ctx, i) =>
                                    course.filterSearch.isEmpty
                                        ? FilterWidget(
                                            data: filter.filterProList[i],
                                          )
                                        : FilterWidget(
                                            data: filter.filterSearch[i],
                                          ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.72,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                              ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  final CourseData data;

  FilterWidget({this.data});

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    Future<void> getView() async {
      print(data.id);
      final view = Provider.of<View>(context, listen: false);
      await view.getViews();
      view.getViewCourseFront(courseId: data.id);
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
                    imageUrl: data.photo,
                    height: 145,
                    fit: BoxFit.fill,
                    placeholder: (ctx, snap) => Center(
                      child: Image.asset('assets/images/load.gif'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3.0, left: 3, top: 3),
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
                    bottom: 3.0,
                    right: 5,
                    left: 2,
                  ),
                  child: Text(
                    '${data.tuition.toString()} \$',
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 3.0, right: 3, left: 3),
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

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final course = Provider.of<Course>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            setState(() {
              course.filterSearchFunction(value, course);
            });
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: LineIcon.search(
                size: 30,
                color: Theme.of(context).buttonColor,
              ),
              hintText: language.words['search to'],
              hintStyle: Theme.of(context).textTheme.headline6),
        ),
      ),
    );
  }
}
