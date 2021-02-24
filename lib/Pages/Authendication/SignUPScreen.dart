import 'package:bootcamps/Pages/Authendication/LoginScreen.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Authendication/TextFieldAuthendication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SingUPScreen extends StatelessWidget {
  static const route = "/SignUPScreen";

  final userRole;

  SingUPScreen({this.userRole});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  Widget build(BuildContext context) {
    var isLoading = Provider.of<BootCamp>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                  radius: 60,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SvgPicture.asset("assets/images/person.svg"),
                      Container(
                        margin: EdgeInsets.all(7),
                        child: Icon(
                          Icons.add_a_photo,
                          color: AppTheme.black1,
                        ),
                      )
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height / 1.1,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    textField(context, "name", Icons.person,
                        TextInputType.emailAddress,
                        textCont: name),
                    textField(context, "Email", Icons.email,
                        TextInputType.emailAddress,
                        textCont: email),
                    textField(
                        context, "password", Icons.vpn_key, TextInputType.text,
                        textCont: password, suffixIcon: Icons.visibility),
                    textField(context, "confirm password", Icons.vpn_key,
                        TextInputType.text,
                        textCont: confirmPassword,
                        suffixIcon: Icons.visibility),
                    textField(
                        context, "role", Icons.people, TextInputType.text),
                    SizedBox(
                      height: 30,
                    ),
                    isLoading.isLoading
                        ? CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () async {
                              isLoading.changeIsLoading();
                              await Provider.of<Auth>(context, listen: false)
                                  .logIn(email.text, password.text, context);
                            },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              direction: Axis.vertical,
                              spacing: 10,
                              children: [
                                Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  decoration: BoxDecoration(
                                      color: AppTheme.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      'Sign UP',
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'have an account?',
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed(LoginScreen.route);
                                      },
                                      child: Text(
                                        'Log In',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
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
      ),
    );
  }
}
