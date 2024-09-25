import 'dart:async';
import 'package:findy/constant/color.dart';
import 'package:findy/src/findy/screen/home/attendance_history/attendance_history_screen.dart';
import 'package:findy/src/findy/screen/home/classes_manage_screen.dart';
import 'package:findy/src/findy/screen/home/item_home.dart';
import 'package:findy/src/findy/screen/home/management_class/management_class_screen.dart';
import 'package:findy/src/findy/screen/home/management_statictis/management_statictis_screen.dart';
import 'package:findy/src/findy/screen/home/student_card.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/button/buttoncheckinout.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:primer_progress_bar/primer_progress_bar.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late String _timeString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dmy = DateFormat('EEE, dd MMM').format(DateTime.now());
    SizeConfig();
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        title: TextCustom(
          text: "Trang chủ",
          color: Colors.white,
          fontSize: psHeight(16),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: psHeight(6), horizontal: psWidth(15)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const StudentCard(),
                SizedBox(
                  height: psHeight(20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
                  padding: EdgeInsets.symmetric(
                      vertical: psHeight(14), horizontal: psWidth(10)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(psHeight(10)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(31, 96, 96, 96),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 4))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        text: dmy,
                        fontSize: psHeight(14),
                        fontWeight: FontWeight.w700,
                      ),
                      TextCustom(
                        text: _timeString,
                        fontSize: psHeight(20),
                        fontWeight: FontWeight.bold,
                      ),
                       TextCustom(
                        text: "On time",
                        color: Colors.green,
                        fontSize: psHeight(12),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const PrimerProgressBar(
                          barStyle: SegmentedBarStyle(
                              backgroundColor: Colors.white, gap: 2, size: 10),
                          maxTotalValue: 100,
                          segments: [
                            Segment(
                              value: 50,
                              color: Colors.orange,
                              label: Text(
                                "JAVA",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Segment(
                              value: 50,
                              color: Colors.green,
                              label: Text(
                                "DART",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: psHeight(10),
                      ),
                      TextCustom(
                        text: "WORKING HOURS",
                        fontSize: psHeight(14),
                        fontWeight: FontWeight.w700,
                      ),
                      TextCustom(
                          text:
                              "Starts 9:00AM - 10:00AM & Ends 6:00PM - 7:00 PM",
                          fontSize: psHeight(12),
                          fontWeight: FontWeight.w500),
                      SizedBox(
                        height: psHeight(10),
                      ),
                      Center(
                          child: ButtonCheckInOut(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ClassesManageScreen(),
                                    ));
                              },
                              title: "Classes Today",
                              colorbtn: Colors.green,
                              colortitle: Colors.white))
                    ],
                  ),
                ),
                SizedBox(
                  height: psHeight(20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
                  child: Row(
                    children: [
                      ItemHome(
                          title: "Quản lý điểm danh",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceHistory(),
                                ));
                          },
                          logo: "assets/images/qlynahndien.jpg"),
                      SizedBox(
                        width: psWidth(20),
                      ),
                      ItemHome(
                          title: "Quản lý lớp học",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ManagementClassScreen(),
                                ));
                          },
                          logo: "assets/images/nghiphep.jpg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: psHeight(20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
                  child: Row(
                    children: [
                      ItemHome(
                          title: "Thống kê",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  ManagementStatictisScreen(),));
                          },
                          logo: "assets/images/thongke.jpg"),
                      SizedBox(
                        width: psWidth(20),
                      ),
                      ItemHome(
                          title: "Timesheets",
                          onTap: () {},
                          logo: "assets/images/timesheet.jpg"),
                    ],
                  ),
                ),
                SizedBox(
                  height: psHeight(20),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: psWidth(6)),
                  child: Row(
                    children: [
                      ItemHome(
                          title: "Thông báo cảnh báo vi phạm",
                          onTap: () {},
                          logo: "assets/images/thongbao.jpg"),
                      SizedBox(
                        width: psWidth(20),
                      ),
                      ItemHome(
                          title: "Báo cáo chuyên cần",
                          onTap: () {},
                          logo: "assets/images/chuyencan.jpg"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }
}
