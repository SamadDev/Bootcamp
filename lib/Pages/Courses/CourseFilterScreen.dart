import 'package:bootcamps/Pages/Courses/CourseScreen.dart';
import 'package:bootcamps/Providers/Course.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseFilterScreen extends StatefulWidget {
  static const route = "/CourseFilterScreen";

  _CourseFilterScreenState createState() => _CourseFilterScreenState();
}

class _CourseFilterScreenState extends State<CourseFilterScreen> {
  List title = [
    {'title': "React jsx", "value": "React jsx"},
    {'title': "English For Kids", "value": "English for kids"},
    {'title': "IELTS", "value": "IELTS"},
    {'title': "Egnlish", "value": "Egnlish"},
    {'title': "Flutter", "value": "Flutter"},
  ];

  List selectedReportList = List();
  String selectedReport = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: MultiSelectChip(
                reportList: title,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedReportList = selectedList;
                  });
                },
              ),
            ),
            Text("${selectedReportList.join(",")}"),
            SingleSelectChip(
              reportList: title,
              onSelectionChanged: (selectItem) {
                setState(() {
                  selectedReport = selectItem;
                });
              },
            ),
            Text(selectedReport),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List reportList;
  final Function onSelectionChanged;

  MultiSelectChip({this.reportList, this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List selectedChoices = List();
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: widget.reportList
            .map((item) => (Container(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    selectedColor: Colors.lightBlueAccent,
                    label: Text(item['title']),
                    selected: selectedChoices.contains(item['value']),
                    onSelected: (selected) {
                      setState(() {
                        selectedChoices.contains(item['value'])
                            ? selectedChoices.remove(item['value'])
                            : selectedChoices.add(item['value']);
                        widget.onSelectionChanged(selectedChoices);
                      });
                    },
                  ),
                )))
            .toList());
  }
}

class SingleSelectChip extends StatefulWidget {
  final List reportList;
  final Function onSelectionChanged;

  SingleSelectChip({this.reportList, this.onSelectionChanged});

  @override
  _SingleSelectChipState createState() => _SingleSelectChipState();
}

class _SingleSelectChipState extends State<SingleSelectChip> {
  String selectedChoices = '';
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: widget.reportList
            .map((item) => (Container(
                  padding: const EdgeInsets.all(2.0),
                  child: ChoiceChip(
                    selectedColor: Colors.lightBlueAccent,
                    label: Text(item['title']),
                    selected: selectedChoices.contains(item['value']),
                    onSelected: (selected) {
                      setState(() {
                        selectedChoices = item['value'];
                      });
                    },
                  ),
                )))
            .toList());
  }
}
