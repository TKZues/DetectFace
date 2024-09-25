

import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class AttendanceTrendChart extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  AttendanceTrendChart({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      title: ChartTitle(text: 'Xu hướng tham gia của sinh viên'),
      series: <ChartSeries>[
        LineSeries<AttendanceData, DateTime>(
          dataSource: attendanceData,
          xValueMapper: (AttendanceData data, _) => data.date,
          yValueMapper: (AttendanceData data, _) => data.attendanceRate,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
