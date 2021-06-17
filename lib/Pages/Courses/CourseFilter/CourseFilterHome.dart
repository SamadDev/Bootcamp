import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

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
    print(selectedCategory +
        selectedSort +
        "certificate  " +
        selectedCertificate +
        "min  " +
        selectedMax +
        "max" +
        selectedMin +
        selectedLanguage +
        "state  " +
        selectedState +
        selectedSkill);

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
                              itemCount:course.filterSearch.isEmpty
                                  ? filter.filterProList.length
                                  : course.filterSearch.length,
                              itemBuilder: (ctx, i) =>course.filterSearch.isEmpty?
                              FilterWidget(
                                    data: filter.filterProList[i],
                                  ): FilterWidget(
                                data: filter.filterSearch[i],
                              ),
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.8,
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
          height: 240,
          width: 170,
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
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.orange,
                          strokeWidth: 1,
                        ),
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
                      '${data.tuition.toStringAsFixed(2)} \$',
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


class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Widget build(BuildContext context) {
    final course = Provider.of<Course>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppTheme.black2,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        child: TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            setState(() {
              course.filterSearchFunction(value);
            });
          },
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: LineIcon.search(
                size: 30,
                color: AppTheme.black4,
              ),
              hintText: 'Search to ..',
              hintStyle: Theme.of(context).textTheme.headline6),
        ),
      ),
    );
  }
}
