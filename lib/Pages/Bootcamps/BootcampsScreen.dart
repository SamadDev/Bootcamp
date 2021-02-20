import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampDetailScreen.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Widgets/Drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../Bootcamps/BootcampCoursePopulate.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampOfferScreen.dart';

class BootcampsScreen extends StatelessWidget {
  static const route = "/BootcampsScreen";

  @override
  Widget build(BuildContext context) {
    final bootcamp = Provider.of<BootCamp>(context, listen: false);
    final language = Provider.of<Language>(context).words;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Center(
            child: Text(
          language["bootcamp"],
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 15, right: 10, left: 10),
                child: Text(
                  "Course Offer",
                  style: Theme.of(context).textTheme.headline2,
                )),
            Container(
              height: 210,
              child: BootcampOfferScreen(),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 70, bottom: 10, right: 10, left: 10),
                child: Text(
                  "Popular Courses",
                  style: Theme.of(context).textTheme.headline2,
                )),
            Container(
              height: 170,
              child: BootcampCoursePopulate(),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 30, bottom: 10, right: 10, left: 10),
                child: Text(
                  "Bootcamps",
                  style: Theme.of(context).textTheme.headline2,
                )),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 10, right: 2, left: 2),
              child: FutureBuilder(
                  future: bootcamp.fitchBootcamp(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else
                      return Consumer<BootCamp>(
                          builder: (context, bootcamp, _) => Column(
                                children: bootcamp.bootcampList
                                    .map<Widget>((e) =>
                                        ChangeNotifierProvider.value(
                                            value: e, child: BootCampWidget()))
                                    .toList(),
                              ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class BootCampWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BootcampData>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15, right: 18, left: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BootcampDetailScreen.route, arguments: data.id);
        },
        child: Container(
          height: 320,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.6,
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: CachedNetworkImage(
                              imageUrl: data.photo,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Center(
                                  child:
                                      Image.asset('assets/images/spiner.gif')),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 25,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 4, right: 4, top: 4, bottom: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    data.name,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                Expanded(
                                    flex: 13,
                                    child: Text(
                                      "We have ${data.careers} course",
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )),
                                Expanded(
                                    flex: 8,
                                    child: Text(
                                      data.address,
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
