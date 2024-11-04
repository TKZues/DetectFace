// import 'dart:developer';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:findy/src/findy/repositories/detectface_repositories.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:getwidget/getwidget.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../../../../constant/color.dart';
// import '../../../../utils/config/size_config.dart';
// import '../../../../widget/text/textcustom.dart';

// List<CameraDescription>? cameras;

// class FaceDetectorApp extends StatelessWidget {
//   final String subjectID;
//   const FaceDetectorApp({super.key, required this.subjectID});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Face Detector",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: FaceDetectorInitializer(
//         subjectID: subjectID,
//       ),
//     );
//   }
// }

// class FaceDetectorInitializer extends StatefulWidget {
//   final String subjectID;
//   const FaceDetectorInitializer({super.key, required this.subjectID});

//   @override
//   // ignore: library_private_types_in_public_api
//   _FaceDetectorInitializerState createState() =>
//       _FaceDetectorInitializerState();
// }

// class _FaceDetectorInitializerState extends State<FaceDetectorInitializer> {
//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }

//   Future<void> _initialize() async {
//     await Permission.camera.request();
//     cameras = await availableCameras();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (cameras == null) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return FaceDetectorView(
//       subjectID: widget.subjectID,
//     );
//   }
// }

// class FaceDetectorView extends StatefulWidget {
//   final String subjectID;
//   const FaceDetectorView({super.key, required this.subjectID});

//   @override
//   State<FaceDetectorView> createState() => _FaceDetectorViewState();
// }

// class _FaceDetectorViewState extends State<FaceDetectorView> {
//   FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
//     FaceDetectorOptions(enableContours: true, enableClassification: true),
//   );
//   bool isBusy = false;
//   CustomPaint? customPaint;
//   Uint8List? detectedFaceImage;

//   @override
//   void dispose() {
//     faceDetector.close();
//     super.dispose();
//   }

//   Future<void> processImage(InputImage inputImage) async {
//     if (isBusy) return;
//     isBusy = true;
//     final faces = await faceDetector.processImage(inputImage);
//     if (faces.isNotEmpty) {
//       final boundingBox = faces[0].boundingBox;
//       final faceImage = await _cropFaceImage(inputImage, boundingBox);
//       setState(() {
//         detectedFaceImage = faceImage;
//       });
//       // ignore: avoid_print
//       print("Smile probability: ${faces[0].smilingProbability}");
//     }
//     isBusy = false;
//   }

//   double getImageSizeInKB(Uint8List imageBytes) {
//     return imageBytes.lengthInBytes / 1024; // Converts to KB
//   }

//   Future<Uint8List?> _cropFaceImage(InputImage inputImage, Rect boundingBox) async {
//   try {
//     // Get the image bytes
//     final Uint8List? bytes = inputImage.bytes;
//     if (bytes == null) {
//       print('No image bytes available.');
//       return null;
//     }

//     // Get the temporary directory path
//     final tempDir = await getTemporaryDirectory();

//     // Create a temporary file to store the image
//     File file = await File('${tempDir.path}/image.png').create();

//     // Write the image bytes to the file
//     await file.writeAsBytes(bytes);

//     // Get the file size in KB
//     int fileSizeInBytes = await file.length();
//     double fileSizeInKB = fileSizeInBytes / 1024; // Convert bytes to KB

//     log('File size: $fileSizeInKB KB');

//     // Wait for 5 seconds (5000 milliseconds)
//     await Future.delayed(Duration(seconds: 5));

//     SignUpRepositories().checkface(filePath1: file.path, classID: widget.subjectID, );

//   } catch (e) {
//     print('Error cropping image: $e');
//     return null;
//   }
//   return null;
// }

//   @override
//   Widget build(BuildContext context) {
//     return CameraView(
//       title: "Face Detector",
//       customPaint: customPaint,
//       onImage: (inputImage) {
//         processImage(inputImage);
//       },
//       initialDirection: CameraLensDirection.front,
//       detectedFaceImage: detectedFaceImage,
//     );
//   }
// }

