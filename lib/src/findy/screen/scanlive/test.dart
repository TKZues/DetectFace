import 'dart:io';

import 'package:findy/src/findy/repositories/detectface_repositories.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CheckFace extends StatefulWidget {
  final String classID;
  const CheckFace({super.key, required this.classID});

  @override
  // ignore: library_private_types_in_public_api
  _CheckFaceState createState() => _CheckFaceState();
}

class _CheckFaceState extends State<CheckFace> {
  XFile? _imageFile;
  File? filePath;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
      filePath = File(_imageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _imageFile == null
                  ? const Text('No image selected.')
                  : Image.file(File(_imageFile!.path)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              ElevatedButton(
                onPressed: () {
                  SignUpRepositories().checkface(filePath1: filePath!.path, classID: widget.classID);
                },
                child: const Text('Pick Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
