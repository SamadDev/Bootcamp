import 'package:bootcamps/Pages/Authendication/SignUPScreen.dart';
import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                      )),
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          height: 130,
                          width: 130,
                          child: SvgPicture.asset("assets/images/person.svg"))),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(SingUPScreen.route);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 45, left: 55, right: 30),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Sign UP',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 80),
              child: Column(
                children: <Widget>[
                  textField(context, email, "Email", Icon(Icons.email),
                      TextInputType.emailAddress),
                  textField(context, password, "password", Icon(Icons.vpn_key),
                      TextInputType.text),
                  textField(context, role, "role", Icon(Icons.person),
                      TextInputType.text),
                  Spacer(),
                  isLoading.isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () async {
                            isLoading.changeIsLoading();
                            await Provider.of<Auth>(context, listen: false)
                                .logIn(email.text, password.text, context);
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width / 1.2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.lightBlueAccent,
                                  Color(0xFF44a6c6)
                                ]),
                                // color: Colors.lightBlueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: Center(
                              child: Text(
                                'Login'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
