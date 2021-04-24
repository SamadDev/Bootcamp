class Test {
  String id;
  String bootcampId;
  String bootcampName;
  bool certificate;
  bool housing;
  String state;
  String typeSkill;
  String courseLink;
  String title;
  String description;
  String weeks;
  int tuition;
  String minimumSkill;
  String photo;
  double averageRating;
  int view;
  String user;

  Test({
    this.id,
    this.bootcampId,
    this.bootcampName,
    this.certificate,
    this.housing,
    this.state,
    this.typeSkill,
    this.courseLink,
    this.title,
    this.description,
    this.weeks,
    this.tuition,
    this.minimumSkill,
    this.photo,
    this.averageRating,
    this.view,
    this.user,
  });

  Test.fromJson(Map<String, dynamic> element) {
    id = element['_id'];
    user = element['user'];
    bootcampName = element['bootcamp']['name'];
    bootcampId = element['bootcamp']['_id'];
    photo = element['photo'];
    description = element['description'];
    title = element['title'];
    minimumSkill = element['minimumSkill'];
    tuition = element['tuition'];
    weeks = element['weeks'];
    view = element['averageView'];
    averageRating = element['averageRating'];
    housing = element['housing'];
    certificate = element['certificate'];
    courseLink = element['link'];
    state = element['state'];
    typeSkill = element['typeSkill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['typeSkill'] = this.typeSkill;
    data['link'] = this.courseLink;
    data['user'] = this.user;
    data['photo'] = this.photo;
    data['title'] = this.title;
    data['description'] = this.description;
    data['weeks'] = this.weeks;
    data['tuition'] = this.tuition;
    data['minimumSkill'] = this.minimumSkill;
    data['certificate'] = this.certificate;
    data['housing'] = this.housing;
    data['state'] = this.state;
    return data;
  }
}
