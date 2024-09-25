import 'package:findy/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AppDialog {
  static void showResultDialog({
    required BuildContext context,
    required bool success,
    required String message,
    required String btnText,
    required Function callbackBtn,
    bool? barrierDismissible,
    String? btnCancelText,
    Function? callbackCancelBtn,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (_) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            success
                                ? "assets/icon/success_icon.png"
                                : "assets/icon/failed_icon.png",
                            scale: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.topTitle),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          btnCancelText != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    side: const BorderSide(
                                                        color: AppColor
                                                            .newState)))),
                                        child: Text(
                                          btnCancelText,
                                          style: GoogleFonts.roboto(
                                              color: AppColor.newState,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          callbackCancelBtn!();
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    side: const BorderSide(
                                                        color: AppColor
                                                            .blueMain)))),
                                        child: Text(
                                          btnText,
                                          style: GoogleFonts.roboto(
                                              color: AppColor.blueMain,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          callbackBtn();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: const BorderSide(
                                                  color: AppColor.blueMain)))),
                                  child: Text(
                                    btnText,
                                    style: GoogleFonts.roboto(
                                        color: AppColor.blueMain,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    callbackBtn();
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  static Future<void> showDateTimePicker(
      {required BuildContext context,
      required TextEditingController controller}) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: controller.text.isNotEmpty
            ? DateFormat('dd/MM/yyyy HH:mm').parse(controller.text)
            : DateTime.now(),
        firstDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendar,
        confirmText: "Chọn",
        cancelText: "Trở lại",
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (pickedDate != null) {
      controller.text = DateFormat("dd/MM/yyyy HH:mm").format(pickedDate);
      String timeStr = controller.text.split(" ")[1];
      TimeOfDay timeOfDay = TimeOfDay(
          hour: int.parse(timeStr.split(":")[0]),
          minute: int.parse(timeStr.split(":")[1]));
      final TimeOfDay? pickedTime =
          // ignore: use_build_context_synchronously
          await showTimePicker(context: context, initialTime: timeOfDay);
      final String pickedDateFormat =
          DateFormat('dd/MM/yyyy').format(pickedDate);
      if (pickedTime != null) {
        // ignore: use_build_context_synchronously
        controller.text = "$pickedDateFormat ${pickedTime.format(context)}";
      }
    }
  }

  static void showTimePickerDialog(
      {required BuildContext context,
      required TextEditingController controller}) async {
    DateTime currentValue = controller.text.isNotEmpty
        ? DateFormat('HH:mm').parse(controller.text)
        : DateTime.now();
    TimeOfDay timeOfDay =
        TimeOfDay(hour: currentValue.hour, minute: currentValue.minute);
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: timeOfDay);
    if (pickedTime != null) {
      // ignore: unnecessary_string_interpolations, use_build_context_synchronously
      controller.text = "${pickedTime.format(context)}";
    }
  }

  static void showApproveAllBottomSheet(
      {required BuildContext context,
      required String title,
      required Function callbackBtn}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36.0), topRight: Radius.circular(36)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColor.topTitle),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blueButtonLogin,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: AppColor.blueButtonLogin,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 320,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Đồng ý",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      callbackBtn();
                    },
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: AppColor.blueButtonLogin,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 320,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.close,
                            color: AppColor.blueButtonLogin,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Hủy",
                            style: GoogleFonts.roboto(
                                color: AppColor.blueButtonLogin,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  static void showConfirmDialog(
      {required BuildContext context,
      required String msg1,
      required String msg2,
      required String action,
      required Color actionColor,
      required String content,
      required Function confirmCallback}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width / 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/question_icon.png",
                            scale: 1.5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: RichText(
                              // ignore: deprecated_member_use
                              textScaleFactor:
                                  // ignore: deprecated_member_use
                                  MediaQuery.of(context).textScaleFactor,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "$msg1 ",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.topTitle),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "$action ",
                                      style: GoogleFonts.roboto(
                                          color: actionColor,
                                          fontWeight: FontWeight.w800)),
                                  TextSpan(
                                      text: "$msg2 ",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.topTitle,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: "$content ",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.topTitle,
                                          fontWeight: FontWeight.w800)),
                                  TextSpan(
                                      text: "?",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.topTitle,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: const BorderSide(
                                                  color: AppColor.blueMain)))),
                                  child: Text(
                                    "Không",
                                    style: GoogleFonts.roboto(
                                        color: AppColor.blueMain,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColor.blueMain),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: const BorderSide(
                                                  color: AppColor.blueMain)))),
                                  child: Text(
                                    "Đồng ý",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    confirmCallback();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  static void showNotificationDialog(
      {required BuildContext context,
      required String msg1,
      required String msg2,
      required String notifyContent,
      required Color actionColor,
      required String content,
      required Function confirmCallback,
      required String action}) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width / 5,
                  // height: MediaQuery.of(context).size.height / 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/icon_notify.png",
                            scale: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: RichText(
                              // ignore: deprecated_member_use
                              textScaleFactor:
                                  // ignore: deprecated_member_use
                                  MediaQuery.of(context).textScaleFactor,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "$msg1 ",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.topTitle),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "$notifyContent ",
                                      style: GoogleFonts.roboto(
                                          color: actionColor,
                                          fontWeight: FontWeight.w800)),
                                  TextSpan(
                                      text: "$msg2 ",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.topTitle,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: "$content ?",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.topTitle,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: const BorderSide(
                                                  color: AppColor.blueMain)))),
                                  child: Text(
                                    "Hủy",
                                    style: GoogleFonts.roboto(
                                        color: AppColor.blueMain,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              AppColor.blueMain),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: const BorderSide(
                                                  color: AppColor.blueMain)))),
                                  child: Text(
                                    action,
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    confirmCallback();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  static void showSessionNotificationDialog(
      {required BuildContext context,
      required String message,
      required String btnText,
      required Function callbackBtn}) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width / 5,
                  // height: MediaQuery.of(context).size.height / 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icon/failed_icon.png",
                            scale: 3,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.topTitle),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: const BorderSide(
                                            color: AppColor.blueMain)))),
                            child: Text(
                              btnText,
                              style: GoogleFonts.roboto(
                                  color: AppColor.blueMain,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              callbackBtn();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
