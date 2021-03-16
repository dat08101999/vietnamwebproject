import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WidgetReadimage extends StatefulWidget {
  @override
  _WidgetReadimageState createState() => _WidgetReadimageState();
}

class _WidgetReadimageState extends State<WidgetReadimage> {
  Future<File> imageFile;

  pickImageFromGallery(ImageSource source) {
    imageFile = ImagePicker.pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlatButton(
          child: Text('Chọn ảnh'),
          onPressed: () {
            Future<File> imageFile;
            pickImageFromGallery(ImageSource.gallery);
          },
        ),
        //Image.file(File());
      ],
    );
  }
}
