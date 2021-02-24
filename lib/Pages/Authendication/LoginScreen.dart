import 'package:bootcamps/Pages/Authendication/SignUPScreen.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Style/style.dart';
import 'package:bootcamps/Widgets/Authendication/TextFieldAuthendication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final userRole;

  LoginScreen({this.userRole});

  static const route = "/LoginScreen";
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController role = TextEditingController();
  Widget build(BuildContext context) {
    var isLoading = Provider.of<BootCamp>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
                        text: 'Welcome Back', context: context),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  textField(
                      context, "Email", Icons.email, TextInputType.emailAddress,
                      textCont: email),
                  textField(context, "password", Icons.lock, TextInputType.text,
                      textCont: password, suffixIcon: Icons.visibility),
                  textField(context, "role", Icons.people, TextInputType.text),
                  SizedBox(
                    height: 100,
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
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                    color: AppTheme.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Center(
                                  child: Text(
                                    'LOG IN',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Don\'n have an account?',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SingUPScreen.route);
                                    },
                                    child: Text(
                                      'Sign UP',
                                      style:
                                          Theme.of(context).textTheme.headline5,
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
