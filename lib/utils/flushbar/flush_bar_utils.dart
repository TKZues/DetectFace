
import 'package:another_flushbar/flushbar.dart';
import 'package:findy/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFlushBar {
  static void showError(BuildContext context, String error, {bool endOffSet = false, int duration = 8}) {
    Flushbar(
      margin: endOffSet ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      endOffset: endOffSet ? const Offset(0, -0.15) : const Offset(0, -0.05),
      messageText: Text(
        error,
        style: GoogleFonts. openSans(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.colorSnackBarTextError),
      ),
      icon: Image.asset(
        "assets/icon/icon_error.png",
        scale: 3,
      ),
      shouldIconPulse: false,
      duration: Duration(seconds: duration),
      backgroundColor: AppColor.colorSnackBarError,
      leftBarIndicatorColor: AppColor.colorSnackBarError,
      routeColor: AppColor.colorSnackBarError,
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  static void showSuccessMessage(BuildContext context, String message, {bool endOffSet = false}) {
    Flushbar(
      margin: endOffSet ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      endOffset: endOffSet ? const Offset(0, -0.15) : const Offset(0, -0.05),
      messageText: Text(
        message,
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.colorSnackBarTextSuccess),
      ),
      icon: Image.asset(
        "assets/icon/icon_success.png",
        scale: 3,
      ),
      shouldIconPulse: false,
      duration: const Duration(seconds: 4),
      backgroundColor: AppColor.colorSnackBarSuccess,
      leftBarIndicatorColor: AppColor.colorSnackBarSuccess,
      routeColor: AppColor.colorSnackBarSuccess,
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  static void showWarningMessage(BuildContext context, String message, {bool endOffSet = false, int duration = 6}) {
    Flushbar(
      margin: endOffSet ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      endOffset: endOffSet ? const Offset(0, -0.15) : const Offset(0, -0.05),
      shouldIconPulse: false,
      messageText: Text(
        message,
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColor.colorSnackBarTextWarning),
      ),
      icon: Image.asset(
        "assets/icon/icon_warning.png",
        scale: 3,
      ),
      duration: Duration(seconds: duration),
      backgroundColor: AppColor.colorSnackBarWarning,
      leftBarIndicatorColor: AppColor.colorSnackBarWarning,
      routeColor: AppColor.colorSnackBarWarning,
      borderRadius: BorderRadius.circular(8),

    ).show(context);
  }

  static void showDefaultMessage(BuildContext context, String message, {bool endOffSet = false}) {
    Flushbar(
      margin: endOffSet ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      flushbarPosition: FlushbarPosition.BOTTOM,
      endOffset: endOffSet ? const Offset(0, -0.15) : const Offset(0, -0.05),
      icon: const Icon(Icons.info, color: Colors.white,),
      shouldIconPulse: false,
      messageText: Text(
        message,
        style: GoogleFonts.openSans(
            fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: AppColor.blueLinear1,
      leftBarIndicatorColor: AppColor.blueLinear1,
      routeColor: AppColor.blueLinear1,
      borderRadius: BorderRadius.circular(8),

    ).show(context);
  }
}
