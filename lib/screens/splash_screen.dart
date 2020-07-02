import 'package:doc_scanner/screens/tabbed_view.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
class CustumSplashScreen extends StatefulWidget {
  @override
  _CustumSplashScreenState createState() => _CustumSplashScreenState();
}

class _CustumSplashScreenState extends State<CustumSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
        seconds: 4,
        navigateAfterSeconds: new TabbedViewPage(),
        title: new Text(
          'Welcome In SplashScreen',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
    ;
  }
}
