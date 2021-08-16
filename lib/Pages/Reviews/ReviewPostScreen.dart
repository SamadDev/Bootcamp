import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Providers/Reviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bootcamps/Style/style.dart';

class ReviewPostScreen extends StatefulWidget {
  static const route = '/PostReviewScreen';
  final courseId;
  final reviewId;

  ReviewPostScreen({this.courseId, this.reviewId});

  @override
  _ReviewPostScreenState createState() => _ReviewPostScreenState();
}

class _ReviewPostScreenState extends State<ReviewPostScreen> {
  final _form = GlobalKey<FormState>();
  var _review = ReviewData(
    text: '',
    rating: 2.5,
  );

  final text = TextEditingController();
  double rating = 2.5;

  var _isLoading = false;

  Future<void> _saveForm() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (widget.reviewId == null) {
      await Provider.of<Review>(context, listen: false).postReview(
          newReview: _review, context: context, courseId: widget.courseId);
    } else {
      await Provider.of<Review>(context, listen: false).updateReview(
          courseId: widget.courseId,
          context: context,
          reviewId: widget.reviewId,
          review: _review);
      Navigator.of(context).pop();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (widget.reviewId != null) {
      final data =
          Provider.of<Review>(context, listen: false).findById(widget.reviewId);
      text.text = data.text;
      rating = data.rating;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topRight,
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              itemSize: 30,
                              initialRating: rating,
                              minRating: 1,
                              maxRating: 5,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 3.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: AppTheme.green,
                              ),
                              onRatingUpdate: (newRating) {
                                setState(() {
                                  _review.rating = newRating;
                                  rating = newRating;
                                });
                              },
                            ),
                            Text(
                              rating.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: AppTheme.black3),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      TextFormField(
                        controller: text,
                        maxLines: 10,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            alignLabelWithHint: true,
                            hintText: language.words['you feedback'],
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: AppTheme.black3)),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return language.words['validate'];
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _review =
                              ReviewData(text: value, rating: _review.rating);
                        },
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _saveForm();
                          },
                          child: Container(
                            width: 280,
                            decoration: BoxDecoration(
                              color: AppTheme.green,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(32.0)),
                            ),
                            child: Center(
                              child: Text(
                                language.words['review now'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: AppTheme.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        _isLoading
            ? SizedBox.shrink()
            : Align(
                alignment: language.languageDirection == "ltr"
                    ? Alignment(1.05, -1.15)
                    : Alignment(-1.05, -1.15),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: EdgeInsets.all(8),
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: AppTheme.deleteButton,
                            borderRadius: BorderRadius.circular(60)),
                        child: Icon(
                          Icons.clear,
                          color: AppTheme.white,
                          size: 20,
                        ))),
              )
      ],
    );
  }
}

openAlertBox(context, courseId, {reviewId}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: AppTheme.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
                color: AppTheme.transparent,
                height: 280,
                width: 250,
                child: ReviewPostScreen(
                  courseId: courseId,
                  reviewId: reviewId,
                )));
      });
}
