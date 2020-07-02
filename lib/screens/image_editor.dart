import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
class ImageEditorPage extends StatefulWidget {
  Function onFilterApply;
  ImageEditorPage({this.onFilterApply});

  @override
  _ImageEditorPageState createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  String fileName;
  static List<Filter> presetFiltersList = [
    NoFilter(),
    LarkFilter(),
    InkwellFilter(),
    MoonFilter(),
    // AddictiveBlueFilter(),
    // AddictiveRedFilter(),
    AdenFilter(),
    AmaroFilter(),
    AshbyFilter(),
    // BrannanFilter(),
    // BrooklynFilter(),
    // CharmesFilter(),
    // ClarendonFilter(),
    // CremaFilter(),
    // DogpatchFilter(),
    // EarlybirdFilter(),
    // F1977Filter(),
    // GinghamFilter(),
    // GinzaFilter(),
    // HefeFilter(),
    // HelenaFilter(),
    HudsonFilter(),
    JunoFilter(),
    // KelvinFilter(),
    LoFiFilter(),
    LudwigFilter(),
    // MavenFilter(),
    MayfairFilter(),
    NashvilleFilter(),
    // PerpetuaFilter(),
    ReyesFilter(),
    RiseFilter(),
    // SierraFilter(),
    SkylineFilter(),
    SlumberFilter(),
    // StinsonFilter(),
    SutroFilter(),
    // ToasterFilter(),
    // ValenciaFilter(),
    VesperFilter(),
    // WaldenFilter(),
    WillowFilter(),
    // XProIIFilter(),
  ];
  List<Filter> filters = presetFiltersList;
  File imageFile;

  Future getImage(context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName = basename(imageFile.path);
    var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    image = imageLib.copyResize(image, width: 600);
    Map imagefile = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter Example"),
          image: image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      setState(() {
        imageFile = imagefile['image_filtered'];
      });
      widget.onFilterApply(imageFile.path);
      imagefile = null;
      print(imageFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: () => getImage(context),
          child: new Icon(Icons.add_a_photo),
        ),
      ],
    );
  }
}
