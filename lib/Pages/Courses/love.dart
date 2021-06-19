import 'package:bootcamps/Providers/love.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveScreen extends StatelessWidget {
  static const String route = "/LoveScree";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.black2,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Favorite',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<SLocalStorage>(context, listen: false)
                .fetchLoveList(),
            builder: (ctx, i) => Consumer<SLocalStorage>(
                  builder: (ctx, love, _) => GridView.builder(
                      itemCount: love.courseList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 1),
                      itemBuilder: (ctx, index) => Container(
                            width: 200,
                            height: 300,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                Container(
                                  color: AppTheme.black2,
                                  width: 200,
                                  height: 300,
                                  child: CachedNetworkImage(
                                 imageUrl: love.courseList[index],
                                    fit: BoxFit.fill,
                                    placeholder: (ctx,snap)=>Image.asset('assets/images/'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    love.removeCourse(love.courseList[index]);
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: AppTheme.black2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                          )),
                )));
  }
}
