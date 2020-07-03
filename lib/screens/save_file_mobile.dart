import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SaveFilehelper {
  static Future<void> saveAndOpenFile(List<int> bytes) async {
    var _prefs = await SharedPreferences.getInstance();
//Get external storage directory
    final directory = await getExternalStorageDirectory();
//Get directory path
    final path = directory.path;
    var rng = new Random();
    print(rng.nextInt(99999999));
    var filename = 'Output' +
        rng.nextInt(99999999).toString() +
        new DateTime(2020).toIso8601String() +
        '.pdf';
//Create an empty file to write PDF data
    File file = File('$path/$filename');
    var list = _prefs.getString('pdfList');
    List urls = [];
    if (list != null) {
      urls = json.decode(list);
      print(urls);
    }
    urls.add('$path/$filename');
    _prefs.setString("pdfList", json.encode(urls));
//Write PDF data
    await file.writeAsBytes(bytes, flush: true);

//Open the PDF document in mobile
    OpenFile.open('$path/$filename');
  }
}
