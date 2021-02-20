import 'package:bootcamps/Providers/LogIn.dart';
import 'package:bootcamps/Providers/Bootcamp.dart';
import 'package:bootcamps/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SingUPScreen extends StatelessWidget {
  static const route = "/SignUPScreen";
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    var isLoading = Provider.of<BootCamp>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Center(
          child: Text(
            "User SignUP",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
              Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  children: <Widget>[
                    textField(context, email, "Email", Icon(Icons.email),
                        TextInputType.emailAddress),
                    textField(context, password, "password",
                        Icon(Icons.vpn_key), TextInputType.text),
                    FlatButton(
                      onPressed: null,
                      child: textField(context, password, "User",
                          Icon(Icons.person), TextInputType.text),
                    ),
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
      ),
    );
  }
}
