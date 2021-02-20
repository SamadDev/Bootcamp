import 'dart:io';
import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CoursePostScreen extends StatefulWidget {
  static const route = '/PostCourseScreen';

  final bootcampId;

  CoursePostScreen({this.bootcampId});

  @override
  _CoursePostScreenState createState() => _CoursePostScreenState();
}

class _CoursePostScreenState extends State<CoursePostScreen> {
  final _form = GlobalKey<FormState>();
  var _course = CourseData(
    title: '',
    photo: 'https://static.thenounproject.com/png/187803-200.png',
    weeks: '',
    tuition: '',
    scholarshipAvailable: false,
    minimumSkill: 'intermediate',
    description: '',
  );

  var _isLoading = false;

  var _initValues = {
    'title': '',
    'description': '',
    'weeks': '',
    'tuition': '',
    'minimumSkill': 'intermediate',
    'photo': '',
    'scholarshipAvailable': false
  };
  bool _didChange = true;
  String courseId;

  @override
  void didChangeDependencies() {
    if (_didChange) {
      courseId = ModalRoute.of(context).settings.arguments as String;
      if (courseId != null) {
        _course = Provider.of<Course>(context, listen: false)
            .findCourseById(courseId);
        print(courseId);
        _initValues = {
          'title': _course.title,
          'description': _course.description,
          'weeks': _course.weeks.toString(),
          'tuition': _course.tuition.toString(),
          'minimumSkill': _course.minimumSkill,
          'scholarshipAvailable': _course.scholarshipAvailable
        };
      }
    }
    setState(() {
      _didChange = false;
    });

    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    print(courseId);
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (courseId != null) {
      await Provider.of<Course>(context, listen: false)
          .updateCourse(courseId, _course, context);
    } else
      await Provider.of<Course>(context, listen: false).postCourse(
          course: _course,
          context: context,
          bootcampId: '5ffb5c69fa02d20024d0e927');

    setState(() {
      _isLoading = false;
    });
  }

  //take picture and uploaded
  var _uploadImage;
  File _storedImage;

  Future<void> takePicture() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _storedImage = imageFile;
    });
  }

  bool disable = false;

  Future _getUpload() async {
    try {
      final StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(DateTime.now().toString());
      final StorageUploadTask task = firebaseStorageRef.putFile(_storedImage);

      var downUrl = await (await task.onComplete).ref.getDownloadURL();
      var url = downUrl.toString();
      var urlConcat = (url + "jpg");
      print(urlConcat);
      print(_getUpload);

      setState(() {
        _uploadImage = urlConcat;
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  title: Text(
                    "Image Error!",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  content: Text(
                    'pleas select the image in then upload',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  actions: [
                    FlatButton(
                      child: Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
    }
  }

  bool isSelected = false;
  String sholarShip = "jobAssistance";

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height / 3.5;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'), // if(_storedImage != null){
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // GestureDetector(
                    //     onTap: () {
                    //       takePicture();
                    //     },
                    //     child: Container(
                    //         height: height,
                    //         width: width,
                    //         child: _storedImage == null
                    //             ? _course.photo == null
                    //                 ? Image.network(
                    //                     'https://static.thenounproject.com/png/187803-200.png')
                    //                 : Image.network(_course.photo)
                    //             : Image.file(
                    //                 _storedImage,
                    //               ))),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 15, left: 15, bottom: 25),
                      child: Column(
                        children: [
                          ActionChip(
                            avatar:
                                isSelected ? CircularProgressIndicator() : null,
                            label: Text(
                                '${isSelected ? 'Uploading...' : '   Upload   '}'),
                            labelStyle: TextStyle(color: Colors.white),
                            onPressed: () async {
                              setState(() {
                                isSelected = !isSelected;
                              });
                              await _getUpload();
                              isSelected = false;
                            },
                            backgroundColor: Colors.black54,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: _initValues['title'],
                              decoration: textFormField('title', 'title'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _course = CourseData(
                                    title: value,
                                    description: _course.description,
                                    minimumSkill: _course.minimumSkill,
                                    weeks: _course.weeks,
                                    tuition: _course.tuition,
                                    scholarshipAvailable:
                                        _course.scholarshipAvailable,
                                    photo: _uploadImage);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: _initValues['description'],
                              decoration:
                                  textFormField('description', 'description'),
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _course = CourseData(
                                    title: _course.title,
                                    description: value,
                                    minimumSkill: _course.minimumSkill,
                                    weeks: _course.weeks,
                                    tuition: _course.tuition,
                                    scholarshipAvailable:
                                        _course.scholarshipAvailable,
                                    photo: _uploadImage);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: _initValues['weeks'],
                              decoration: textFormField('weeks', 'weeks'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _course = CourseData(
                                    title: _course.title,
                                    description: _course.description,
                                    minimumSkill: _course.minimumSkill,
                                    weeks: value,
                                    tuition: _course.tuition,
                                    scholarshipAvailable:
                                        _course.scholarshipAvailable,
                                    photo: _uploadImage);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: _initValues['tuition'],
                              decoration:
                                  textFormField('tuition \$', 'tuition'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _course = CourseData(
                                    title: _course.title,
                                    description: _course.description,
                                    minimumSkill: _course.minimumSkill,
                                    weeks: _course.weeks,
                                    tuition: value,
                                    scholarshipAvailable:
                                        _course.scholarshipAvailable,
                                    photo: _uploadImage);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: textFormField(
                                  'minimum skill', 'minimum skill'),
                              value: _initValues['minimumSkill'] == null
                                  ? 'beginner'
                                  : _initValues['minimumSkill'],
                              items: [
                                DropdownMenuItem(
                                    child: Text('beginner'), value: 'beginner'),
                                DropdownMenuItem(
                                    child: Text('intermediate'),
                                    value: 'intermediate'),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _course = CourseData(
                                      title: _course.title,
                                      description: _course.description,
                                      minimumSkill: value,
                                      weeks: _course.weeks,
                                      tuition: _course.minimumSkill,
                                      scholarshipAvailable:
                                          _course.scholarshipAvailable,
                                      photo: _uploadImage);
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: textFormField('scholarship available',
                                  'scholarship available'),
                              value: _initValues['scholarshipAvailable'],
                              items: [
                                DropdownMenuItem(
                                    child: Text('yes'), value: true),
                                DropdownMenuItem(
                                    child: Text('no'), value: false),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _course = CourseData(
                                      title: _course.title,
                                      description: _course.description,
                                      minimumSkill: _course.minimumSkill,
                                      weeks: _course.weeks,
                                      tuition: _course.tuition,
                                      scholarshipAvailable: value,
                                      photo: _uploadImage);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
