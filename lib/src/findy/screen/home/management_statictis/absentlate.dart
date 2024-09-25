

import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class AbsentCountChart extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  AbsentCountChart({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Tỷ lệ vắng mặt của sinh viên'),
      series: <CircularSeries>[
        PieSeries<AttendanceData, String>(
          dataSource: attendanceData,
          xValueMapper: (AttendanceData data, _) => data.studentName,
          yValueMapper: (AttendanceData data, _) => data.absentCount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
