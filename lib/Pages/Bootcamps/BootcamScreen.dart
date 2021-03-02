import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootcampScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bootcamp = Provider.of<BootCamp>(context, listen: false);
    return FutureBuilder(
        future: bootcamp.fitchBootcamp(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 1,
              backgroundColor: AppTheme.orange,
            ));
          } else
            return Consumer<BootCamp>(
              builder: (context, bootcamp, _) => ListView.builder(
                  itemCount: bootcamp.bootcampList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        child: BootCampWidget(),
                        value: bootcamp.bootcampList[i],
                      )),
            );
        });
  }
}

class BootCampWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<BootcampData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(color: AppTheme.green, width: 3)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  data.photo,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
