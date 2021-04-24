import 'package:bootcamps/Style/style.dart';
import 'package:flutter/material.dart';

//multi Select Chip
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
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ChoiceChip(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 3, top: 3),
                    selectedColor: AppTheme.green,
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
