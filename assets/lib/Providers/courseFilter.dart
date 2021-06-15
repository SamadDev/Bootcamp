class FilterList {
  List language = [
    {'title': "Kurdish", "value": "Kurdish"},
    {'title': "English", "value": "English"},
    {'title': "Arabic", "value": "Arabic"},
  ];

  List minimumSkills = [
    {'title': "beginner", "value": "beginner"},
    {'title': "intermediate", "value": "intermediate"},
    {'title': "expert", "value": "expert"},
  ];

  List category = [
    {'title': "Business", "value": "Business"},
    {'title': "art", "value": "Art"},
    {'title': "Sport", "value": "Sport"},
    {'title': "Fitness", "value": "Fitness"},
    {'title': "Technology", "value": "Technology"},
  ];
  List certificate = [
    {'title': "have", "value": "true"},
    {'title': "not", "value": "false"},
  ];
  List state = [
    {'title': "inCampus", "value": "in bootcamp"},
    {'title': "online", "value": "online"},
  ];

  List sort = [
    {'title': "most popular", "value": "-averageView"},
    {'title': "recent", "value": "-createdAt"},
  ];
  List rating = [
    {'title': "5*", "value": "5"},
    {'title': "4*", "value": "4"},
    {'title': "3*", "value": "3"},
    {'title': "2", "value": "2"},
    {'title': '1', 'value': '1'},
    {'title': 'not rate'}
  ];
}
