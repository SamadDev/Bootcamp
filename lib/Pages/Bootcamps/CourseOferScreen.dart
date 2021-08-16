import 'dart:async';
import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/circleProgress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BootcampOfferScreen extends StatefulWidget {
  @override
  _BootcampOfferScreenState createState() => _BootcampOfferScreenState();
}

class _BootcampOfferScreenState extends State<BootcampOfferScreen> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    final list = Provider.of<Course>(context, listen: false);
    list.fitchAllCourse();
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < list.courseList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideList = Provider.of<Course>(context, listen: false);
    final language = Provider.of<Language>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
      future: slideList.fitchAllCourse(reload: false),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: circleProgress());
        }
        return PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemCount: slideList.courseList.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => DetailHomeScreen(
                        id: slideList.courseList[i].id,
                      )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: GridTile(
                footer: GridTileBar(
                  subtitle: Row(
                    children: [
                      RatingBarIndicator(
                        rating: slideList.courseList[i].averageRating == null
                            ? 0.0
                            : slideList.courseList[i].averageRating.toDouble(),
                        itemSize: 22,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        // itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => SvgPicture.asset(
                          'assets/images/icons/Asset 12.svg',
                          color: AppTheme.orange,
                        ),
                      ),
                      Text(" ${slideList.courseList[i].view} "),
                      Icon(
                        Icons.visibility,
                        color: Theme.of(context).buttonColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 20,
                        width: 65,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(35)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                language.words['view'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).buttonColor,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
                  title: Text(
                    language.languageCode == 'en'
                        ? slideList.courseList[i].title
                        : language.languageCode == 'ar'
                            ? slideList.courseList[i].titleAr
                            : slideList.courseList[i].titleKr,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: slideList.courseList[i].photo,
                  fit: BoxFit.fill,
                  placeholder: (ctx, snap) => Center(
                    child: circleProgress(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
