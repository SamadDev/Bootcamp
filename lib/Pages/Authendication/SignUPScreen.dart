import 'dart:io';
import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Authendication/LoginScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Providers/state.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/Authendication/TextFieldAuthendication.dart';
import 'package:bootcamps/Widgets/Authendication/UserRole.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SingUPScreen extends StatefulWidget {
  static const route = "/SignUpScreen";
  final userRole;

  SingUPScreen({this.userRole});

  _SingUPScreenState createState() => _SingUPScreenState();
}

class _SingUPScreenState extends State<SingUPScreen> {
  File _storedImage;
  String _image;

  Future<void> takePicture() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _storedImage = imageFile;
    });
  }

  bool disable = false;

  Future _getUpload() async {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(DateTime.now().toString());
    final StorageUploadTask task = firebaseStorageRef.putFile(_storedImage);

    var downUrl = await (await task.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    var urlConcat = (url + "jpg");
    print(urlConcat);

    setState(() {
      _image = urlConcat;
    });
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();

  Widget build(BuildContext context) {
    final language = Provider.of<Language>(context, listen: false);
    var isLoading = Provider.of<StateChange>(context);
    var isShow = Provider.of<StateChange>(context, listen: false);
    return Scaffold(
      appBar: isLoading.isLoading
          ? AppBar(
              elevation: 0,
              leading: SizedBox.shrink(),
            )
          : AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(60)),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  _storedImage == null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: SvgPicture.asset("assets/images/person.svg"))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.file(_storedImage)),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Theme.of(context).buttonColor,
                      ),
                      onPressed: () {
                        takePicture();
                      },
                      color: AppTheme.black1,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  textField(context, language.words['name'], Icons.person,
                      TextInputType.text,
                      textCont: name, isObscure: false),
                  textField(context, language.words['user name'], Icons.person,
                      TextInputType.text,
                      textCont: userName, isObscure: false),
                  textField(context, language.words['email'], Icons.email,
                      TextInputType.emailAddress,
                      textCont: email, isObscure: false),
                  textField(context, language.words['password'], Icons.vpn_key,
                      TextInputType.text,
                      textCont: password,
                      isObscure: isShow.isShow,
                      iconButton: IconButton(
                        icon: isShow.isShow
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          Provider.of<StateChange>(context, listen: false)
                              .changeIsShow();
                        },
                      )),
                  roleType(
                      context: context,
                      text: widget.userRole == 'user'
                          ? language.words['user']
                          : language.words['teacher']),
                  SizedBox(
                    height: 30,
                  ),
                  isLoading.isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            if (name.text == '' ||
                                email.text == '' ||
                                _storedImage == null ||
                                password.text == '' ||
                                userName.text == '') {
                              showEmpty(context);
                            } else {
                              isLoading.changeIsLoading();
                              await _getUpload();
                              await Provider.of<Auth>(context, listen: false)
                                  .signUp(
                                      name: name.text,
                                      email: email.text,
                                      userRole: widget.userRole,
                                      password: password.text,
                                      photo: _image,
                                      userName: userName.text,
                                      context: context);
                            }
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            direction: Axis.vertical,
                            spacing: 10,
                            children: [
                              Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                    color: AppTheme.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    language.words['sign up'],
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    language.words['have account'],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => LoginScreen(
                                                    userRole: widget.userRole,
                                                  )));
                                    },
                                    child: Text(
                                      language.words['log in'],
                                      style:
                                          Theme.of(context).textTheme.headline5.copyWith(decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget profile({storedImage, takePicture}) {
  return Container(
    height: 130,
    width: 130,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(60)),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        storedImage == null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                    "https://i.ibb.co/mbB2wdY/undraw-profile-pic-ic5t.png"))
            : ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.file(
                  storedImage,
                  fit: BoxFit.fill,
                )),
        Container(
          child: IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              takePicture();
            },
            color: AppTheme.black1,
          ),
        )
      ],
    ),
  );
}
