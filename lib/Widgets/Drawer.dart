import 'package:bootcamps/Pages/Authendication/ProfileEdit.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampsScreen.dart';
import 'package:bootcamps/Pages/Bootcamps/BootcampMe.dart';
import 'package:bootcamps/Pages/Courses/CourseMy.dart';
import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool isLoading = false;

  void getUser() async {
    setState(() {
      isLoading = true;
    });

    await Provider.of<Profile>(context, listen: false).getUser(context);
    setState(() {
      isLoading = false;
    });

    setState(() {
      isLoading = false;
    });
  }

  initState() {
    super.initState();
    getUser();
  }

  Widget build(BuildContext context) {
    final role = Profile.userRole;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: isLoading
                  ? Container(
                      height: 270,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: 270,
                      color: AppTheme.bg,
                      width: 500,
                      child: Consumer<Profile>(
                          builder: (context, profile, _) => Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50.0,
                                        backgroundImage: NetworkImage(profile
                                                    .userData.photo !=
                                                null
                                            ? profile.userData.photo
                                            : "https://i.ibb.co/mbB2wdY/undraw-profile-pic-ic5t.png"),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      profile.userData.name != null
                                          ? Text(profile.userData.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2)
                                          : Text('null'),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(profile.userData.email,
                                          style: GoogleFonts.adventPro(
                                            fontSize: 18,
                                          )),
                                      ListTile(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushNamed(ProfileEdit.route);
                                          },
                                          trailing: Container(
                                              height: 20,
                                              width: 20,
                                              child: Image.asset(
                                                  'assets/images/edit.png')))
                                    ],
                                  ),
                                ),
                              ))),
            ),
            Container(
              child: Column(children: [
                SizedBox(
                  height: 20.0,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(BootcampsScreen.route);
                  },
                  leading: Icon(
                    Icons.school,
                    color: AppTheme.headlineTextColor,
                  ),
                  title: Text(
                    "Bootcamps",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                role != 'user'
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(MyBootcamp.route);
                        },
                        leading: Icon(
                          Icons.school,
                          color: AppTheme.headlineTextColor,
                        ),
                        title: Text(
                          "My Bootcamps",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    : SizedBox.shrink(),
                ListTile(
                  //Navigator.of(context).pushName()
                  onTap: () {
                    Navigator.of(context).pushNamed(CourseScreen.route);
                  },
                  leading: Icon(
                    Icons.book_outlined,
                    color: AppTheme.headlineTextColor,
                  ),
                  title: Text(
                    "Courses",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                role != 'user'
                    ? ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(MyCourse.route);
                        },
                        leading: Icon(
                          Icons.book_outlined,
                          color: AppTheme.headlineTextColor,
                        ),
                        title: Text(
                          "My Course",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    : SizedBox.shrink(),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed(CourseScreen.route);
                  },
                  leading: Icon(
                    Icons.settings,
                    color: AppTheme.headlineTextColor,
                  ),
                  title: Text(
                    "Settings",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
