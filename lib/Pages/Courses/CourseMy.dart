import 'package:bootcamps/Pages/Bootcamps/BootcampPostScreen.dart';
import 'package:bootcamps/Pages/Courses/CourseDetailScreen.dart';
import 'package:bootcamps/Pages/Courses/CoursePostScreen.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Drawer.dart';
import 'package:bootcamps/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/profile.dart';

class MyCourse extends StatefulWidget {
  static const route = '/MyCourse';

  @override
  _MyCourseState createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  Widget build(BuildContext context) {
    final userRole = Profile.userRole;
    final userId = Profile.userId;
    var bootcampId = Provider.of<BootCamp>(context, listen: false)
        .findBootWithUserId(userId)
        .id;
    print("bootcamp id = $bootcampId");

    final userCourse = Provider.of<Course>(context, listen: false)
        .courseWithUserId(bootcampId);

    return bootcampId != null
        ? Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              title: Center(child: Text('My Courses')),
            ),
            body: FutureBuilder(
                future: Provider.of<Course>(context, listen: false)
                    .fitchCoursesRefBootcamp(bootcampId),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return Consumer<Course>(
                      builder: (_, course, ctx) => ListView.builder(
                        padding: EdgeInsets.only(
                            top: 12, right: 12, left: 12, bottom: 70),
                        itemBuilder: (ctx, index) =>
                            ChangeNotifierProvider.value(
                                value: course.bootcampCourse[index],
                                child: MyCourseWidget()),
                        itemCount: userCourse.length,
                      ),
                    );
                }),
            floatingActionButton: userRole == 'user'
                ? null
                : FloatingWidget(
                    txt: 'Add course',
                    leadingIcon: Icons.add,
                    onTab: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              CoursePostScreen(bootcampId: bootcampId)));
                    },
                  ),
          )
        : Scaffold(
            body: AlertDialog(
              title: Text(
                'you are out of Bootcamp!',
                style: Theme.of(context).textTheme.headline3,
              ),
              backgroundColor: AppTheme.bg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              content: Text(
                  'pleas at first you have to add bootcamp and then add course and then you can add courses'),
              actions: [
                ChipButtonWidget(
                  text1: 'create bootcamp',
                  color1: AppTheme.secondaryBg,
                  onPress1: () {
                    Navigator.of(context).pushNamed(BootcampPostScreen.route);
                  },
                  text2: "back",
                  color2: AppTheme.secondaryBg,
                  onPress2: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
  }
}

class MyCourseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CourseData>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(CourseDetailScreen.route, arguments: data.id);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 18, left: 18),
        child: Container(
          height: 340,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: AppTheme.bg,
                  shadowColor: AppTheme.secondaryBg2,
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
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 50,
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
                                  flex: 15,
                                  child: Text(
                                    data.title,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                Expanded(
                                    flex: 25,
                                    child: Text(
                                      "We have ${data.description} course",
                                      maxLines: 2,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )),
                                Expanded(
                                    flex: 15,
                                    child: ChipButtonWidget(
                                        text1: 'Edit course',
                                        color1: AppTheme.editButton,
                                        onPress1: () {
                                          Navigator.of(context).pushNamed(
                                              CoursePostScreen.route,
                                              arguments: data.id);
                                        },
                                        text2: "Delete course",
                                        color2: AppTheme.deleteButton,
                                        onPress2: () {
                                          _showDialog(
                                              context: context,
                                              title: "Delete Course",
                                              body:
                                                  "are sure that you want to delete that course?",
                                              onPress: () {
                                                Provider.of<Course>(context,
                                                        listen: false)
                                                    .deleteCourse(
                                                        data.id, context);
                                              });
                                        }))
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

//edit and delete button of
class ChipButtonWidget extends StatelessWidget {
  final Function onPress1;
  final Function onPress2;
  final String text1;
  final String text2;
  final Color color1;
  final Color color2;

  const ChipButtonWidget(
      {this.onPress1,
      this.onPress2,
      this.text1,
      this.text2,
      this.color1,
      this.color2});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0, left: 15),
      child: Container(
        width: 280,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionChip(
                backgroundColor: color1,
                label: Text(text1),
                labelStyle: TextStyle(color: Colors.white),
                onPressed: onPress1),
            Spacer(),
            ActionChip(
                backgroundColor: color2,
                label: Text(text2),
                labelStyle: TextStyle(color: Colors.white),
                onPressed: onPress2),
          ],
        ),
      ),
    );
  }
}

// ShowDialog of Delete and update
void _showDialog({context, String title, String body, Function onPress}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
        content: new Text(
          body,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        actions: <Widget>[
          FlatButton(
            child: new Text("cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            onPressed: onPress,
            child: Text('delete'),
          )
        ],
      );
    },
  );
}
