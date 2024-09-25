import 'package:findy/src/findy/screen/home/management_statictis/absentlate.dart';
import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:findy/src/findy/screen/home/management_statictis/attendanceomparison.dart';
import 'package:findy/src/findy/screen/home/management_statictis/attendancerate.dart';
import 'package:findy/src/findy/screen/home/management_statictis/attendancetrend.dart';
import 'package:findy/src/findy/screen/home/management_statictis/latecount.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../constant/color.dart';
import '../../../../../utils/config/size_config.dart';

class ManagementStatictisScreen extends StatelessWidget {
  ManagementStatictisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AttendanceData> attendanceData = [
      AttendanceData(
        studentName: 'Nguyen Van A',
        attendanceRate: 95,
        lateCount: 1,
        absentCount: 0,
        date: DateTime(2024, 9, 1),
      ),
      AttendanceData(
        studentName: 'Tran Thi B',
        attendanceRate: 88,
        lateCount: 2,
        absentCount: 1,
        date: DateTime(2024, 9, 2),
      ),
      AttendanceData(
        studentName: 'Le Van C',
        attendanceRate: 92,
        lateCount: 3,
        absentCount: 2,
        date: DateTime(2024, 9, 3),
      ),
      AttendanceData(
        studentName: 'Pham Thi D',
        attendanceRate: 100,
        lateCount: 0,
        absentCount: 0,
        date: DateTime(2024, 9, 4),
      ),
      AttendanceData(
        studentName: 'Vo Van E',
        attendanceRate: 80,
        lateCount: 4,
        absentCount: 3,
        date: DateTime(2024, 9, 5),
      ),
      AttendanceData(
        studentName: 'Tran Thi F',
        attendanceRate: 75,
        lateCount: 5,
        absentCount: 4,
        date: DateTime(2024, 9, 6),
      ),
    ];

    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.appbarColor,
        centerTitle: true,
        leading: GFIconButton(
          icon: Container(
            padding: EdgeInsets.symmetric(
                horizontal: psWidth(3), vertical: psHeight(4)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(psHeight(4)),
              color: AppColor.backgbackColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.backiconColor,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        title: TextCustom(
          text: "Thống kê",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300, // Set a fixed height for each chart
              child: AttendanceRateChart(attendanceData: attendanceData),
            ),
            SizedBox(
              height: 300, // Set a fixed height for each chart
              child: LateCountChart(attendanceData: attendanceData),
            ),
            SizedBox(
              height: 300, // Set a fixed height for each chart
              child: AbsentCountChart(attendanceData: attendanceData),
            ),
            SizedBox(
              height: 300, // Set a fixed height for each chart
              child: AttendanceTrendChart(attendanceData: attendanceData),
            ),
            SizedBox(
              height: 300, // Set a fixed height for each chart
              child: AttendanceComparisonChart(attendanceData: attendanceData),
            ),
          ],
        ),
      ),
    );
  }
}
