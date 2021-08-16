import 'dart:io';
import 'package:bootcamps/Providers/profile.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  static const route = "/ProfileEdit";

  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _form = GlobalKey<FormState>();
  var _user = User(
    name: '',
    email: '',
    photo: '',
  );

  final name = TextEditingController();
  final email = TextEditingController();
  var _uploadImage;
  File _storedImage;

  var _isLoading = false;

  Future<void> _saveForm() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Profile>(context, listen: false)
        .updateDetailProfile(newUser: _user, context: context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    final data = Provider.of<Profile>(context, listen: false).userData;
    name.text = data.name;
    email.text = data.email;
    _uploadImage = data.photo;
    super.didChangeDependencies();
  }

  //take picture and uploaded

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

      setState(() {
        _uploadImage = urlConcat;
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (_) => Container(
                child: AlertDialog(
                  titleTextStyle: GoogleFonts.adventPro(),
                  title: Text("Image not selected\nPleas add image"),
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

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('$name ___ $email ____ $_uploadImage');
        },
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              takePicture();
                            },
                            child: CircleAvatar(
                              backgroundColor: AppTheme.transparent,
                              child: _storedImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        _storedImage,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.network(
                                        _uploadImage,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      )),
                              radius: 75,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 30),
                        child: ActionChip(
                          avatar:
                              isSelected ? CircularProgressIndicator() : null,
                          label: Text(
                              '${isSelected ? 'Uploading...' : '    Upload    '}'),
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: name,
                          decoration: textFormField('name', 'name'),
                          onSaved: (value) {
                            _user = User(
                                name: value,
                                email: _user.email,
                                photo: _uploadImage);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                            controller: email,
                            decoration: textFormField('email', 'email'),
                            onSaved: (value) {
                              _user = User(
                                  name: _user.name,
                                  email: value,
                                  photo: _uploadImage);
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ActionChip(
                            label: Text('       Save Change      '),
                            onPressed: () {
                              _saveForm();
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 130, 130);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
