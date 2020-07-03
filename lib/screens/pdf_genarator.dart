import 'dart:io';
import 'package:doc_scanner/screens/image_editor.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:doc_scanner/screens/save_file_mobile.dart';
import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class PDFGenerator extends StatefulWidget {
  @override
  _PDFGeneratorState createState() => _PDFGeneratorState();
}

class _PDFGeneratorState extends State<PDFGenerator> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          // Container(
          //   child:
          //       FlatButton(onPressed: () => {}, child: Text('Selected Image')),
          // ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // FlatButton(
                //   child: Text(
                //     'Generate PDF',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   onPressed: () => {ImageEditorPage()},
                //   color: Colors.blue,
                // ),
                ImageEditorPage(
                  onFilterApply: getImage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getImage(url) async {
File croppedFile = await ImageCropper.cropImage(
      sourcePath: url,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      )
    );

    // List<File> files = await FilePicker.getMultiFile(
    //   type: FileType.custom,
    //   allowedExtensions: ['jpg', 'pdf', 'doc'],
    // );
    File file = File(url);
    print(file.path);

    print(croppedFile.path);
    _createPDF([croppedFile.path]);
  }

  Future<void> _createPDF(List<String> files) async {
    final pdf = pw.Document();
    files.forEach((element) {
      final image = PdfImage.file(
        pdf.document,
        bytes: File(element).readAsBytesSync(),
      );
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(image),
        ); // Center
      }));
    });

    SaveFilehelper.saveAndOpenFile(pdf.save());
  }
}
