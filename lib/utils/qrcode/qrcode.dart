import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:findy/utils/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openpgp/openpgp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart%20';
import 'package:scan/scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/share_preference_key.dart';
import '../../main.dart';
import '../../scan_state.dart';
import '../config/size_config.dart';
import '../snackbar/snackbar_util.dart';
import 'qrscanneroverlay .dart';

class QRCode extends StatefulWidget {
  const QRCode({
    super.key,
    this.title,
    this.description,
    this.onResult,
  });

  final String? title;
  final String? description;
  final ValueChanged<String?>? onResult;

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> with SingleTickerProviderStateMixin {
  bool isFlash = false;
  late SharedPreferences sharedPreferences;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  qr.Barcode? result;
  qr.QRViewController? qrviewController;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrviewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrviewController!.resumeCamera();
    }
  }

  //Mở thư viện ảnh

  void openImageLibrary() async {
    XFile? res = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (res != null) {
      // ignore: use_build_context_synchronously
      final scanState = Provider.of<ScanState>(context, listen: false);
      scanState.setLoading(true);
      EasyLoading.show(status: "Loading...");
      String? str = await Scan.parse(res.path);
      if (str != null) {
        await scanQR(str, 2);
      } else {
        EasyLoading.dismiss();
        CustomSnackbar.snackbarError("Quét mã QR không thành công");
        scanState.setLoading(false);
      }
    }
  }

  //Check quyền truy cập thư viện

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      openImageLibrary();
    } else if (status.isDenied) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Quyền truy cập bị từ chối."),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Quyền truy cập bị từ chối. Hãy mở cài đặt để cấp quyền"),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    }
  }

  //Giải mã với link đã quét

  Future<void> scanQR(String? result, int index) async {
    final scanState = Provider.of<ScanState>(context, listen: false);

    final String privateKey = await DefaultAssetBundle.of(context)
        .loadString("assets/file/gpg_key.txt");
    var resultdec = await OpenPGP.decrypt(result ?? '', privateKey, "vnptit");
    final base64 = json.decode(utf8.decode(base64Decode(resultdec)));
    if (base64.isNotEmpty) {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(SharePreferenceKeys.appType, base64['app']);
      sharedPreferences.setString(
          SharePreferenceKeys.baseURL, base64['baseURL']);
      String? appType =
          sharedPreferences.getString(SharePreferenceKeys.appType);
      switch (appType) {
        case 'ivms':
          String route = "/scan_face";
          Timer(const Duration(milliseconds: 500), () {
            EasyLoading.dismiss();
            if (isFlash) {
              setState(() {
                isFlash = false;
                qrviewController?.toggleFlash();
              });
            }
            qrviewController?.stopCamera();
            scanState.setLoading(false);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(route, (route) => false);
          });
          break;
        case 'aicam':
          String route = "/scan_face";
          Timer(const Duration(milliseconds: 500), () {
            EasyLoading.dismiss();
            if (isFlash) {
              setState(() {
                isFlash = false;
                qrviewController?.toggleFlash();
              });
            }
            qrviewController?.stopCamera();
            scanState.setLoading(false);
            Navigator.of(context)
                .pushNamedAndRemoveUntil(route, (route) => false);
          });
          break;
        default:
          return;
      }
    } else {
      if (index == 1) {
        EasyLoading.dismiss();
        scanState.setLoading(false);
        AppDialog.showResultDialog(
            context: navigatorKey.currentContext!,
            success: false,
            message: "Mã QR không hợp lệ",
            btnText: "Đóng",
            callbackBtn: () {
              qrviewController?.resumeCamera();
            });
      } else if (index == 2) {
        EasyLoading.dismiss();
        CustomSnackbar.snackbarError("Quét mã QR không thành công");
        scanState.setLoading(false);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(context),
    );
  }

  void _onQRViewCreated(qr.QRViewController qrviewController) {
    this.qrviewController = qrviewController;
    qrviewController.scannedDataStream.listen((scanData) {
      EasyLoading.show(status: "Loading...");
      setState(() {
        if (isFlash) {
          isFlash = false;
          qrviewController.toggleFlash();
        }
        result = scanData;
        qrviewController.pauseCamera();

        scanQR(scanData.code, 1);
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    final scanState = Provider.of<ScanState>(context);
    return Stack(
      children: [
        // QRview
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
        ),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        Positioned(
          top: psHeight(40),
          left: psWidth(100),
          right: psWidth(100),
          // ignore: sized_box_for_whitespace
          child: Container(
            height: psHeight(50),
            // color: Colors.white,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Quét mã QR",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: psWidth(16),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Positioned(
          top: psHeight(40),
          left: psWidth(10),
          // ignore: sized_box_for_whitespace
          child: Container(
            width: psWidth(50),
            height: psHeight(50),
            // color: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          top: psHeight(40),
          right: psWidth(10),
          child: Container(
            padding: EdgeInsets.all(psHeight(10)),
            width: psWidth(50),
            height: psHeight(50),
            // color: Colors.white,
            child: InkWell(
              child: Container(
                width: psWidth(24),
                height: psHeight(24),
                padding: EdgeInsets.all(psHeight(5)),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.8)),
                child: isFlash
                    ? SvgPicture.asset("assets/icon/flash_on.svg")
                    : SvgPicture.asset("assets/icon/flash_off.svg"),
              ),
              onTap: () {
                setState(() {
                  isFlash = !isFlash;
                  qrviewController?.toggleFlash();
                });
              },
            ),
          ),
        ),
        Positioned(
          top: psHeight(140),
          left: psWidth(20),
          right: psWidth(20),
          child: Container(
            padding: EdgeInsets.all(psWidth(10)),
            child: Text(
              "Đưa mã QR vào trung tâm camera\n tiến trình quét mã sẽ diễn ra tự động",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: psWidth(14),
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: psHeight(80),
          left: psWidth(135),
          right: psWidth(135),
          child: InkWell(
            onTap: () {
              if (isFlash) {
                setState(() {
                  isFlash = false;
                  qrviewController?.toggleFlash();
                });
              }
              checkPermission(Permission.storage, context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: psWidth(2), vertical: psHeight(3)),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(psHeight(20)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icon/add_photo.svg"),
                  SizedBox(width: psWidth(3)),
                  Text(
                    "Thư viện ảnh",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: psWidth(10),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Khi loading thì chặn thao tác
        if (scanState.isLoading)
          Positioned.fill(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                color: const Color(0x00000000),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    qrviewController?.dispose();
    super.dispose();
  }
}
