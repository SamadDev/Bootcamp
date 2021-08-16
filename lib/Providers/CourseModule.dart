class CourseModule {
  String id;
  bool certificate;
  bool housing;
  String userName;
  String userPhoto;
  String user;
  String state;
  String typeSkill;
  String courseLink;
  String title;
  String description;
  String titleAr;
  String descriptionAr;
  String titleKr;
  String descriptionKr;
  var weeks;
  var tuition;
  String minimumSkill;
  String photo;
  var averageRating;
  var view;


  CourseModule({
    this.id,
    this.userName,
    this.userPhoto,
    this.certificate,
    this.housing,
    this.state,
    this.typeSkill,
    this.courseLink,
    this.title,
    this.description,
    this.titleAr,
    this.descriptionAr,
    this.descriptionKr,
    this.titleKr,
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
    user = element['user']['_id'];
    userName=element['user']['name'];
    userPhoto=element['user']['photo'];
    photo = element['photo'];
    description = element['description'];
    title = element['title'];
    titleKr = element['titleKr'];
    descriptionKr = element['descriptionKr'];
    titleAr = element['titleAr'];
    descriptionAr = element['descriptionAr'];
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
