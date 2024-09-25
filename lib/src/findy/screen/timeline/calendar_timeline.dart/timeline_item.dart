import 'dart:math'; // Import to generate random numbers
import 'package:findy/constant/color.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatefulWidget {
  final String monhoc;
  final String starttime;
  final String? endtime;
  const TimelineItem({
    super.key,
    required this.monhoc,
    required this.starttime,
     this.endtime,
  });

  @override
  State<TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<TimelineItem> {
  // Predefined list of colors and icons
  final List<Color> iconBackgroundColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple
  ];

  late Color randomColor;
  late IconData randomIcon;

  @override
  void initState() {
    super.initState();
    // Randomly select a color and an icon
    randomColor =
        iconBackgroundColors[Random().nextInt(iconBackgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColor.appBgColor,
      padding:
          EdgeInsets.symmetric(horizontal: psWidth(10), vertical: psHeight(0)),
      margin: EdgeInsets.all(psHeight(6)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: psHeight(10),
                width: psWidth(10),
                decoration: BoxDecoration(
                  color: randomColor.withOpacity(1),
                  borderRadius: BorderRadius.circular(psHeight(5)),
                ),
              ),
              SizedBox(width: psWidth(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.monhoc,
                      style: TextStyle(
                          fontSize: psHeight(14),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.starttime,
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                        SizedBox(width: psWidth(4),),
                        Text(
                          "- ${widget.endtime}",
                          style: TextStyle(
                              fontSize: psHeight(12),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              color: AppColor.textGrey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
