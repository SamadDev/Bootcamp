import 'dart:async';

import 'package:bootcamps/Pages/Bootcamps/BootcampsHomeScreen.dart';
import 'package:bootcamps/Pages/ObordScreen/PageViewWIdget.dart';
import 'package:bootcamps/Pages/ObordScreen/SlideDoteScreen.dart';
import 'package:bootcamps/Pages/ObordScreen/slidedata.dart';
import 'package:flutter/material.dart';

class GettingStartedScreen extends StatefulWidget {
  static final route = '/GettingStartedScreen';
  final type;

  GettingStartedScreen({this.type});

  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
        );
      }
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
    print(widget.type);
    return Scaffold(
        body: Container(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                child: Column(children: <Widget>[
                  Expanded(
                      child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: _onPageChanged,
                        itemCount: onBoardList.length,
                        itemBuilder: (ctx, i) => SlideItem(i),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.topStart,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                _pageController.nextPage(
                                    duration: Duration(microseconds: 100),
                                    curve: Curves.easeIn);
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 15.0, bottom: 15.0),
                                child: _currentPage == 2
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(BootcampsScreen.route);
                                        },
                                        child: Text('DONE',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption),
                                      )
                                    : Text("NEXT>",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: GestureDetector(
                              onTap: () {
                                //todo
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 15.0, bottom: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(BootcampsScreen.route);
                                  },
                                  child: Text("SKIP",
                                      style:
                                          Theme.of(context).textTheme.caption),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            margin: EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                for (int i = 0; i < onBoardList.length; i++)
                                  if (i == _currentPage)
                                    SlideDots(true)
                                  else
                                    SlideDots(false)
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ]))));
  }
}
