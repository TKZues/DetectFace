import 'package:findy/src/student/screen/home/attendance_history/attendance_history_screen.dart';
import 'package:findy/src/student/screen/home/item_home.dart';
import 'package:findy/src/student/screen/home/management_class/management_class_screen.dart';
import 'package:findy/src/student/screen/home/management_notification/notificationsocket_screen.dart';
import 'package:findy/src/student/screen/home/management_report/management_report.dart';
import 'package:findy/src/student/screen/home/management_statictis/management_statictis_screen.dart';
import 'package:findy/src/student/screen/home/management_subject/classes_manage_screen.dart';
import 'package:findy/src/student/screen/home/management_tkb/management_tkb.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

import 'clock.dart';
import 'time_in_hour_and_minute.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: psHeight(10),),
            Text(
              "Thành phố Hồ Chí Minh, VN | PST",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const TimeInHourAndMinute(),
            const Clock(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
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
                              title: "Môn học hôm nay",
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
                              onTap: () {
                                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => 
                                       MyTablePage(),
                                ));
                              },
                              logo: "assets/images/chuyencan.jpg"),
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
                              title: "Thời khóa biểu",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ManagementTKB(),
                                    ));
                              },
                              logo: "assets/images/tabletime.png"),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
