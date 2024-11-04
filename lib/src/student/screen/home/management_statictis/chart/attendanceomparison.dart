import 'dart:math';
import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:findy/widget/text/textcustom.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class BarChartSample8 extends StatefulWidget {
  BarChartSample8({super.key});

  final Color barBackgroundColor =
      AppColor.barchartColor.withOpacity(0.3);
  final Color barColor = AppColor.barchartColor;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample8> {
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
          text: "Số lần điểm danh theo tuần",
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
      body: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.graphic_eq),
                  const SizedBox(
                    width: 32,
                  ),
                  Text(
                    'Số lần điểm danh trong tuần',
                    style: TextStyle(
                      color: widget.barColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: BarChart(
                  randomData(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: x >= 5 ? Colors.transparent : widget.barColor,
          borderRadius: BorderRadius.zero,
          borderDashArray: x >= 5 ? [5, 5] : null,
          width: 22,
          borderSide: BorderSide(color: widget.barColor, width: 2.0),
        ),
      ],
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColor.barchartColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    Widget text = Text(
      days[value.toInt()],
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      maxY: 300.0,
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 50,
            showTitles: true,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(
        7,
        (i) => makeGroupData(
          i,
          Random().nextInt(290).toDouble() + 10,
        ),
      ),
      gridData: const FlGridData(show: false),
    );
  }
}