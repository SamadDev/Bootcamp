// InkWell(
// splashColor: Colors.transparent,
// onTap: () {
// callback();
// },
// child: SizedBox(
// width: 280,
// child: Stack(
// children: <Widget>[
// Container(
// child: Row(
// children: <Widget>[
// const SizedBox(
// width: 48,
// ),
// Expanded(
// child: Container(
// decoration: BoxDecoration(
// color: HexColor('#F8FAFB'),
// borderRadius:
// const BorderRadius.all(Radius.circular(0.0)),
// ),
// child: Row(
// children: <Widget>[
// const SizedBox(
// width: 48 + 24.0,
// ),
// Expanded(
// child: Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Padding(
// padding: const EdgeInsets.only(top: 16),
// child: Text(
// category.title,
// textAlign: TextAlign.left,
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: 16,
// letterSpacing: 0.27,
// color: DesignCourseAppTheme.darkerText,
// ),
// ),
// ),
// const Expanded(
// child: SizedBox(),
// ),
// Padding(
// padding: const EdgeInsets.only(
// right: 16, bottom: 8),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: <Widget>[
// Text(
// '${category.lessonCount} lesson',
// textAlign: TextAlign.left,
// style: TextStyle(
// fontWeight: FontWeight.w200,
// fontSize: 12,
// letterSpacing: 0.27,
// color: DesignCourseAppTheme.grey,
// ),
// ),
// Container(
// child: Row(
// children: <Widget>[
// Text(
// '${category.rating}',
// textAlign: TextAlign.left,
// style: TextStyle(
// fontWeight: FontWeight.w200,
// fontSize: 18,
// letterSpacing: 0.27,
// color:
// DesignCourseAppTheme.grey,
// ),
// ),
// Icon(
// Icons.star,
// color: DesignCourseAppTheme
//     .nearlyBlue,
// size: 20,
// ),
// ],
// ),
// )
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(
// bottom: 16, right: 16),
// child: Text(
// '\$${category.money}',
// textAlign: TextAlign.left,
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: 18,
// letterSpacing: 0.27,
// color: DesignCourseAppTheme.nearlyBlue,
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// )
// ],
// ),
// ),
// Container(
// child: Padding(
// padding: const EdgeInsets.only(top: 24, bottom: 24, left: 16),
// child: Row(
// children: <Widget>[
// ClipRRect(
// borderRadius:
// const BorderRadius.all(Radius.circular(16.0)),
// child: AspectRatio(
// aspectRatio: 1.0,
// child: Image.network(
// 'https://www.winspireacademy.com/wp-content/uploads/2019/06/Ielts.jpg',
// fit: BoxFit.fill,
// )),
// )
// ],
// ),
// ),
// ),
// ],
// ),
// ),
// );