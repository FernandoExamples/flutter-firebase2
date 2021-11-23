import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageSelector {
  Future<XFile?> _getPicture({required ImageSource source}) async {
    final _image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    return _image;
  }

  Future<File> persistImageInStorage(XFile image) async {
    //get new image path
    Directory? directory = await getExternalStorageDirectory();
    String fileName = path.basename(image.path);
    String imagePath = path.join(directory!.path, fileName);
    //save image
    await image.saveTo(imagePath);
    return File(imagePath);
  }

  Future<XFile?> showSelectionDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Galería'),
                  onTap: () async {
                    final file = await _getPicture(source: ImageSource.gallery);
                    Navigator.of(context).pop(file);
                  }),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Cámara'),
                onTap: () async {
                  final file = await _getPicture(source: ImageSource.camera);
                  Navigator.of(context).pop(file);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
