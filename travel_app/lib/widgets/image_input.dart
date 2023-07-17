import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathSystem;

class ImageInput extends StatefulWidget {
  final Function takeImage;
  ImageInput(this.takeImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _ImageFile;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (photo != null) {
      setState(() {
        _ImageFile = File(photo.path);
      });

      final pathProvider = await pathSystem.getApplicationDocumentsDirectory();
      final fileName = path.basename(photo.path);
      final savedImages =
          await _ImageFile!.copy("${pathProvider.path}/$fileName.");

          print(pathProvider);

      widget.takeImage(savedImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _ImageFile != null
              ? Image.file(
                  _ImageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("There is no picture"),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: Icon(Icons.camera),
          label: Text("Add Photo"),
        ),
      ],
    );
  }
}
