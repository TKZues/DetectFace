import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../constant/color.dart';
import '../../../../../../../utils/config/size_config.dart';
import '../../../../../../../widget/text/textcustom.dart';

class XuhuongdiemdanhScreen extends StatefulWidget {
  const XuhuongdiemdanhScreen({super.key});

  @override
  State<XuhuongdiemdanhScreen> createState() => _XuhuongdiemdanhScreenState();
}

class _XuhuongdiemdanhScreenState extends State<XuhuongdiemdanhScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: SfCartesianChart(
        title: ChartTitle(text: 'Điểm danh theo ngày'),
        legend: Legend(isVisible: true), 
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(), 
          intervalType: DateTimeIntervalType.days,
          majorGridLines: const MajorGridLines(width: 0),
          interval: 1, // Hiển thị nhãn từng ngày
        ),
        primaryYAxis: NumericAxis(labelFormat: '{value} lần'),
        series: <ChartSeries>[
          LineSeries<AttendanceData, DateTime>(
            name: 'Check-in',
            dataSource: data,
            xValueMapper: (AttendanceData attendance, _) => attendance.date ?? DateTime.now(), 
            yValueMapper: (AttendanceData attendance, _) => attendance.checkIn,
            dataLabelSettings: const DataLabelSettings(isVisible: true), 
          ),
          LineSeries<AttendanceData, DateTime>(
            name: 'Check-out',
            dataSource: data,
            xValueMapper: (AttendanceData attendance, _) => attendance.date ?? DateTime.now(),
            yValueMapper: (AttendanceData attendance, _) => attendance.checkOut,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class AttendanceData {
  final DateTime? date; // Thời gian: ngày tháng
  final int checkIn;
  final int checkOut;

  AttendanceData(this.date, this.checkIn, this.checkOut);
}

// Dữ liệu mẫu cho một sinh viên theo từng ngày
final List<AttendanceData> data = [
  AttendanceData(DateTime(2024, 10, 1), 1, 0),  // 1 check-in, 0 check-out vào ngày 1 tháng 10
  AttendanceData(DateTime(2024, 10, 2), 1, 1),  // 1 check-in, 1 check-out vào ngày 2 tháng 10
  AttendanceData(DateTime(2024, 10, 3), 0, 1),  // Không check-in, 1 check-out vào ngày 3 tháng 10
  AttendanceData(DateTime(2024, 10, 4), 1, 0),
  // Tiếp tục thêm dữ liệu cho các ngày khác
];

