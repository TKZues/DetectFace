import 'package:findy/constant/color.dart';
import 'package:findy/src/teacher/repositories/chart_repositories.dart';
import 'package:findy/utils/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../utils/config/size_config.dart';
import '../../../../../../../../widget/text/textcustom.dart';

class BarCharts extends StatefulWidget {
  const BarCharts({super.key});

  @override
  State<BarCharts> createState() => _BarChartsState();
}

class _BarChartsState extends State<BarCharts> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final repo = context.read<ChartRepositories1>();
      repo.checkinsumary(DateFormat("yyyy-MM-dd").format(DateTime.now()));
      repo.checkinweek();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<ChartRepositories1>(),
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
          body: ConsumerBase<ChartRepositories1>(
            onRepository: (repository) {
              final List<ChartColumnData> chartData = <ChartColumnData>[
                ChartColumnData("Mo", repository.totalSubjects,
                    repository.checkedInCount),
              ];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  TextCustom(
                                    text: 'Biểu đồ số lần điểm danh theo ngày',
                                    fontSize: psHeight(16),
                                    fontWeight: FontWeight.bold,
                                  )
                                ],
                              )),
                        ],
                      ),
                      SfCartesianChart(
                        margin: const EdgeInsets.all(10),
                        borderWidth: 0,
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(isVisible: true),
                        primaryYAxis: CategoryAxis(
                            isVisible: true,
                            minimum: 0,
                            maximum: 5,
                            interval: 1),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartColumnData, String>(
                              dataSource: chartData,
                              width: 0.8,
                              color: Color(0xFF2FEA9B),
                              xValueMapper: (ChartColumnData data, _) => data.x,
                              yValueMapper: (ChartColumnData data, _) =>
                                  data.y),
                          ColumnSeries<ChartColumnData, String>(
                              dataSource: chartData,
                              width: 0.8,
                              color: Color(0xFFFFBF1A),
                              xValueMapper: (ChartColumnData data, _) => data.x,
                              yValueMapper: (ChartColumnData data, _) =>
                                  data.y1)
                        ],
                      ),
                      SizedBox(
                        height: psHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Color(0xFF2FEA9B),
                              ),
                              SizedBox(
                                width: psWidth(10),
                              ),
                              TextCustom(
                                text: "Số môn học hôm nay",
                                fontSize: psHeight(12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Color(0xFFFFBF1A),
                              ),
                              SizedBox(
                                width: psWidth(10),
                              ),
                              TextCustom(
                                text: "Số môn đã checkin",
                                fontSize: psHeight(12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: psHeight(20),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  TextCustom(
                                      text:
                                          'Biểu đồ số lần điểm danh theo tuần',
                                      fontSize: psHeight(18),
                                      fontWeight: FontWeight.bold)
                                ],
                              )),
                        ],
                      ),
                      SfCartesianChart(
                        margin: const EdgeInsets.all(10),
                        borderWidth: 0,
                        plotAreaBorderWidth: 0,
                        primaryXAxis: CategoryAxis(isVisible: true),
                        primaryYAxis: CategoryAxis(
                            isVisible: true,
                            minimum: 0,
                            maximum: 5,
                            interval: 1),
                        series: <CartesianSeries>[
                          ColumnSeries<ChartColumnDataweek, String>(
                              dataSource: repository.listChartColumnDataweek,
                              width: 0.8,
                              color: Color(0xFF967CFD),
                              xValueMapper: (ChartColumnDataweek data, _) =>
                                  data.x,
                              yValueMapper: (ChartColumnDataweek data, _) =>
                                  data.y),
                          ColumnSeries<ChartColumnDataweek, String>(
                              dataSource: repository.listChartColumnDataweek,
                              width: 0.8,
                              color: Color(0xFFFF4080),
                              xValueMapper: (ChartColumnDataweek data, _) =>
                                  data.x,
                              yValueMapper: (ChartColumnDataweek data, _) =>
                                  data.y1)
                        ],
                      ),
                      SizedBox(
                        height: psHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Color(0xFF967CFD),
                              ),
                              SizedBox(
                                width: psWidth(10),
                              ),
                              TextCustom(
                                text: "Số môn học",
                                fontSize: psHeight(12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 15,
                                width: 30,
                                color: Color(0xFFFF4080),
                              ),
                              SizedBox(
                                width: psWidth(10),
                              ),
                              TextCustom(
                                text: "Số môn checkin",
                                fontSize: psHeight(12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChartColumnData {
  ChartColumnData(this.x, this.y, this.y1);
  final String x;
  final int? y;
  final int? y1;
}

class ChartColumnDataweek {
  ChartColumnDataweek({this.x, this.y, this.y1});
  String? x;
  int? y;
  int? y1;
  factory ChartColumnDataweek.fromJson(Map<dynamic, dynamic> json) {
    return ChartColumnDataweek(
        x: json['day'], y: json['totalSubjects'], y1: json['checkedOutCount']);
  }
}
