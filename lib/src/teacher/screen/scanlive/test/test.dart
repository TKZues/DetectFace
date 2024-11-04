import 'dart:io';
import 'dart:typed_data';
import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/detectface_repositories.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart'; // Import path_provider
import '../../../../../widget/text/textcustom.dart';

class CameraCapturePage extends StatefulWidget {
  final String subjectID;
    final String beginTime;
  final String endTime;
  const CameraCapturePage({super.key, required this.subjectID, required this.beginTime, required this.endTime});

  @override
  // ignore: library_private_types_in_public_api
  _CameraCapturePageState createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  File? _imageFile;
  Uint8List? _compressedImageBytes;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _compressImage(_imageFile!);
    } else {
      CustomSnackbar.snackbarError("Không thể chọn ảnh. Vui lòng thử lại!");
    }
  }

  Future<void> _compressImage(File file) async {
    try {
      final imageBytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image != null) {
        final compressedImage = img.encodeJpg(image, quality: 10);

        setState(() {
          _compressedImageBytes = Uint8List.fromList(compressedImage);
        });

        // int compressedSize = _compressedImageBytes!.lengthInBytes;
        // print("Kích thước ảnh sau khi nén: ${compressedSize / 1024} KB");
      }
    } catch (e) {
      // print("Lỗi khi nén ảnh: $e");
      CustomSnackbar.snackbarError("Có lỗi xảy ra khi nén ảnh.");
    }
  }

  Future<File> _saveCompressedImage() async {
    final tempDir = await getTemporaryDirectory(); // Lấy thư mục tạm thời
    final tempFile = File('${tempDir.path}/compressed_image.jpg');

    if (_compressedImageBytes != null) {
      await tempFile.writeAsBytes(_compressedImageBytes!); // Lưu ảnh nén
      return tempFile;
    } else {
      throw Exception("No compressed image available");
    }
  }

  void _sendImage() async {
    if (_compressedImageBytes != null) {
      try {
        File compressedFile = await _saveCompressedImage(); // Lưu ảnh nén ra file tạm thời

        // Gọi repository để gửi ảnh
        SignUpRepositories().checkface(
          filePath1: compressedFile.path, // Sử dụng đường dẫn của ảnh nén
          classID: widget.subjectID,
          beginTime: widget.beginTime, endTime: widget.endTime
        );
        CustomSnackbar.snackbarSuccess("Gửi ảnh thành công!");
      } catch (e) {
        CustomSnackbar.snackbarError("Có lỗi xảy ra khi gửi ảnh!");
        // print("Error sending compressed image: $e");
      }
    } else {
      CustomSnackbar.snackbarError("Vui lòng chọn và nén ảnh trước khi gửi!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        leading: GFIconButton(
          icon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: psWidth(3),
              vertical: psHeight(4),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(psHeight(4)),
              color: AppColor.backgbackColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.backiconColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        searchBar: true,
        title: TextCustom(
          text: "Chọn ảnh và gửi ảnh",
          color: Colors.white,
          fontSize: psHeight(16),
        ),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: psHeight(16),
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: ProgressHUD(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _compressedImageBytes != null
                    ? Image.memory(_compressedImageBytes!) // Hiển thị ảnh đã nén
                    : _imageFile != null
                        ? Image.file(_imageFile!) // Hiển thị ảnh gốc nếu chưa nén
                        : const Text('Chưa có ảnh nào được chọn'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _captureImage,
                  child: const Text('Chọn ảnh từ thư viện'),
                ),
                ElevatedButton(
                  onPressed: _sendImage,
                  child: const Text('Gửi ảnh'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
