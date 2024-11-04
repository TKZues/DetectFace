
import 'package:findy/constant/color.dart';
import 'package:findy/src/teacher/screen/timeline/calendar_timeline.dart/calendar_timeline.dart';
import 'package:findy/utils/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../../widget/text/textcustom.dart';

class TimeLineApp extends StatefulWidget {
  const TimeLineApp({super.key});

  @override
  State<TimeLineApp> createState() => _TimeLineAppState();
}

class _TimeLineAppState extends State<TimeLineApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
            backgroundColor: AppColor.appbarColor,
            centerTitle: true,
            title: TextCustom(
              text: "Thời gian biểu",
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
      body: const CalendarTimeline()
    );
  }
}