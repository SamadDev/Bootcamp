import 'package:bootcamps/Localization/language.dart';
import 'package:provider/provider.dart';

class FilterList {
  List language(context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
      {'title': word['kurdish'], "value": "Kurdish"},
      {'title': word['english'], "value": "English"},
      {'title': word['arabic'], "value": "Arabic"},
    ];
  }

  List minimumSkills (context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
    // {'title': "not require", "value": "not require"},
    {'title': word['beginner'], "value": "beginner"},
    {'title': word['intermediate'], "value": "intermediate"},
    {'title': word['expert'], "value": "expert"},
  ];}

  List category (context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
    {'title': word['business'], "value": "Business"},
    {'title': word['art'],"value": "Art"},
    {'title': word['sport'], "value": "Sport"},
    {'title': word['fitness'], "value": "Fitness"},
    {'title': word["technology"], "value": "Technology"},
  ];}
  List certificate (context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
    {'title': word["have"], "value": "true"},
    {'title': word["not"], "value": "false"},
  ];}
  List state (context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
    // {'title': "all", "value": "both"},
    {'title': word["incamp"], "value": "in bootcamp"},
    {'title':word["online"], "value": "online"},
  ];}

  List sort (context) {
    final word=Provider.of<Language>(context,listen:false).words;
    return [
    {'title': word["popular"], "value": "averageView"},
    {'title': word["new"], "value": "createdAt"},
  ];}
  List rating () {
    return [
    {'title': "5*", "value": "5"},
    {'title': "4*", "value": "4"},
    {'title': "3*", "value": "3"},
    {'title': "2", "value": "2"},
    {'title': '1', 'value': '1'},
    {'title': 'not rate'}
  ];}
}
