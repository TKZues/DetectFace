
import 'package:findy/constant/color.dart';
import 'package:findy/src/student/repositories/chart_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../utils/config/size_config.dart';
import '../../../../../../../widget/text/textcustom.dart';

class Thoigiancheckintrungbinh extends StatefulWidget {
  const Thoigiancheckintrungbinh({super.key});

  @override
  State<Thoigiancheckintrungbinh> createState() =>
      _ThoigiancheckintrungbinhState();
}

class _ThoigiancheckintrungbinhState extends State<Thoigiancheckintrungbinh> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        final repo = context.read<ChartRepositories>();
        repo.checkweekjubjectwithtime();
     });
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ChartRepositories>(),
      child: ProgressHUD(
        child: Scaffold(
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
          body: ConsumerBase<ChartRepositories>(
            onRepository: (repository) {
              return SfCartesianChart(
                title:
                    ChartTitle(text: 'Thời gian Check-in/Check-out trong tuần'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Thời gian (giờ)'),
                  minimum: 6,
                  maximum: 18,
                  interval: 1,
                ),
                series: <ChartSeries<ThoigiancheckintrungbinhData, String>>[
                  LineSeries<ThoigiancheckintrungbinhData, String>(
                    name: 'Check-in',
                    color: Color(0xFF2FEA9B),
                    dataSource: repository.listcheckweekjubjectwithtime,
                    xValueMapper: (ThoigiancheckintrungbinhData data, _) =>
                        data.day,
                    yValueMapper: (ThoigiancheckintrungbinhData data, _) =>
                        data.checkInTime,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                  LineSeries<ThoigiancheckintrungbinhData, String>(
                    name: 'Check-out',
                     color: Color(0xFFFFBF1A),
                    dataSource: repository.listcheckweekjubjectwithtime,
                    xValueMapper: (ThoigiancheckintrungbinhData data, _) =>
                        data.day,
                    yValueMapper: (ThoigiancheckintrungbinhData data, _) =>
                        data.checkOutTime,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class ThoigiancheckintrungbinhData {
  ThoigiancheckintrungbinhData({this.day, this.checkInTime, this.checkOutTime});
  
  String? day;
  double? checkInTime; 
  double? checkOutTime; 

  factory ThoigiancheckintrungbinhData.fromJson(Map<dynamic, dynamic> json) {
    List<dynamic> subjects = json['subjects'];
  
    double totalCheckIn = 0.0;
    double totalCheckOut = 0.0;
    int count = subjects.length;

    for (var subject in subjects) {
      totalCheckIn += subject['checkin'] ?? 0;
      totalCheckOut += subject['checkout'] ?? 0;
    }

    return ThoigiancheckintrungbinhData(
      day: json['day'],
      checkInTime: count > 0 ? totalCheckIn / count : 0,
      checkOutTime: count > 0 ? totalCheckOut / count : 0,
    );
  }
}

