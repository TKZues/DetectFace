import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

import '../../../../constant/color.dart';
import '../../../../utils/config/size_config.dart';
import '../../../../widget/text/textcustom.dart';

List<CameraDescription>? cameras;

class FaceDetectorApp extends StatelessWidget {
  const FaceDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Face Detector",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FaceDetectorInitializer(),
    );
  }
}

class FaceDetectorInitializer extends StatefulWidget {
  const FaceDetectorInitializer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FaceDetectorInitializerState createState() =>
      _FaceDetectorInitializerState();
}

class _FaceDetectorInitializerState extends State<FaceDetectorInitializer> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Permission.camera.request();
    cameras = await availableCameras();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (cameras == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return const FaceDetectorView();
  }
}

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(enableContours: true, enableClassification: true),
  );
  bool isBusy = false;
  CustomPaint? customPaint;
  Uint8List? detectedFaceImage;

  @override
  void dispose() {
    faceDetector.close();
    super.dispose();
  }



  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (faces.isNotEmpty) {
      final boundingBox = faces[0].boundingBox;
      final faceImage = await _cropFaceImage(inputImage, boundingBox);
      setState(() {
        detectedFaceImage = faceImage;
      });
      // ignore: avoid_print
      print("Smile probability: ${faces[0].smilingProbability}");
    }
    isBusy = false;
  }

  Future<Uint8List?> _cropFaceImage(InputImage inputImage, Rect boundingBox) async {
  try {
    final Uint8List? bytes = inputImage.bytes;
    if (bytes == null) {
      print('No image bytes available');
      return null;
    }

    

    final img.Image? originalImage = img.decodeImage(bytes);
    if (originalImage == null) {
      print('Failed to decode image');
      return null;
    }

    final left = boundingBox.left.toInt();
    final top = boundingBox.top.toInt();
    final width = boundingBox.width.toInt();
    final height = boundingBox.height.toInt();

    if (left < 0 || top < 0 || width <= 0 || height <= 0 ||
        left + width > originalImage.width ||
        top + height > originalImage.height) {
      print('Invalid bounding box dimensions');
      return null;
    }

    final img.Image croppedImage = img.copyCrop(
      originalImage,
      y: top,
      x: left,
      width: width,
      height: height,
    );

    final Uint8List croppedImageBytes = Uint8List.fromList(img.encodeJpg(croppedImage));
    return croppedImageBytes;
  } catch (e) {
    print('Error cropping image: $e');
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: "Face Detector",
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
      detectedFaceImage: detectedFaceImage,
    );
  }
}

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
    required this.title,
    this.customPaint,
    required this.onImage,
    required this.initialDirection,
    this.detectedFaceImage,
  });

  final String title;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;
  final Uint8List? detectedFaceImage;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;
  int _cameraIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < cameras!.length; i++) {
      if (cameras![i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
    _startLiveFeed();
  }

  Future _startLiveFeed() async {
    final camera = cameras![_cameraIndex];
    _controller =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }

    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final camera = cameras![_cameraIndex];

    final imageRotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final planeData = image.planes.map((Plane plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width);
    }).toList();

    final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData);

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  Widget _liveFeedBody() {
    if (_controller?.value.isInitialized == false) {
      return Container();
    }

    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width - 40,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          CameraPreview(_controller!),
          if (widget.customPaint != null) widget.customPaint!,
          if (widget.detectedFaceImage != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                child: Image.memory(widget.detectedFaceImage!),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        title: TextCustom(
          text: "Quét khuôn mặt",
          color: Colors.white,
          fontSize: psHeight(16),
        ),
        leading: GFIconButton(
          icon: Container(
            padding: EdgeInsets.symmetric(
                horizontal: psWidth(3), vertical: psHeight(4)),
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
            Navigator.popUntil(context, ModalRoute.withName("/bottom"));
          },
          type: GFButtonType.transparent,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Text(
              "Để khuôn mặt ở giữa khung hình",
              style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: DottedBorder(
              borderType: BorderType.Oval,
              padding: const EdgeInsets.all(16),
              strokeWidth: 14,
              dashPattern: const [2, 3],
              color: Colors.grey.shade500,
              child: ClipOval(
                child: _liveFeedBody(),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
