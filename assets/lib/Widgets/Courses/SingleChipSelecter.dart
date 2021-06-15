import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

//single select chip
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
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ChoiceChip(
                    elevation: 0,
                    labelPadding:
                        EdgeInsets.only(right: 10, left: 10, top: 3, bottom: 3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    selectedColor: AppTheme.green,
                    label: Text(item['title']),
                    selected: selectedChoices.contains(item['value']),
                    onSelected: (select) {
                      setState(() {
                        select
                            ? selectedChoices = item['value']
                            : 'averageView';
                      });
                    },
                  ),
                )))
            .toList());
  }
}
