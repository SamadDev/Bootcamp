import 'package:bootcamps/Localization/language.dart';
import 'package:bootcamps/Pages/Authendication/SignUPScreen.dart';
import 'package:bootcamps/Providers/Auth.dart';
import 'package:bootcamps/Providers/state.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Authendication/AuthendicationAlert.dart';
import 'package:bootcamps/Widgets/Authendication/TextFieldAuthendication.dart';
import 'package:bootcamps/Widgets/Authendication/UserRole.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final userRole;

  LoginScreen({this.userRole});

  static const route = "/LoginScreen";
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController role = TextEditingController();
  Widget build(BuildContext context) {


    var isLoading = Provider.of<StateChange>(context);
    final language=Provider.of<Language>(context,listen:false);
    var isShow = Provider.of<StateChange>(context, listen: false);
    // isLoading.isLoading=false;
    return Scaffold(
      appBar: isLoading.isLoading
          ? AppBar(
              elevation: 0,
              leading: SizedBox.shrink(),
            )
          : AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: textAuthendication(
                        text: language.words['welcome back'], context: context),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  textField(
                      context,language.words['email'], Icons.email, TextInputType.emailAddress,
                      textCont: email, isObscure: false),
                  textField(context, language.words["password"], Icons.lock, TextInputType.text,
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
                  roleType(context: context,  text:userRole == 'user'
                      ? language.words['user']
                      : language.words['teacher']),
                  SizedBox(
                    height: 100,
                  ),
                  isLoading.isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            if (email.text == '' || password.text == '') {
                              showEmpty(context);
                            } else {
                              isLoading.changeIsLoading();
                              await Provider.of<Auth>(context, listen: false)
                                  .logIn(email.text, password.text, userRole,
                                      context);
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
                                    language.words['log in'],
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    language.words['no account'],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (ctx) => SingUPScreen(
                                                    userRole: userRole,
                                                  )));
                                    },
                                    child: Text(
                                      language.words['sign up'],
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
            ),
          ],
        ),
      ),
    );
  }
}