// class CameraView extends StatefulWidget {
//   const CameraView({
//     super.key,
//     required this.title,
//     this.customPaint,
//     required this.onImage,
//     required this.initialDirection,
//     this.detectedFaceImage,
//   });

//   final String title;
//   final CustomPaint? customPaint;
//   final Function(InputImage inputImage) onImage;
//   final CameraLensDirection initialDirection;
//   final Uint8List? detectedFaceImage;

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> {
//   CameraController? _controller;
//   int _cameraIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     for (var i = 0; i < cameras!.length; i++) {
//       if (cameras![i].lensDirection == widget.initialDirection) {
//         _cameraIndex = i;
//       }
//     }
//     _startLiveFeed();
//   }

//   Future _startLiveFeed() async {
//     final camera = cameras![_cameraIndex];
//     _controller =
//         CameraController(camera, ResolutionPreset.high, enableAudio: false);
//     _controller?.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       _controller?.startImageStream(_processCameraImage);
//       setState(() {});
//     });
//   }

//   Future _processCameraImage(CameraImage image) async {
//     final WriteBuffer allBytes = WriteBuffer();
//     for (Plane plane in image.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }

//     final bytes = allBytes.done().buffer.asUint8List();
//     final Size imageSize =
//         Size(image.width.toDouble(), image.height.toDouble());
//     final camera = cameras![_cameraIndex];

//     final imageRotation =
//         InputImageRotationValue.fromRawValue(camera.sensorOrientation) ??
//             InputImageRotation.rotation0deg;

//     final inputImageFormat =
//         InputImageFormatValue.fromRawValue(image.format.raw) ??
//             InputImageFormat.nv21;

//     final planeData = image.planes.map((Plane plane) {
//       return InputImagePlaneMetadata(
//           bytesPerRow: plane.bytesPerRow,
//           height: plane.height,
//           width: plane.width);
//     }).toList();

//     final inputImageData = InputImageData(
//         size: imageSize,
//         imageRotation: imageRotation,
//         inputImageFormat: inputImageFormat,
//         planeData: planeData);

//     final inputImage =
//         InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

//     widget.onImage(inputImage);
//   }

//   Future _stopLiveFeed() async {
//     await _controller?.stopImageStream();
//     await _controller?.dispose();
//     _controller = null;
//   }

//   @override
//   void dispose() {
//     _stopLiveFeed();
//     super.dispose();
//   }

//   Widget _liveFeedBody() {
//     if (_controller?.value.isInitialized == false) {
//       return Container();
//     }

//     return Container(
//       color: Colors.black,
//       height: MediaQuery.of(context).size.width,
//       width: MediaQuery.of(context).size.width - 40,
//       child: Stack(
//         fit: StackFit.passthrough,
//         children: <Widget>[
//           CameraPreview(_controller!),
//           if (widget.customPaint != null) widget.customPaint!,
//           if (widget.detectedFaceImage != null)
//             Positioned(
//               bottom: 0,
//               right: 0,
//               child: Container(
//                 color: Colors.white,
//                 child: Image.memory(widget.detectedFaceImage!),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: GFAppBar(
//         backgroundColor: AppColor.appbarColor,
//         centerTitle: true,
//         title: TextCustom(
//           text: "Quét khuôn mặt",
//           color: Colors.white,
//           fontSize: psHeight(16),
//         ),
//         actions: <Widget>[
//           GFIconButton(
//             icon: Icon(
//               Icons.favorite,
//               color: Colors.white,
//               size: psHeight(16),
//             ),
//             onPressed: () {},
//             type: GFButtonType.transparent,
//           ),
//         ],
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//             child: Text(
//               "Để khuôn mặt ở giữa khung hình",
//               style: GoogleFonts.poppins(
//                   color: Colors.black87,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: DottedBorder(
//               borderType: BorderType.Oval,
//               padding: const EdgeInsets.all(16),
//               strokeWidth: 14,
//               dashPattern: const [2, 3],
//               color: Colors.grey.shade500,
//               child: ClipOval(
//                 child: _liveFeedBody(),
//               ),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: Colors.white,
//     );
//   }
// }
