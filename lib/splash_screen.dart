import 'dart:async';
import 'package:findy/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:ivms/src/ivms/core/api/api_repo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double fireImageSize = 180;
  double imageWidth = 370;
  double imageHeight = 220;
  late SharedPreferences sharedPreferences;
  String route = "/";
  // AiCamApiRepo apiRepo = AiCamApiRepo();
  bool delayNavigator = false;

  @override
  void initState() {
    super.initState();
    initRoute();
    delayNavigator = false;
  }

  void initRoute() async {
    route = "/scan_qr";
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
    });
  }

  late Size size;
  double heightSizeBox1 = 0;
  double heightSizeBox2 = 0;

  void setSize() {
    if (size.height < 700) {
      isSmallDevice = true;
    } else {
      isSmallDevice = false;
    }

    if (size.height >= 1024) {
      isLargeDevice = true;
    } else {
      isLargeDevice = false;
    }

    if (isLargeDevice) {
      heightSizeBox1 = 250;
      heightSizeBox2 = 10;
      fireImageSize = 250;
      imageHeight = 300;
      imageWidth = 504;
    } else if (isSmallDevice) {
      heightSizeBox1 = 120;
      heightSizeBox2 = 10;
      fireImageSize = 100;
      imageWidth = 235;
      imageHeight = 140;
    } else {
      heightSizeBox1 = 180;
      heightSizeBox2 = 20;
      fireImageSize = 180;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    setSize();
    return const Scaffold(
      body: Stack(
        children: [
          Image(
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              image: AssetImage('assets/images/bg1.png')),
        ],
      ),
    );
  }
}
