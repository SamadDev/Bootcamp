import 'dart:io';

import 'package:bootcamps/Providers/Course.dart';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CoursePostScreen extends StatefulWidget {
  static const route = '/PostCourseScreen';

  @override
  _CoursePostScreenState createState() => _CoursePostScreenState();
}

class _CoursePostScreenState extends State<CoursePostScreen> {
  //upload video__________________________________
  Map<String, String> _paths;
  String _extension;
  List<StorageUploadTask> videos = <StorageUploadTask>[];
  List videoUil = [];
  List videoPath = [];

  //______________________________________________
  var photo = TextEditingController();
  final title = TextEditingController();
  final weeks = TextEditingController();
  final tuition = TextEditingController();
  final language = TextEditingController();
  final category = TextEditingController();
  final description = TextEditingController();
  final descriptionKr = TextEditingController();
  final descriptionAr = TextEditingController();
  final titleKr = TextEditingController();
  final titleAr = TextEditingController();
  bool certificate = false;
  bool housing = false;
  String minSkill = "beginner";
  String state = "online";

//_________________________________________________

  final _form = GlobalKey<FormState>();
  var _course = CourseData(
      title: '',
      photo: 'https://static.thenounproject.com/png/187803-200.png',
      weeks: '',
      tuition: '',
      certificate: false,
      minimumSkill: 'intermediate',
      description: '',
      language: '');

  var _isLoading = false;

