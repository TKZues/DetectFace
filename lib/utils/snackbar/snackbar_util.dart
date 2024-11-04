import 'package:findy/main.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static snackbarError(String message) {
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: psHeight(80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(psHeight(15)),
            border: Border.all(color: Colors.red.withAlpha(90), width: 2),
            color: Colors.red.withAlpha(90)),
        padding: EdgeInsets.symmetric(horizontal: psHeight(10)),
        child: Row(
          children: [
            Container(
              width: psHeight(40),
              height: psHeight(40),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    psHeight(20),
                  )),
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: psWidth(16),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Something went wrong",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: psHeight(14)),
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: psHeight(12)),
                )
              ],
            ))
          ],
        ),
      ),
      elevation: 0,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: psHeight(670), right: psWidth(20), left: psWidth(20)),
      padding: EdgeInsets.symmetric(horizontal: psHeight(0)),
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(psHeight(15)),
      ),
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static snackbarSuccess(String message) {
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: psHeight(70),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(psHeight(15)),
            border: Border.all(color: Colors.green.withAlpha(90), width: 2),
            color: Colors.green.withAlpha(90)),
        padding: EdgeInsets.symmetric(horizontal: psHeight(10)),
        child: Row(
          children: [
            Container(
              width: psHeight(40),
              height: psHeight(40),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(
                    psHeight(20),
                  )),
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: psWidth(16),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Congratulation",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: psHeight(14)),
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: psHeight(12)),
                )
              ],
            ))
          ],
        ),
      ),
      elevation: 0,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: psHeight(670), right: psWidth(20), left: psWidth(20)),
      padding: EdgeInsets.symmetric(horizontal: psHeight(0)),
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(psHeight(15)),
      ),
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static snackbarWarning(String message) {
    SnackBar snackBar = SnackBar(
      content: Container(
        width: double.infinity,
        height: psHeight(60),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(psHeight(15)),
            border: Border.all(color: Colors.orange.withAlpha(90), width: 2),
            color: Colors.orange.withAlpha(90)),
        padding: EdgeInsets.symmetric(horizontal: psHeight(10)),
        child: Row(
          children: [
            Container(
              width: psHeight(40),
              height: psHeight(40),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(
                    psHeight(20),
                  )),
              child: const Icon(
                Icons.error,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: psWidth(16),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Warning",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: psHeight(14)),
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: psHeight(12)),
                )
              ],
            ))
          ],
        ),
      ),
      elevation: 0,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: psHeight(670), right: psWidth(20), left: psWidth(20)),
      padding: EdgeInsets.symmetric(horizontal: psHeight(0)),
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(psHeight(15)),
      ),
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void snackbarmotion(String message, VoidCallback? onTapNavigate) {
    Get.snackbar(
      '',
      '',
      margin: const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 24),
      snackPosition: SnackPosition.TOP,
      titleText: Container(
        margin: const EdgeInsets.only(top: 6, right: 6, left: 6, bottom: 6),
        child: Text(
          'Thông báo',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: psWidth(16),
            color: Colors.green,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8),
      messageText: Container(
        margin: const EdgeInsets.only(top: 6, right: 12, left: 6, bottom: 6),
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: psWidth(14),
            color: Colors.green,
          ),
        ),
      ),
      icon: Image.asset(
        "assets/icon/success_icon.png",
        height: 32,
        width: 32,
      ),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xFFEFF7FF).withOpacity(0.9),
    
      borderRadius: 15,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child:  Icon(Icons.close,size: psHeight(15), color: Colors.green,),
      ),
      onTap: (snack) {
        // Navigate to a new screen
        if (onTapNavigate != null) {
          onTapNavigate();
        }
        // Optionally dismiss the snackbar after navigation
        Get.back();
      },
    );
  }

  
}
