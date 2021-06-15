class Test {
  String id;
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
  String language;
  List videoPath;
  List videos;

  Test({
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
    this.language,
    this.videoPath,
    this.videos
  });

  Test.fromJson(Map element) {
    id=element['_id'];
    user= element['user'];
    photo= element['photo'];
    description= element['description'];
    title= element['title'];
    minimumSkill= element['minimumSkill'];
    tuition= element['tuition'];
    weeks= element['weeks'].toString();
    view= element['averageView'];
    averageRating= element['averageRating'];
    housing= element['housing'];
    certificate= element['certificate'];
    state= element['state'];
    typeSkill= element['typeSkill'];
    language= element['language'];
    videoPath= element['videoPath'];
    videos= element['cVideos'];
  }

  // Map toJson() {
  //   final Map data = new Map();
  //   data['_id'] = this.id;
  //   data['typeSkill'] = this.typeSkill;
  //   data['link'] = this.courseLink;
  //   data['user'] = this.user;
  //   data['photo'] = this.photo;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   data['weeks'] = this.weeks;
  //   data['tuition'] = this.tuition;
  //   data['minimumSkill'] = this.minimumSkill;
  //   data['certificate'] = this.certificate;
  //   data['housing'] = this.housing;
  //   data['state'] = this.state;
  //   return data;
  // }
}
