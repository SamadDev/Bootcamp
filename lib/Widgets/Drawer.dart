import 'package:bootcamps/Pages/Courses/CourseMy.dart';
import 'package:bootcamps/Pages/Courses/love.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/ButtomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Pages/Authendication/UserOrPublisher.dart';

class MainDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    final role = Profile.userRole;
    return Scaffold(
        body: FutureBuilder(
            future:
                Provider.of<Profile>(context, listen: false).getUser(context),
            builder: (ctx, snap) =>
                snap.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Consumer<Profile>(
                              builder: (context, profile, _) => Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 50.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 50.0,
                                            backgroundImage: NetworkImage(
                                                profile.userData.photo !=
                                                        null
                                                    ? profile.userData.photo
                                                    : "https://i.ibb.co/mbB2wdY/undraw-profile-pic-ic5t.png"),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(profile.userData.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3),
                                        ],
                                      ),
                                    ),
                                  )),
                          Container(
                            child: Column(children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              listTile(
                                  context: context,
                                  text: "My Enrolled course",
                                  icon: Icons.book),
                              role == 'publisher'
                                  ? listTile(
                                      context: context,
                                      text: 'My course',
                                      icon: Icons.book,
                                      screenRoute: MyCourse.route)
                                  : SizedBox.shrink(),
                              listTile(
                                  context: context,
                                  text: 'Favorite',
                                  icon: Icons.favorite,
                                  screenRoute: LoveScreen.route),
                              listTile(
                                  context: context,
                                  text: 'setting',
                                  icon: Icons.settings,
                                  screenRoute: HomeScreen.route),
                            ]),
                          ),
                          Container(
                            width: 230,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(color: AppTheme.black4)),
                            child: GestureDetector(
                              onTap: () {
                                Provider.of<Auth>(context, listen: false)
                                    .removeToken();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => UserOrPublisher()));
                              },
                              child: Center(
                                  child: Text(
                                'Log Out',
                                style: Theme.of(context).textTheme.headline4,
                              )),
                            ),
                          )
                        ],
                      )));
  }
}

Widget listTile({context, screenRoute, icon, text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
    child: Container(
      height: 70,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: AppTheme.black2,
        child: ListTile(
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.of(context).pushNamed(screenRoute);
          },
          leading: Icon(
            icon,
            color: AppTheme.headlineTextColor,
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    ),
  );
}
