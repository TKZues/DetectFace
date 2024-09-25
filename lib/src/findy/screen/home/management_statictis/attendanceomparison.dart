
import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class AttendanceComparisonChart extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  AttendanceComparisonChart({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'So sánh điểm chuyên cần giữa sinh viên'),
      series: <ChartSeries>[
        ColumnSeries<AttendanceData, String>(
          dataSource: attendanceData,
          xValueMapper: (AttendanceData data, _) => data.studentName,
          yValueMapper: (AttendanceData data, _) => data.attendanceRate,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
