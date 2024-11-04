import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:findy/src/student/repositories/detectfacelive_repositories.dart';
import 'package:findy/utils/provider/index.dart';
// import 'package:findy/src/findy/repositories/detectface_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UnifiedCapturePage extends StatefulWidget {
  final String subjectID;
  final String beginTime;
  final String endTime;
  const UnifiedCapturePage(
      {super.key,
      required this.subjectID,
      required this.beginTime,
      required this.endTime});

  @override
  State<UnifiedCapturePage> createState() => _UnifiedCapturePageState();
}

class _UnifiedCapturePageState extends State<UnifiedCapturePage> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  List<File> imagesList = [];
  bool isFlashOn = false;
  bool isRearCamera = true;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    setState(() {
      cameraController = CameraController(
        cameras[1],
        ResolutionPreset.high,
        enableAudio: false,
      );
      cameraValue = cameraController.initialize(); // Khởi tạo cameraValue ở đây
    });
  }

  Future<File> saveImage(XFile image) async {
    // Read the image as bytes
    Uint8List imageBytes = await image.readAsBytes();

    // Decode the image into an img.Image object
    img.Image? decodedImage = img.decodeImage(imageBytes);

    // Compress the image by encoding it with reduced quality
    Uint8List compressedImageBytes = Uint8List(0);
    if (decodedImage != null) {
      compressedImageBytes = Uint8List.fromList(
          img.encodeJpg(decodedImage, quality: 10)); // Reduce quality to 10%
    }

    // Save the compressed image to a temporary file
    final tempDir = await getTemporaryDirectory();
    final compressedImageFile = File('${tempDir.path}/compressed_image.jpg');

    try {
      await compressedImageFile.writeAsBytes(compressedImageBytes);
    } catch (e) {
      print("Error saving compressed image: $e");
    }

    return compressedImageFile;
  }

  Future<void> takePicture(DetectFaceLiveRepositories repository) async {
    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }

    if (!isFlashOn) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }

    XFile image = await cameraController.takePicture();

    if (cameraController.value.flashMode == FlashMode.torch) {
      setState(() {
        cameraController.setFlashMode(FlashMode.off);
      });
    }

    final file = await saveImage(image);
    await repository.checkface(
      context: context,
        filePath1: file.path,
        classID: widget.subjectID,
        beginTime: widget.beginTime,
        endTime: widget.endTime);
    // Send the image for face check
    // await SignUpRepositories().checkface(
    //     filePath1: file.path,
    //     classID: widget.subjectID,
    //     beginTime: widget.beginTime,
    //     endTime: widget.endTime);
    
    setState(() {
      imagesList.add(file);
    });
  }

  void startCamera(CameraDescription camera) {
    cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: context.read<DetectFaceLiveRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(255, 255, 255, .7),
            shape: const CircleBorder(),
            onPressed: () async {
              final repository = Provider.of<DetectFaceLiveRepositories>(
                  context,
                  listen: false);
              await takePicture(repository);
            },
            child: const Icon(
              Icons.camera_alt,
              size: 40,
              color: Colors.black87,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: ConsumerBase<DetectFaceLiveRepositories>(
            onRepository: (repository) {
              return Stack(
                children: [
                  FutureBuilder(
                    future: cameraValue,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: 100,
                              child: CameraPreview(cameraController),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, top: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFlashOn = !isFlashOn;
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: isFlashOn
                                      ? const Icon(
                                          Icons.flash_on,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.flash_off,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isRearCamera = !isRearCamera;
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(50, 0, 0, 0),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: isRearCamera
                                      ? const Icon(
                                          Icons.camera_rear,
                                          color: Colors.white,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.camera_front,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7, bottom: 75),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: imagesList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        height: 100,
                                        width: 100,
                                        opacity:
                                            const AlwaysStoppedAnimation(07),
                                        image: FileImage(
                                          File(imagesList[index].path),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
