import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';

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
    Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
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
                    itemBuilder: (ctx, i) => CachedNetworkImage(
                      imageUrl: slideList[i].imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                          child: Image.asset('assets/images/spiner.gif')),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                      )
                    ],
                  )
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
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.lightBlue : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OfferData {
  final String imageUrl;

  OfferData({
    @required this.imageUrl,
  });
}

final slideList = [
  OfferData(
    imageUrl:
        'https://d3kijc7rubp0l9.cloudfront.net/wp/wp-content/uploads/2017/11/20.jpg',
  ),
  OfferData(
    imageUrl:
        'https://www.industrytrainingservices.com/wp-content/uploads/2017/12/the-playground-21.png',
  ),
  OfferData(
      imageUrl:
          'https://handakafunda.com/wp-content/uploads/2015/03/Holi-Discount-Offer-Get-25-Off-on-CAT-2015-Course.png'),
  OfferData(
    imageUrl:
        'https://www.theopencollege.com/wp-content/uploads/2020/10/Voucher-Twitter-May-2020-v2-1.jpg',
  ),
];
