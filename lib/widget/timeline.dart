// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:findy/src/findy/repositories/attendance_repositories.dart';
import 'package:findy/utils/config/size_config.dart';

// ignore: must_be_immutable
class TimeLineCustom extends StatefulWidget {
  AttendanceRepositories rp;
  TimeLineCustom({
    super.key,
    required this.rp,
  });

  @override
  State<TimeLineCustom> createState() => _TimeLineCustomState();
}

class _TimeLineCustomState extends State<TimeLineCustom> {
  DateTime _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: psHeight(10), left: psHeight(10)),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.black,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyle(
            fontSize: psHeight(18),
            fontWeight: FontWeight.w600,
            color: Colors.grey),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedValue = selectedDate;
            String day = DateFormat('dd-MM-yyyy').format(_selectedValue);
            widget.rp.getinout(day);
          });
        },
      ),
    );
  }
}
