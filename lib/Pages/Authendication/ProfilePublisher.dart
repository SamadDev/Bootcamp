import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Bootcamps/CoursessVertical.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileSeller extends StatefulWidget {
  final id;
  final userName;
  final userPhoto;

  ProfileSeller({this.id, this.userName, this.userPhoto});

  _ProfileSellerState createState() => _ProfileSellerState();
}

class _ProfileSellerState extends State<ProfileSeller> {
  initState() {
    super.initState();
    getUserCourse();
  }

  getUserCourse() {
    Provider.of<Course>(context, listen: false).courseWithUserId(widget.id);
  }

  Widget build(BuildContext context) {
    final language=Provider.of<Language>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Theme.of(context).cardColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color:Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10, right: 3, left: 3),
                    height: 120,
                    width: 110,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: widget.userPhoto,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.userName,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        "Flutter developer",
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(color: Theme.of(context).buttonColor,),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8),
                child: Text(
                  language.words['contact me with'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    getImageSocial(context, 'facebook.png'),
                    getImageSocial(context, 'twitter.png'),
                    getImageSocial(context, 'youtube.png'),
                    getImageSocial(context, 'whatsapp.png'),
                    getImageSocial(context, 'linkedin.png'),
                  ],
                ),
              ),
              Divider(color: Theme.of(context).buttonColor,),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 10,top: 15),
                child: Text(
                  language.words['learn with my other course'],
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: Consumer<Course>(
                        builder: (context, course, _) => Expanded(
                          child: ListView.builder(
                              itemCount: course.userCourse.length,
                              itemBuilder: (ctx, i) =>
                                  ChangeNotifierProvider.value(
                                      value: course.userCourse[i],
                                      child: BootcampCourseWidget(
                                        data: course.userCourse[i],
                                      ))),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getImageSocial(context, name) {
  return GestureDetector(
    onTap: (){
      FlutterToast.showToast(
          msg: "sorry this not provided yet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppTheme.black3,
          textColor: AppTheme.white,
          fontSize: 16.0
      );
    },
    child: Container(
        width: 52,
        height: 52,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        child: Image.asset('assets/images/$name')),
  );
}
