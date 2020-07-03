import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List urls = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Welcome In SplashScreen Package list"),
          automaticallyImplyLeading: false),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: urls.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () => {
                OpenFile.open(urls[index]),
              },
              child: Text(urls[index]),
            ),
          );
        },
      ),
    );
  }

  getDataFromStorage() async {
    var _prefs = await SharedPreferences.getInstance();
    var list = _prefs.getString('pdfList');
    if (list != null) {
      urls = json.decode(list);
      setState(() {});
      print(urls);
    }
  }
}
