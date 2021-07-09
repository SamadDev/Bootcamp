class CourseModule {
  String id;
  bool certificate;
  bool housing;
  String state;
  String typeSkill;
  String courseLink;
  String title;
  String description;
  var weeks;
  var tuition;
  String minimumSkill;
  String photo;
  var averageRating;
  var view;
  String user;

  CourseModule({
    this.id,
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

  CourseModule.fromJson(Map<String, dynamic> element) {
    id = element['_id'];
    user = element['user'];
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
}
