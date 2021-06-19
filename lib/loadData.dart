import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String route = '/splash';


  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _fetchData() async {
    // await Provider.of<AppStates>(context, listen: false).getMode();
    // await Provider.of<Language>(context, listen: false)
    //     .getLanguageDataInLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchData(),
        builder: (context, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: Container(),
        )
            : Text('')/*HomePage(),*/
      ),
    );
  }
}