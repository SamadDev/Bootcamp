import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Providers/enroll message.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Pages/Courses/Detail/DetailHomeScreen.dart';

class EnrollMessageScreen extends StatefulWidget {
  static const String route = '/enrollMessageScreen';

  @override
  _EnrollMessageScreenState createState() => _EnrollMessageScreenState();
}

class _EnrollMessageScreenState extends State<EnrollMessageScreen> {
  initState() {
    super.initState();
    getEnrollMessage();
  }

  void getEnrollMessage() async {
    await Provider.of<MessageEnroll>(context, listen: false)
        .fitchMessageEnroll(context: context);
    Provider.of<MessageEnroll>(context, listen: false)
        .messageFilter(Profile.userId);
    print(Profile.userId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<MessageEnroll>(context, listen: false)
            .fitchMessageEnroll(context: context),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else
            return Consumer<MessageEnroll>(
                builder: (context, access, _) => ListView.builder(
                    itemCount: access.enrollMessageFilter.length,
                    itemBuilder: (ctx, index) => EnrollWidget(
                          data: access.enrollMessageFilter[index],
                        )));
        },
      ),
    );
  }
}

class EnrollWidget extends StatelessWidget {
  final MessageEnrollData data;

  EnrollWidget({this.data});

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => DetailHomeScreen(
                      id: data.enroll.course,
                    )));
          },
          child: ListTile(
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: AppTheme.green,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.notifications_active,
                size: 30,
                color: AppTheme.white,
              ),
            ),
            title: Text(
              'message',
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              '${data.message}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
