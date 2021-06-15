import 'package:bootcamps/Providers/Reviews.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bootcamps/Style/style.dart';

class ReviewPostScreen extends StatefulWidget {
  static const route = '/PostReviewScreen';
  final courseId;
  ReviewPostScreen({this.courseId});

  @override
  _ReviewPostScreenState createState() => _ReviewPostScreenState();
}

class _ReviewPostScreenState extends State<ReviewPostScreen> {
  final _form = GlobalKey<FormState>();
  var _review = ReviewData(
    title: '',
    text: '',
    rating: 2.5,
  );
  var _isLoading = false;

  Future<void> _saveForm() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Review>(context, listen: false).postReview(
        newReview: _review, context: context, courseId: widget.courseId);

    setState(() {
      _isLoading = false;
    });
  }

  String _title = 'good';
  List<String> titleList = [
    'Excellent',
    'Very good',
    'Good',
    'Bad',
    'Very Bad'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 40, right: 30, left: 30),
                      child: Center(
                        child: Text(
                            'Your nice feedback will be helping us to improve our course,',
                            style: Theme.of(context).textTheme.headline3),
                      ),
                    ),
                    Column(
                      children: [
                        RatingBar.builder(
                          initialRating: 2.5,
                          minRating: 0.5,
                          maxRating: 5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: AppTheme.green,
                          ),
                          onRatingUpdate: (newRating) {
                            setState(() {
                              _review.rating = newRating;
                            });
                          },
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 8.0, right: 8.0, bottom: 10),
                            child: dropDownWidget(
                                label: _title,
                                list: titleList,
                                function: (newValue) {
                                  setState(() {
                                    _title = newValue;
                                    _review = ReviewData(
                                        title: _title,
                                        text: _review.text,
                                        rating: _review.rating);
                                  });
                                })),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 30),
                          child: TextFormField(
                            maxLines: 8,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: ' What make you say that pleas?',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightBlueAccent,
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.green, width: 2.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppTheme.green, width: 1.0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _review = ReviewData(
                                  title: _review.title,
                                  text: value,
                                  rating: _review.rating);
                            },
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        _saveForm();
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width / 1.1,
                        decoration: BoxDecoration(
                          color: AppTheme.green,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: Text('Submit Review',
                              style: Theme.of(context).textTheme.button),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
