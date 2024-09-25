import 'dart:typed_data';

import 'package:flutter/material.dart';

class ScanState with ChangeNotifier {
  bool _isLoading = false;
  // bool _isCameraFlash = false;

  Uint8List? _capturedImage;

  bool get isLoading => _isLoading;
  Uint8List? get capturedImage => _capturedImage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // void cameraFlash() {
  //   _isCameraFlash = !_isCameraFlash;
  //   notifyListeners();
  // }
   void setCapturedImage(Uint8List? image) {
    _capturedImage = image;
    notifyListeners();
  }
}
