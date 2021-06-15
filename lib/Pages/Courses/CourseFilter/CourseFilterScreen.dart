import 'package:bootcamps/Pages/Courses/CourseFilter/CourseFilterHome.dart';
import 'package:bootcamps/Providers/courseFilter.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Courses/MultyChipSelecter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseFilterScreen extends StatefulWidget {
  static const route = "/CourseFilterScreen";

  _CourseFilterScreenState createState() => _CourseFilterScreenState();
}

class _CourseFilterScreenState extends State<CourseFilterScreen> {
  List selectedLanguage = List();
  List selectedSkill = List();
  List selectedCategory = List();
  String selectedSort = '';
  bool isCertificate = true;
  String state = 'online';
  double selectedRating = 0;
  RangeValues currentRangeValues = RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
          style: Theme.of(context).textTheme.headline3,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              child: _chipSelect(
                  context: context,
                  title: "Language",
                  child: MultiSelectChip(
                    reportList: FilterList().language,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        selectedLanguage = selectedList;
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _rangeSlider(
                  context: context,
                  currentRangeValues: currentRangeValues,
                  onChanged: (RangeValues value) {
                    setState(() {
                      currentRangeValues = value;
                    });
                  }),
            ),
            _chipSelect(
                title: "Rating greater than",
                context: context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        selectedRating.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    _ratingWidget((value) {
                      setState(() {
                        selectedRating = value;
                      });
                    }),
                  ],
                )),
            Container(
              height: 200,
              child: _chipSelect(
                  context: context,
                  title: "Category",
                  child: MultiSelectChip(
                    reportList: FilterList().category,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        selectedCategory = selectedList;
                        // print(selectedReportList);
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isCertificate(
                  context: context,
                  value: isCertificate,
                  onChanged: (value) {
                    setState(() {
                      isCertificate = value;
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: _stateCourse(
                  context: context,
                  value: state,
                  onChanged: (value) {
                    setState(() {
                      state = value;
                    });
                  }),
            ),
            _chipSelect(
                context: context,
                title: "Skill Required",
                child: MultiSelectChip(
                  reportList: FilterList().minimumSkills,
                  onSelectionChanged: (selectedList) {
                    setState(() {
                      selectedSkill = selectedList;
                      // print(selectedReportList);
                    });
                  },
                )),
            _chipSelect(
                context: context,
                title: "Sort by",
                child: Wrap(
                    children: FilterList()
                        .sort
                        .map((item) => (Container(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ChoiceChip(
                                elevation: 0,
                                labelPadding: EdgeInsets.only(
                                    right: 10, left: 10, top: 3, bottom: 3),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                selectedColor: AppTheme.green,
                                label: Text(item['title']),
                                selected: selectedSort.contains(item['value']),
                                onSelected: (selected) {
                                  setState(() {
                                    selectedSort = item['value'];
                                  });
                                },
                              ),
                            )))
                        .toList())),
            Text(selectedSort),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, right: 10, left: 10),
              child: Row(
                children: [
                  _applyWidget(
                      context: context,
                      text: "Apply Filter",
                      style: Theme.of(context).textTheme.button,
                      color: AppTheme.green,
                      onTab: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => CourseFilterHome(
                                  selectedCategory: selectedCategory.join(','),
                                  selectedCertificate: isCertificate.toString(),
                                  selectedLanguage: selectedLanguage.join(','),
                                  selectedSkill: selectedSkill.join(','),
                                  selectedState: state,
                                  selectedSort: selectedSort,
                                  selectedRating:
                                      selectedRating.round().toString(),
                                  selectedMax:
                                      currentRangeValues.end.round().toString(),
                                  selectedMin: currentRangeValues.start
                                      .round()
                                      .toString(),
                                )));
                      }),
                  _applyWidget(
                      context: context,
                      text: "Clear all",
                      style: Theme.of(context).textTheme.headline3,
                      color: AppTheme.black2,
                      onTab: () {
                        Navigator.of(context)
                            .popAndPushNamed(CourseFilterScreen.route);
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//______________________________________________

Widget _chipSelect({context, title, child}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppTheme.black2, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, bottom: 12, top: 12),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15, top: 3, bottom: 3),
            child: child,
          ),
        ],
      ),
    ),
  );
}

//________________________________________________

Widget _stateCourse({context, onChanged, value}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
        color: AppTheme.black2, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Course State',
            style: Theme.of(context).textTheme.headline4,
          ),
          DropdownButton(
            elevation: 0,
            dropdownColor: AppTheme.black2,
            underline: SizedBox.shrink(),
            value: value,
            items: FilterList()
                .state
                .map((e) => DropdownMenuItem(
                      child: Text(e['title']),
                      value: e['value'],
                    ))
                .toList(),
            onChanged: onChanged,
          )
        ],
      ),
    ),
  );
}

//__________________________________________________

Widget _isCertificate({context, onChanged, value}) {
  return Container(
    width: double.infinity,
    height: 50,
    decoration: BoxDecoration(
        color: AppTheme.black2, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'certificate in the end',
            style: Theme.of(context).textTheme.headline4,
          ),
          Checkbox(
              activeColor: AppTheme.green, value: value, onChanged: onChanged),
        ],
      ),
    ),
  );
}

//____________________________________

Widget _applyWidget({context, onTab, text, color, style}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
        onTap: onTab,
        child: Container(
          height: 50,
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: color),
          child: Center(
              child: Text(
            text,
            style: style,
          )),
        ),
      ),
    ],
  );
}

//_________________________________________

Widget _rangeSlider({context, currentRangeValues, onChanged}) {
  return Container(
    decoration: BoxDecoration(
        color: AppTheme.black2, borderRadius: BorderRadius.circular(15)),
    height: 150,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, top: 20, bottom: 10),
          child: Text(
            "Prise",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        Divider(
          thickness: 0.5,
          color: AppTheme.black4,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15.0, right: 15, top: 5, bottom: 5),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 20,
            children: [
              Text(
                " ${currentRangeValues.start.round().toString()}\$",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                " ${currentRangeValues.end.round().toString()}\$",
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: 300,
            child: RangeSlider(
                // divisions: 40,
                activeColor: AppTheme.green,
                inactiveColor: AppTheme.black3,
                min: 0,
                max: 100,
                values: currentRangeValues,
                onChanged: onChanged),
          ),
        ),
      ],
    ),
  );
}

//_____________________________________

Widget _ratingWidget(onChange) {
  return RatingBar.builder(
      itemSize: 35,
      initialRating: 0,
      minRating: 0.0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => SvgPicture.asset(
            'assets/images/icons/Asset 12.svg',
            color: AppTheme.green,
          ),
      onRatingUpdate: onChange);
}
//__________________________________________

Widget _singleChip(list, onChange, select) {
  return Wrap(
      children: list
          .map<Widget>((item) => (Container(
                padding: const EdgeInsets.only(right: 5.0),
                child: ChoiceChip(
                  elevation: 0,
                  labelPadding:
                      EdgeInsets.only(right: 10, left: 10, top: 3, bottom: 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  selectedColor: AppTheme.green,
                  label: Text(item['title']),
                  selected: select.contains(item['value']),
                  onSelected: onChange,
                ),
              )))
          .toList());
}
