import 'package:findy/src/teacher/repositories/attendance_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:findy/src/student/repositories/attendance_repositories.dart';
import 'package:findy/utils/config/size_config.dart';

// ignore: must_be_immutable
class TimeLineCustom extends StatefulWidget {
  AttendanceRepositories? rp;
  TimeLineCustom({
    super.key,
    this.rp,
  });

  @override
  State<TimeLineCustom> createState() => _TimeLineCustomState();
}

class _TimeLineCustomState extends State<TimeLineCustom> {
  DateTime _selectedValue = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _showDateTimePicker = false; // Boolean flag to control visibility

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    dateController.text = DateFormat('dd/MM/yyyy').format(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DateTime Picker with Icon (visible based on _showDateTimePicker)
        IconButton(
          icon: Icon(_showDateTimePicker
              ? Icons.arrow_drop_up
              : Icons.calendar_today_outlined),
          onPressed: () {
            setState(() {
              _showDateTimePicker = !_showDateTimePicker; // Toggle visibility
            });
          },
        ),
        Visibility(
          visible: _showDateTimePicker,
          child: datetimePicker(dateController, context),
        ),
        // DatePicker Timeline (Always visible, but date will be updated from _showDateTimePicker)
        Container(
          margin: EdgeInsets.only(top: psHeight(10), left: psHeight(10)),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: 2)),
            height: 100,
            width: 80,
            inactiveDates: [
              DateTime.now().add(Duration(days: 3)),
              DateTime.now().add(Duration(days: 4)),
              DateTime.now().add(Duration(days: 7)),
            ],
            initialSelectedDate: _selectedValue, // Reflecting the same date
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              fontSize: psHeight(18),
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            onDateChange: (selectedDate) {
              setState(() {
                // Update _selectedValue and TextField when the user selects a date from DatePicker
                _selectedValue = selectedDate;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(_selectedValue);

                // Optionally call a function on date change
                String day = DateFormat('dd-MM-yyyy').format(_selectedValue);
                widget.rp?.getinout(day);
                widget.rp?.getnoinout(day);
              });
            },
          ),
        ),

        // Conditional rendering of the Cupertino DateTime Picker
      ],
    );
  }

  Widget datetimePicker(
      TextEditingController dateController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDateTimePickerModal(dateController);
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: dateController,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
            hintText: "Chọn ngày và giờ",
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDateTimePickerModal(
      TextEditingController dateController) async {
    DateTime selectedDateTime =
        _selectedValue; // Start with the current selected date

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                // Update the selected date for both widgets
                _selectedValue = newDateTime;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);

                // Sync with the DatePicker
                String day = DateFormat('dd-MM-yyyy').format(newDateTime);
                widget.rp?.getinout(day);
              });
            },
          ),
        );
      },
    );
  }
}



// ignore: must_be_immutable
class TimeLineCustomClass extends StatefulWidget {
  AttendanceRepositories? rp;
  TimeLineCustomClass({
    super.key,
    this.rp,
  });

  @override
  State<TimeLineCustomClass> createState() => _TimeLineCustomClassState();
}

class _TimeLineCustomClassState extends State<TimeLineCustomClass> {
  DateTime _selectedValue = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _showDateTimePicker = false; // Boolean flag to control visibility

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    dateController.text = DateFormat('yyyy-MM-dd').format(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DateTime Picker with Icon (visible based on _showDateTimePicker)
        IconButton(
          icon: Icon(_showDateTimePicker
              ? Icons.arrow_drop_up
              : Icons.calendar_today_outlined),
          onPressed: () {
            setState(() {
              _showDateTimePicker = !_showDateTimePicker; // Toggle visibility
            });
          },
        ),
        Visibility(
          visible: _showDateTimePicker,
          child: datetimePicker(dateController, context),
        ),
        // DatePicker Timeline (Always visible, but date will be updated from _showDateTimePicker)
        Container(
          margin: EdgeInsets.only(top: psHeight(10), left: psHeight(10)),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: 2)),
            height: 100,
            width: 80,
            inactiveDates: [
              DateTime.now().add(Duration(days: 3)),
              DateTime.now().add(Duration(days: 4)),
              DateTime.now().add(Duration(days: 7)),
            ],
            initialSelectedDate: _selectedValue, // Reflecting the same date
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              fontSize: psHeight(18),
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            onDateChange: (selectedDate) {
              setState(() {
                // Update _selectedValue and TextField when the user selects a date from DatePicker
                _selectedValue = selectedDate;
                dateController.text =
                    DateFormat('yyyy-MM-dd').format(_selectedValue);

                // Optionally call a function on date change
                String day = DateFormat('yyyy-MM-dd').format(_selectedValue);
                widget.rp?.getclassesbyid(day);
              });
            },
          ),
        ),

        // Conditional rendering of the Cupertino DateTime Picker
      ],
    );
  }

  Widget datetimePicker(
      TextEditingController dateController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDateTimePickerModal(dateController);
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: dateController,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
            hintText: "Chọn ngày và giờ",
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDateTimePickerModal(
      TextEditingController dateController) async {
    DateTime selectedDateTime =
        _selectedValue; // Start with the current selected date

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                // Update the selected date for both widgets
                _selectedValue = newDateTime;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);

                // Sync with the DatePicker
                String day = DateFormat('dd-MM-yyyy').format(newDateTime);
                widget.rp?.getinout(day);
              });
            },
          ),
        );
      },
    );
  }
}





