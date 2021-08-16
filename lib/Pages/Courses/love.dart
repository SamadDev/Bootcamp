import 'package:bootcamps/Providers/love.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/NotFound.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Courses/Detail/DetailHomeScreen.dart';
import 'package:bootcamps/Localization/language.dart';

class LoveScreen extends StatelessWidget {
  static const String route = "/LoveScree";

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    final check = Provider.of<SLocalStorage>(context, listen: false).courseList;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          title: Text(
            language.words['favorite'],
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<SLocalStorage>(context, listen: false)
                .fetchLoveList(),
            builder: (ctx, snap) => snap.connectionState ==
                    ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<SLocalStorage>(
                    builder: (ctx, love, _) =>love.courseList.isEmpty?NotFoundScreen():
                        GridView.builder(
                            itemCount: love.courseList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5,
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.9),
                            itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => DetailHomeScreen(
                                                  id: love.idList[index],
                                                )));
                                  },
                                  child: GridTile(
                                    footer: GridTileBar(
                                      backgroundColor: Theme.of(context).cardColor,
                                      title: Text(
                                        language.languageCode == 'en'
                                            ? love.titleList[index]
                                            : language.languageCode == 'kr'
                                                ? love.titleKrList[index]
                                                : love.titleArList[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: love.courseList[index],
                                      fit: BoxFit.cover,
                                      placeholder: (ctx, snap) =>
                                          Image.asset('assets/images/load.gif'),
                                    ),
                                    header: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            love.removeCourse(
                                                love.courseList[index],
                                                love.idList[index],
                                                love.titleList[index],
                                                love.titleKrList[index],
                                                love.titleArList[index]);
                                          },
                                          child: Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                color: AppTheme.black2),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: AppTheme.green,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                  )));
  }
}
