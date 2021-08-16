import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Authendication/ProfileEdit.dart';
import 'package:bootcamps/Pages/Courses/CourseMy.dart';
import 'package:bootcamps/Pages/Courses/love.dart';
import 'package:bootcamps/Pages/Enroll/EnrollMyCourse.dart';
import 'package:bootcamps/Providers/DarkMode.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Pages/Authendication/UserOrPublisher.dart';

class MainDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    final role = Profile.userRole;
    final word = Provider.of<Language>(context, listen: false);
    return Scaffold(
        body: FutureBuilder(
            future:
            Provider.of<Profile>(context, listen: false).getUser(context),
            builder: (ctx, snap) =>
            snap.connectionState ==
                ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25,),
                  Consumer<Profile>(
                      builder: (context, profile, _) =>
                          Container(
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
                                    backgroundImage: NetworkImage(profile
                                        .userData.photo !=
                                        null
                                        ? profile.userData.photo
                                        : "https://i.ibb.co/mbB2wdY/undraw-profile-pic-ic5t.png"),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(profile.userData.name,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headline3),
                                ],
                              ),
                            ),
                          )),
                  Consumer<Language>(
                    builder: (context, language, child)=>
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  // listTile(
                                  //     context: context,
                                  //     text: 'profile',
                                  //     icon: Icons.person,
                                  //     screenRoute: ProfileEdit.route),
                                  listTile(
                                    context: context,
                                    text: language.words["My Enrolled course"],
                                    icon: Icons.book,
                                    screenRoute: EnrollMyCourse.route,
                                  ),
                                  role == 'publisher'
                                      ? listTile(
                                      context: context,
                                      text: 'My course',
                                      icon: Icons.book,
                                      screenRoute: MyCourse.route)
                                      : SizedBox.shrink(),
                                  listTile(
                                      context: context,
                                      text: language.words['favorite'],
                                      icon: Icons.favorite,
                                      screenRoute: LoveScreen.route),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      language.words['setting'],
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .headline4,
                                    ),
                                  ),
                                  setting(
                                      context: context,
                                      text: language.words['language'],
                                      icon: Icons.language,
                                      function: () {
                                        languageChange(
                                            text: language.words['language'],
                                            context: context);
                                      },
                                      trailer: language.languageCode == 'en'
                                          ? Text('English')
                                          : language.languageCode == 'ar'
                                          ? Text('عربی')
                                          : Text('کوردی')),
                                  setting(
                                      context: context,
                                      text: language.words['Change Mode'],
                                      icon: Icons.nightlight_round,
                                      trailer: Consumer<DarkThemePreference>(
                                          builder: (ctx, mode, _) {
                                            Provider.of<DarkThemePreference>(
                                                context)
                                                .getTheme();
                                            print(
                                                "${language.words['mode dark']}:${mode
                                                    .darkTheme}");
                                            var val = mode.darkTheme;
                                            return Switch(
                                                value: val,
                                                onChanged: (value) {
                                                  print(value);
                                                  val = value;
                                                  Provider.of<DarkThemePreference>(
                                                      context,
                                                      listen: false)
                                                      .setDarkTheme(value);
                                                });
                                          }))
                                ]),
                          ),
                        )
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    width: 230,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .cardColor,
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
                            word.words['log out'],
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                          )),
                    ),
                  )
                ],
              ),
            )));
  }
}

Widget listTile({context, screenRoute, icon, text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
    child: Container(
      height: 70,
      child: Card(
        color: Theme
            .of(context)
            .cardColor,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          trailing: Icon(Icons.arrow_forward_ios, color: Theme
              .of(context)
              .buttonColor,),
          onTap: () {
            Navigator.of(context).pushNamed(screenRoute);
          },
          leading: Icon(
            icon,
            color: Theme
                .of(context)
                .buttonColor,
          ),
          title: Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
          ),
        ),
      ),
    ),
  );
}

Widget setting({context, screenRoute, icon, text, trailer, function}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
    child: Container(
      height: 70,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Theme
            .of(context)
            .cardColor,
        child: ListTile(
          trailing: trailer,
          onTap: function,
          leading: Icon(
            icon,
            color: Theme
                .of(context)
                .buttonColor,
          ),
          title: Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .headline4,
          ),
        ),
      ),
    ),
  );
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final String code;
  final String direction;

  const _LanguageButton(
      {@required this.label, @required this.code, @required this.direction});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity, // color:Theme.of(context).cardColor,
      textColor: Theme
          .of(context)
          .cardColor,
      onPressed: () {
        Provider.of<Language>(context, listen: false)
            .setLanguage(code, direction);
        Navigator.of(context).pop();
      },
      child: Text(label, style: Theme
          .of(context)
          .textTheme
          .headline4),
    );
  }
}

languageChange({context, text}) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          backgroundColor: Theme
              .of(context)
              .cardColor,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text, style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
              ),
              SizedBox(height: 10),
              Divider(),
              _LanguageButton(label: 'کوردی', code: 'kr', direction: 'rtl'),
              _LanguageButton(label: 'English', code: 'en', direction: 'ltr'),
              _LanguageButton(label: 'عربی', code: 'ar', direction: 'rtl')
            ],
          ),
        ),
  );
}
