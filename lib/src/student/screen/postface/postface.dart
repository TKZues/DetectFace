import 'dart:io';
import 'package:findy/src/student/repositories/detectface_repositories.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Postface extends StatefulWidget {
  const Postface({super.key});

  @override
  State<Postface> createState() => _PostfaceState();
}

class _PostfaceState extends State<Postface> {
  final ImagePicker _picker = ImagePicker();
  TextEditingController controller = TextEditingController();

  File? _imageFile1;
  File? _imageFile2;
  File? _imageFile3;

  Future<void> _pickImage(int imageNumber) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        switch (imageNumber) {
          case 1:
            _imageFile1 = File(image.path);
            break;
          case 2:
            _imageFile2 = File(image.path);
            break;
          case 3:
            _imageFile3 = File(image.path);
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Face Upload'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _pickImage(1),
              child: const Text('Upload Face 1'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(2),
              child: const Text('Upload Face 2'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(3),
              child: const Text('Upload Face 3'),
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Label'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_imageFile1 != null && _imageFile2 != null && _imageFile3 != null) {
                  SignUpRepositories().postface(
                    filePath1: _imageFile1!.path,
                    filePath2: _imageFile2!.path,
                    filePath3: _imageFile3!.path,
                    label: controller.text,
                  );
                } else {
                  // Show a message to the user if all images are not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select all three images.')),
                  );
                }
              },
              child: const Text('Lưu'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const ImagePickerDemo(),));
              },
              child: const Text('Kiểm tra khuôn mặt'),
            ),
          ],
        ),
      ),
    );
  }
}