  var _initValues = {
    'title': '',
    'description': '',
    'weeks': '',
    'tuition': '',
    'minimumSkill': 'intermediate',
    'photo': '',
    'certificate': false,
    'language': ''
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
        _initValues = {
          'title': _course.title,
          'description': _course.description,
          'weeks': _course.weeks.toString(),
          'tuition': _course.tuition.toString(),
          'minimumSkill': _course.minimumSkill,
          'certificate': _course.certificate,
          'language': _course.certificate
        };
      }
    }
    setState(() {
      _didChange = false;
    });

    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (courseId != null) {
      await Provider.of<Course>(context, listen: false)
          .updateCourse(courseId, _course, context);
    } else
      await Provider.of<Course>(context, listen: false).postCourse(
          context: context,
          userId: Profile.userId,
          language: language.text,
          state: state,
          certificate: certificate,
          title: title.text,
          titleKr: titleKr.text,
          descriptionKr: descriptionKr.text,
          titleAr: titleAr.text,
          descriptionAr: descriptionAr.text,
          category: category.text,
          description: description.text,
          housing: housing,
          minimumSkill: minSkill,
          photo: _uploadImage,
          tuition: tuition.text,
          videoPath: videoPath,
          videos: videoUil,
          weeks: weeks.text);

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
      print(error);
    }
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    //upload video____________________________
    List<Widget> children = <Widget>[];
    videos.forEach((video) {
      final Widget tile = UploadTaskListTile(
        task: video,
        onDismissed: () => setState(() => videos.remove(video)),
        onDownload: () => downloadFile(video.lastSnapshot.ref),
      );
      children.add(tile);
    });
    //____________________________________________

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
                    GestureDetector(
                        onTap: () {
                          takePicture();
                        },
                        child: Container(
                            height: height,
                            width: width,
                            child: _storedImage == null
                                ? _course.photo == null
                                    ? Image.network(
                                        'https://static.thenounproject.com/png/187803-200.png')
                                    : Image.network(_course.photo)
                                : Image.file(
                                    _storedImage,
                                  ))),
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
                              controller: title,
                              // initialValue: _initValues['title'],
                              decoration: textFormField('title', 'title'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: description,
                              // initialValue: _initValues['description'],
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: titleKr,
                              // initialValue: _initValues['category'],
                              decoration: textFormField(
                                  'title kurdish', 'title kurdish'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: descriptionKr,
                              // initialValue: _initValues['category'],
                              decoration: textFormField(
                                  'description kurdish', 'description kurdish'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: titleAr,
                              // initialValue: _initValues['category'],
                              decoration:
                                  textFormField('title arabic', 'title arabic'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: descriptionAr,
                              // initialValue: _initValues['category'],
                              decoration: textFormField(
                                  'description arabic', 'description arabic'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: weeks,
                              // initialValue: _initValues['weeks'],
                              decoration: textFormField('weeks', 'weeks'),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: language,
                              // initialValue: _initValues['language'],
                              decoration: textFormField('language', 'language'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: category,
                              // initialValue: _initValues['category'],
                              decoration: textFormField('category', 'category'),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please provide a value.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: tuition,
                              // initialValue: _initValues['tuition'],
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
                                    certificate: _course.certificate,
                                    photo: _uploadImage);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: textFormField(
                                  'minimum skill', 'minimum skill'),
                              // value: _initValues['minimumSkill'] == null
                              //     ? 'beginner'
                              //     : _initValues['minimumSkill'],
                              items: [
                                DropdownMenuItem(
                                    child: Text('beginner'), value: 'beginner'),
                                DropdownMenuItem(
                                    child: Text('intermediate'),
                                    value: 'intermediate'),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  minSkill = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration:
                                  textFormField('certificate', 'certificate'),
                              // value: _initValues['certificate'],
                              items: [
                                DropdownMenuItem(
                                    child: Text('yes'), value: true),
                                DropdownMenuItem(
                                    child: Text('no'), value: false),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  certificate = value;
                                });
                              },
                            ),
                          ),
                          new Container(
                            height: 300,
                            width: 500,
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                OutlineButton(
                                  onPressed: () => openFileExplorer(),
                                  child: new Text("Open file picker"),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Flexible(
                                  child: ListView(
                                    children: children,
                                  ),
                                ),
                              ],
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

//upload video
  void openFileExplorer() async {
    try {
      _paths = await FilePicker.getMultiFilePath(
        type: FileType.video,
      );
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
  }

  uploadToFirebase() {
    _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
  }

  upload(fileName, filePath) {
    _extension = fileName.toString().split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(
        contentType: '$FileType.video/$_extension',
      ),
    );
    setState(() {
      videos.add(uploadTask);
    });
  }

  Future<void> downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    final String name = await ref.getName();
    final String path = await ref.getPath();
    setState(() {
      videoUil.add(url);
      videoPath.add(path);
      print("${videoUil}video path length is equal");
    });
    print(
      'Success!\nDownloaded $name \nUrl: $url'
      '\npath: $path \nBytes Count :: $byteCount',
    );
  }
}

class UploadTaskListTile extends StatelessWidget {
  const UploadTaskListTile({this.task, this.onDismissed, this.onDownload});

  final StorageUploadTask task;
  final VoidCallback onDismissed;
  final VoidCallback onDownload;

  String get status {
    String result;
    if (task.isComplete) {
      if (task.isSuccessful) {
        result = 'Complete';
      } else if (task.isCanceled) {
        result = 'Canceled';
      } else {
        result = 'Failed ERROR: ${task.lastSnapshot.error}';
      }
    } else if (task.isInProgress) {
      result = 'Uploading';
    } else if (task.isPaused) {
      result = 'Paused';
    }
    return result;
  }

  String _bytesTransferred(StorageTaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalByteCount}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StorageTaskEvent>(
      stream: task.events,
      builder: (BuildContext context,
          AsyncSnapshot<StorageTaskEvent> asyncSnapshot) {
        Widget subtitle;
        if (asyncSnapshot.hasData) {
          final StorageTaskEvent event = asyncSnapshot.data;
          final StorageTaskSnapshot snapshot = event.snapshot;
          subtitle = Text('$status: ${_bytesTransferred(snapshot)} bytes sent');
        } else {
          subtitle = const Text('Starting...');
        }
        return Dismissible(
          key: Key(task.hashCode.toString()),
          onDismissed: (_) => onDismissed(),
          child: ListTile(
            title: Text('Upload Task #${task.hashCode}'),
            subtitle: subtitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: !task.isInProgress,
                  child: IconButton(
                    icon: const Icon(Icons.pause),
                    onPressed: () => task.pause(),
                  ),
                ),
                Offstage(
                  offstage: !task.isPaused,
                  child: IconButton(
                    icon: const Icon(Icons.file_upload),
                    onPressed: () => task.resume(),
                  ),
                ),
                Offstage(
                  offstage: task.isComplete,
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => task.cancel(),
                  ),
                ),
                Offstage(
                  offstage: !(task.isComplete && task.isSuccessful),
                  child: IconButton(
                    icon: const Icon(Icons.file_download),
                    onPressed: onDownload,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
