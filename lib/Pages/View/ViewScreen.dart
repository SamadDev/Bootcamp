import 'package:bootcamps/Providers/View&like.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewsScreen extends StatefulWidget {
  static const route = "/ViewsScreen";

  @override
  _ViewsScreenState createState() => _ViewsScreenState();
}

class _ViewsScreenState extends State<ViewsScreen> {
  initState() {
    super.initState();
    Provider.of<View>(context, listen: false)
        .postView(context: context, newView: 1);
  }

  Widget build(BuildContext context) {
    final view =
        Provider.of<View>(context, listen: false).fitchAllViews(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "views",
          style: Theme.of(context).textTheme.headline2,
        )),
      ),
      body: FutureBuilder(
        future: view,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else
            return Consumer<View>(
              builder: (context, view, _) => SingleChildScrollView(
                child: Column(
                    children: view.viewList
                        .map<Widget>((e) => ChangeNotifierProvider.value(
                            child: ViewWidget(), value: e))
                        .toList()),
              ),
            );
        },
      ),
    );
  }
}

class ViewWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final data = Provider.of<ViewData>(context);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // topTextOfCourseDetailScreen(data.title),
          courseInfoText(data.view.toString())
        ],
      ),
    ));
  }
}
