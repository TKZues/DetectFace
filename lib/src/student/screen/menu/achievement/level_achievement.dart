import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LevelAchievement extends StatefulWidget {
  const LevelAchievement({super.key});

  @override
  State<LevelAchievement> createState() => _LevelAchievementState();
}

class _LevelAchievementState extends State<LevelAchievement> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(psHeight(20)),
      ),
      color: Colors.white,
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(psHeight(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: psHeight(30),
                  width: psWidth(30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(psHeight(25)),
                      color: Colors.black),
                  child: const Align(
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: psWidth(10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: "Level 2 ",
                      fontSize: psHeight(14),
                      fontWeight: FontWeight.bold,
                    ),
                    TextCustom(
                      text: "500 Points to next level",
                      fontSize: psHeight(12),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF9098A3),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: psHeight(80),
              child: Stack(
                children: [
                  SfCartesianChart(
                    plotAreaBackgroundColor: Colors.transparent,
                    borderWidth: 0,
                    plotAreaBorderWidth: 0,
                    enableSideBySideSeriesPlacement: false,
                    primaryXAxis: CategoryAxis(isVisible: false),
                    primaryYAxis: NumericAxis(
                        isVisible: false,
                        minimum: 0,
                        maximum: 10,
                        interval: 0.1),
                    series: <CartesianSeries>[
                      BarSeries(
                        dataLabelMapper: (data, _) => "${data.y1}/${data.y}",
                        dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 12),
                        labelAlignment: ChartDataLabelAlignment.middle,
                        labelPosition: ChartDataLabelPosition.inside),
                        borderRadius: BorderRadius.circular(psHeight(20)),
                        width: 0.6,
                        color: const Color(0xFFFFCE51).withOpacity(0.25),
                        dataSource: <LevelAchievementBarData>[
                          LevelAchievementBarData(x: 'TTTBDD', y: 10, y1: 8),
                        ],
                        xValueMapper: (sales, _) => sales.x as String,
                        yValueMapper: (sales, _) => sales.y,
                      ),
                      BarSeries(
                        borderRadius: BorderRadius.circular(psHeight(20)),
                        width: 0.5,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF3B14E), Color(0xFFFFCE51)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        dataSource: <LevelAchievementBarData>[
                          LevelAchievementBarData(x: 'TTTBDD', y: 10, y1: 8),
                        ],
                        xValueMapper: (sales, _) => sales.x as String,
                        yValueMapper: (sales, _) => sales.y1,
                      )
                    ],
                  ),
                  Positioned(
                    left: psWidth(8),
                    top: psHeight(25),
                    child: Container(
                      height: psHeight(30),
                      width: psWidth(30),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 253, 174, 56), width: 2),
                        borderRadius: BorderRadius.circular(psHeight(25)),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF3B14E), Color(0xFFFFCE51)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Align(
                        child: Text(
                          "2",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: psWidth(8),
                    top: psHeight(25),
                    child: Container(
                      height: psHeight(30),
                      width: psWidth(30),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 235, 190, 76).withOpacity(0.25), width: 2),
                        borderRadius: BorderRadius.circular(psHeight(25)),
                        color: const Color(0xFFFFCE51).withOpacity(0.25),
                      ),
                      child: const Align(
                        child: Text(
                          "3",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LevelAchievementBarData {
  LevelAchievementBarData({
    this.x,
    this.y,
    this.y1,
  });

  final dynamic x;
  final num? y;
  final num? y1;
}

