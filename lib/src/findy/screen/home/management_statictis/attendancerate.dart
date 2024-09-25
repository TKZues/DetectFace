
import 'package:findy/src/findy/model/statistic_model.dart';
import 'package:findy/src/findy/screen/home/management_statictis/attendanceData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AttendanceRateChart extends StatelessWidget {
  final List<AttendanceData> attendanceData;

  AttendanceRateChart({required this.attendanceData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
              title: ChartTitle(text: 'Điểm trung bình'),
              primaryXAxis: CategoryAxis(
                isVisible: true,
              ),
              primaryYAxis: NumericAxis(
                  // labelFormat: '{value}M',
                  title: AxisTitle(text: 'Điểm trung bình'),
                  //đường line của bar
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0)),
              series: <ChartSeries<ChartSampleData, String>>[
                ColumnSeries<ChartSampleData, String>(
                  onCreateRenderer:
                      (ChartSeries<ChartSampleData, String> series) =>
                          CustomColumnSeriesRenderer(),
                  dataLabelSettings: const DataLabelSettings(
                      //có hiện chữ không
                      isVisible: true,
                      //chữ trong cái cột giữa, trên, dưới
                      labelAlignment: ChartDataLabelAlignment.middle),
                  dataSource: <ChartSampleData>[
                    ChartSampleData(x: 'TTTBDD', y: 8),
                    ChartSampleData(x: 'Thực hành', y: 9),
                    ChartSampleData(x: 'Testing', y: 7.8),
                    ChartSampleData(x: 'C#', y: 8.5),
                    ChartSampleData(x: 'Web', y: 9.2),
                  ],
                  width: 0.8,
                  xValueMapper: (ChartSampleData sales, _) => sales.x as String,
                  yValueMapper: (ChartSampleData sales, _) => sales.y,
                )
              ],
            );
  }
}