// ignore: must_be_immutable
class TimeLineCustom1 extends StatefulWidget {
  AttendanceRepositories1? rp;
  TimeLineCustom1({
    super.key,
    this.rp,
  });

  @override
  State<TimeLineCustom1> createState() => _TimeLineCustom1State();
}

class _TimeLineCustom1State extends State<TimeLineCustom1> {
  DateTime _selectedValue = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _showDateTimePicker = false; // Boolean flag to control visibility

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    dateController.text = DateFormat('dd/MM/yyyy').format(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DateTime Picker with Icon (visible based on _showDateTimePicker)
        IconButton(
          icon: Icon(_showDateTimePicker
              ? Icons.arrow_drop_up
              : Icons.calendar_today_outlined),
          onPressed: () {
            setState(() {
              _showDateTimePicker = !_showDateTimePicker; // Toggle visibility
            });
          },
        ),
        Visibility(
          visible: _showDateTimePicker,
          child: datetimePicker(dateController, context),
        ),
        // DatePicker Timeline (Always visible, but date will be updated from _showDateTimePicker)
        Container(
          margin: EdgeInsets.only(top: psHeight(10), left: psHeight(10)),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: 2)),
            height: 100,
            width: 80,
            inactiveDates: [
              DateTime.now().add(Duration(days: 3)),
              DateTime.now().add(Duration(days: 4)),
              DateTime.now().add(Duration(days: 7)),
            ],
            initialSelectedDate: _selectedValue, // Reflecting the same date
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              fontSize: psHeight(18),
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            onDateChange: (selectedDate) {
              setState(() {
                // Update _selectedValue and TextField when the user selects a date from DatePicker
                _selectedValue = selectedDate;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(_selectedValue);

                // Optionally call a function on date change
                String day = DateFormat('dd-MM-yyyy').format(_selectedValue);
                widget.rp?.getinout(day);
                widget.rp?.getnoinout(day);
              });
            },
          ),
        ),

        // Conditional rendering of the Cupertino DateTime Picker
      ],
    );
  }

  Widget datetimePicker(
      TextEditingController dateController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDateTimePickerModal(dateController);
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: dateController,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
            hintText: "Chọn ngày và giờ",
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDateTimePickerModal(
      TextEditingController dateController) async {
    DateTime selectedDateTime =
        _selectedValue; // Start with the current selected date

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                // Update the selected date for both widgets
                _selectedValue = newDateTime;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);

                // Sync with the DatePicker
                String day = DateFormat('dd-MM-yyyy').format(newDateTime);
                widget.rp?.getinout(day);
              });
            },
          ),
        );
      },
    );
  }
}



// ignore: must_be_immutable
class TimeLineCustomClass1 extends StatefulWidget {
  AttendanceRepositories1? rp;
  TimeLineCustomClass1({
    super.key,
    this.rp,
  });

  @override
  State<TimeLineCustomClass1> createState() => _TimeLineCustomClass1State();
}

class _TimeLineCustomClass1State extends State<TimeLineCustomClass1> {
  DateTime _selectedValue = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _showDateTimePicker = false; // Boolean flag to control visibility

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    dateController.text = DateFormat('yyyy-MM-dd').format(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DateTime Picker with Icon (visible based on _showDateTimePicker)
        IconButton(
          icon: Icon(_showDateTimePicker
              ? Icons.arrow_drop_up
              : Icons.calendar_today_outlined),
          onPressed: () {
            setState(() {
              _showDateTimePicker = !_showDateTimePicker; // Toggle visibility
            });
          },
        ),
        Visibility(
          visible: _showDateTimePicker,
          child: datetimePicker(dateController, context),
        ),
        // DatePicker Timeline (Always visible, but date will be updated from _showDateTimePicker)
        Container(
          margin: EdgeInsets.only(top: psHeight(10), left: psHeight(10)),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: 2)),
            height: 100,
            width: 80,
            inactiveDates: [
              DateTime.now().add(Duration(days: 3)),
              DateTime.now().add(Duration(days: 4)),
              DateTime.now().add(Duration(days: 7)),
            ],
            initialSelectedDate: _selectedValue, // Reflecting the same date
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            dateTextStyle: TextStyle(
              fontSize: psHeight(18),
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            onDateChange: (selectedDate) {
              setState(() {
                // Update _selectedValue and TextField when the user selects a date from DatePicker
                _selectedValue = selectedDate;
                dateController.text =
                    DateFormat('yyyy-MM-dd').format(_selectedValue);

                // Optionally call a function on date change
                String day = DateFormat('yyyy-MM-dd').format(_selectedValue);
                widget.rp?.getclassesbyid(day);
              });
            },
          ),
        ),

        // Conditional rendering of the Cupertino DateTime Picker
      ],
    );
  }

  Widget datetimePicker(
      TextEditingController dateController, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDateTimePickerModal(dateController);
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          controller: dateController,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              size: 20,
              color: Colors.grey.shade600,
            ),
            hintText: "Chọn ngày và giờ",
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDateTimePickerModal(
      TextEditingController dateController) async {
    DateTime selectedDateTime =
        _selectedValue; // Start with the current selected date

    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 300,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: selectedDateTime,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                // Update the selected date for both widgets
                _selectedValue = newDateTime;
                dateController.text =
                    DateFormat('dd/MM/yyyy').format(newDateTime);

                // Sync with the DatePicker
                String day = DateFormat('dd-MM-yyyy').format(newDateTime);
                widget.rp?.getinout(day);
              });
            },
          ),
        );
      },
    );
  }
}
