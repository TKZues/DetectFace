import 'dart:async';
import 'package:findy/constant/color.dart';
import 'package:findy/src/teacher/screen/home/attendance_history/attendance_history_screen.dart';
import 'package:findy/src/teacher/screen/home/management_notification/notificationsocket_screen.dart';
import 'package:findy/src/teacher/screen/home/management_subject/classes_manage_screen.dart';
import 'package:findy/src/teacher/screen/home/item_home.dart';
import 'package:findy/src/teacher/screen/home/management_class/management_class_screen.dart';
import 'package:findy/src/teacher/screen/home/management_statictis/management_statictis_screen.dart';
import 'package:findy/src/teacher/screen/home/student_card.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

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
    SizeConfig();
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        title: TextCustom(
          text: "Trang chủ",
          color: AppColor.textDefault,
          fontSize: psHeight(16),
        ),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.favorite,
              color: AppColor.textDefault,
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
                SizedBox(
                  height: psHeight(20),
                ),
                Row(
                  children: [weather()],
                ),
                SizedBox(
                  height: psHeight(10),
                ),
                banner(),
                SizedBox(
                  height: psHeight(20),
                ),
                const StudentCard(),
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
                                  builder: (context) =>
                                      const ManagementClassScreen(),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ManagementStatictisScreen(),
                                ));
                          },
                          logo: "assets/images/thongke.jpg"),
                      SizedBox(
                        width: psWidth(20),
                      ),
                      ItemHome(
                          title: "Timesheets",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ClassesManageScreen(),
                                ));
                          },
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationSocketScreen(),
                                ));
                          },
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

  Widget weather() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(10), vertical: psHeight(2)),
      decoration: BoxDecoration(
          color: AppColor.chuvang,
          borderRadius: BorderRadius.circular(psHeight(30))),
      child: Row(
        children: [
          Image.asset(
            'assets/images/sunny-weather.webp',
            width: 80,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    color: AppColor.color928E85,
                    size: 20,
                  ),
                  TextCustom(
                    text: "Hanoi",
                    color: AppColor.chuxanh,
                  )
                ],
              ),
              TextCustom(
                text: "+25, cloudy",
                fontWeight: FontWeight.bold,
                color: AppColor.chuxanh,
              )
            ],
          ),
          SizedBox(
            width: psWidth(10),
          ),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColor.chuxanh,
          )
        ],
      ),
    );
  }

  Widget banner() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(15), vertical: psHeight(6)),
      decoration: BoxDecoration(
          color: Color(0xFF3d3d3d),
          borderRadius: BorderRadius.circular(psHeight(15))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextCustom(
                text: "Good Monday Morning",
                color: AppColor.chuvang,
              ),
              FaIcon(
                FontAwesomeIcons.bell,
                color: AppColor.greyMain,
                size: psHeight(14),
              )
            ],
          ),
          SizedBox(
            height: psHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: "Every Monday",
                    color: AppColor.textGrey,
                    fontSize: psHeight(11),
                  ),
                  TextCustom(
                    text: _timeString,
                    fontSize: psHeight(20),
                    fontWeight: FontWeight.bold,
                    color: AppColor.white,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: psWidth(4), vertical: psHeight(4)),
                decoration: BoxDecoration(
                  color: Color(0xff2C2C2B),
                  borderRadius: BorderRadius.circular(psHeight(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(psHeight(10)),
                      decoration: BoxDecoration(
                          color: Color(0xFF3d3d3d), shape: BoxShape.circle),
                      child: FaIcon(
                        FontAwesomeIcons.powerOff,
                        size: psHeight(14),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: psWidth(8),
                    ),
                    TextCustom(
                      text: "Start scene",
                      color: AppColor.textGrey,
                    ),
                    SizedBox(
                      width: psWidth(8),
                    ),
                    FaIcon(
                      FontAwesomeIcons.angleDoubleRight,
                      color: AppColor.textGrey,
                      size: psHeight(14),
                    )
                  ],
                ),
              )
            ],
          )
        ],
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
