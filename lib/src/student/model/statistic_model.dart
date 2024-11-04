import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomColumnSeriesRenderer extends ColumnSeriesRenderer {
  CustomColumnSeriesRenderer();

  @override
  ColumnSegment createSegment() {
    return ColumnCustomPainter();
  }
}

class ColumnCustomPainter extends ColumnSegment {
  final colorList = [
    const Color.fromRGBO(53, 92, 125, 1),
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1)
  ];

  @override
  Paint getFillPaint() {
    final Paint customerFillPaint = Paint();
    customerFillPaint.isAntiAlias = false;
    customerFillPaint.color = colorList[currentSegmentIndex! % colorList.length];
    customerFillPaint.style = PaintingStyle.fill;
    return customerFillPaint;
  }
}
class ChartSampleData {
  ChartSampleData({this.x, this.y});

  final dynamic x;
  final num? y;
}
