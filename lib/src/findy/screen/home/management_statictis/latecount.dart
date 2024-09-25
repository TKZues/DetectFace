import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LateCountChart extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  LateCountChart({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(text: 'Số lần đi muộn'),
      series: <ChartSeries>[
        BarSeries<AttendanceData, String>(
          dataSource: attendanceData,
          xValueMapper: (AttendanceData data, _) => data.studentName,
          yValueMapper: (AttendanceData data, _) => data.lateCount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
