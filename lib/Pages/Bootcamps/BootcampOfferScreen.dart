import 'dart:async';

import 'package:bootcamps/Style/style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BootcampOfferScreen extends StatefulWidget {
  @override
  _BootcampOfferScreenState createState() => _BootcampOfferScreenState();
}

class _BootcampOfferScreenState extends State<BootcampOfferScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) => Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: slideList[i].image,
                            fit: BoxFit.fill,
                            placeholder: (ctx, snap) => Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppTheme.green,
                                strokeWidth: 1,
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Card(
                              color: AppTheme.black2,
                              margin: EdgeInsets.all(5),
                              child: Text(
                                slideList[i].quete,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 35),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0; i < 4; i++)
                              if (i == _currentPage)
                                Offer(true)
                              else
                                Offer(false)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Offer extends StatelessWidget {
  final bool isActive;

  Offer(this.isActive);

  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 4 : 4,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.green : AppTheme.black3,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OfferData {
  final String image;
  final String quete;

  OfferData({@required this.image, this.quete});
}

final slideList = [
  OfferData(
      quete: 'Do what is right, not what is easy.',
      image:
      'https://images.unsplash.com/photo-1495465798138-718f86d1a4bc?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
  OfferData(
    quete: 'One day, all your hard work will pay off.',
    image:
    'https://images.unsplash.com/photo-1488998427799-e3362cec87c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
  ),
  OfferData(
      quete: 'To change your life,change your day.',
      image:
      'https://images.unsplash.com/photo-1474377207190-a7d8b3334068?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=750&q=80'),
  OfferData(
    quete: 'Don’t stop until you’re proud.',
    image:
    'https://images.unsplash.com/photo-1485988412941-77a35537dae4?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=772&q=80',
  ),
];
