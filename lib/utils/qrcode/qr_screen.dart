import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/utils/qrcode/qrcode.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({super.key});

  @override
  State<ScanQrCodeScreen> createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  late SharedPreferences sharedPreferences;
  String privateKey = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Image(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              image: AssetImage('assets/images/bg1.png')),
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColor.aicamLoginBackgroud,
              AppColor.aicamLoginBackgroud.withOpacity(0.8),
              AppColor.aicamLoginBackgroud.withOpacity(0.5),
              AppColor.aicamLoginBackgroud.withOpacity(0.5),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: psHeight(80),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    "QUÉT MÃ QR\nLẤY THÔNG TIN ĐĂNG NHẬP",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: psWidth(14),
                        color: AppColor.aicamLoginTitle,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: psHeight(60),
                  ),
                  Image.asset(
                    "assets/icon/scan_qrcode.png",
                    width: psHeight(300),
                    height: psHeight(300),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: psWidth(30)),
                      InkWell(
                        onTap: () {
                          checkPermission(Permission.camera, context, true);
                        },
                        child: Container(
                          width: psWidth(150),
                          height: psHeight(40),
                          padding: EdgeInsets.symmetric(
                              horizontal: psWidth(2), vertical: psHeight(6)),
                          decoration: BoxDecoration(
                            color: const Color(0xFF001f3f).withOpacity(0.4),
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
                              SvgPicture.asset("assets/icon/qr.svg"),
                              SizedBox(width: psWidth(5)),
                              Text(
                                "Quét mã QR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: psWidth(10),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: psHeight(70),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context, bool check) async {
    final status = await permission.request();
    if (status.isGranted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const QRCode(
        ),
      ));
    } else if (status.isDenied) {
      // ignore: use_build_context_synchronously
      showPermissionDialog(context);
    } else if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      showPermissionDialog(context);
    }
  }

  void showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quyền truy cập bị từ chối"),
          content: const Text(
              "Bạn cần cấp quyền truy cập camera trong cài đặt để sử dụng tính năng này."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text("Cài đặt"),
            ),
          ],
        );
      },
    );
  }
  // Future scanQRCode() async {
  //   final status = await Permission.camera.request();
  //   switch (status) {
  //     case PermissionStatus.granted:
  //       Navigator.of(context, rootNavigator: true).push(
  //         CupertinoPageRoute(
  //           builder: (_) => QRCode(
  //             onResult: (result) async {
  //               try {
  //                 final String privateKey = await DefaultAssetBundle.of(context)
  //                     .loadString("assets/file/gpg_key.txt");
  //                 var resultdec =
  //                     await OpenPGP.decrypt(result ?? '', privateKey, "vnptit");
  //                 final base64 =
  //                     json.decode(utf8.decode(base64Decode(resultdec)));
  //                 if (base64.isNotEmpty) {
  //                   sharedPreferences = await SharedPreferences.getInstance();
  //                   sharedPreferences.setString(
  //                       SharePreferenceKeys.appType, base64['app']);
  //                   sharedPreferences.setString(
  //                       SharePreferenceKeys.baseURL, base64['baseURL']);
  //                   String? appType = sharedPreferences
  //                       .getString(SharePreferenceKeys.appType);
  //                   switch (appType) {
  //                     case 'ivms':
  //                       String route = "/ivms_login";
  //                       Timer(const Duration(milliseconds: 500), () {
  //                         Navigator.of(context)
  //                             .pushNamedAndRemoveUntil(route, (route) => false);
  //                       });
  //                       break;
  //                     case 'aicam':
  //                       String route = "/aicam_login";
  //                       Timer(const Duration(milliseconds: 500), () {
  //                         Navigator.of(context)
  //                             .pushNamedAndRemoveUntil(route, (route) => false);
  //                       });
  //                       break;
  //                     default:
  //                       return;
  //                   }
  //                 } else {
  //                   AppDialog.showResultDialog(
  //                       context: navigatorKey.currentContext!,
  //                       success: false,
  //                       message: "Mã QR không hợp lệ",
  //                       btnText: "Đóng",
  //                       callbackBtn: () {});
  //                 }
  //               } catch (e) {
  //                 AppDialog.showResultDialog(
  //                     context: navigatorKey.currentContext!,
  //                     success: false,
  //                     message: "Mã QR không hợp lệ",
  //                     btnText: "Đóng",
  //                     callbackBtn: () {});
  //               }
  //             },
  //           ),
  //         ),
  //       );
  //       break;
  //     case PermissionStatus.denied:
  //       AppDialog.showResultDialog(
  //           context: navigatorKey.currentContext!,
  //           success: false,
  //           message: "Chưa cấp quyền truy cập camera",
  //           btnText: "Đóng",
  //           callbackBtn: () {});
  //       break;
  //     case PermissionStatus.permanentlyDenied:
  //       AppDialog.showResultDialog(
  //           context: navigatorKey.currentContext!,
  //           success: false,
  //           message: "Chưa cấp quyền truy cập camera",
  //           btnText: "Đóng",
  //           callbackBtn: () {});
  //       break;
  //     default:
  //   }
  // }
}
